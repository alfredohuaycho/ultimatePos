<?php
namespace App\Modules\Siat\Models;

use App\Contact;
use App\Modules\Siat\Entities\Invoice;
use App\Modules\Siat\Entities\InvoiceItem;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\SiatConfig;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\SiatFactory;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\InvoiceDetail;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SiatInvoice;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioSiat;
use Exception;
use App\Modules\Siat\Classes\ExceptionInvalidInvoiceData;
use App\User;
use Milon\Barcode\QRcode;
use Dompdf\Dompdf;
use Milon\Barcode\DNS2D;
use App\Transaction;
use App\Modules\Siat\Entities\Batch;

class InvoiceModel extends SiatModel
{
	/**
	 * @var SyncModel
	 */
	protected	$syncModel;
	/**
	 * @var EventsModel
	 */
	protected	$eventosModel;
	
	public function __construct(SyncModel $syncModel, EventsModel $evtModel)
	{
		$this->syncModel 	= $syncModel;
		$this->eventosModel = $evtModel;
	}
	/**
	 * Asigna campos personalizados de todos los items de la factura a los detalles SIAT
	 * @param Invoice $invoice
	 * @param SiatInvoice $siatInvoice
	 */
	protected function bindInvoiceCustomFields(Invoice $invoice, SiatInvoice $siatInvoice)
	{
		$this->bindInvoiceDetailCustomFields($invoice, $siatInvoice);
		foreach($invoice->items as $index => $item)
		{
			$this->bindInvoiceItemCustomField($item, $siatInvoice->detalle[$index]);
		}
	}
	protected function bindInvoiceHeaderCustomFields(Invoice $invoice, SiatInvoice $siatInvoice)
	{
		$data = ($invoice->data && (is_array($invoice->data)) || is_object($invoice->data)) ? (object)$invoice->data : null;
		if( !$data )
			return;
		if( !isset($data->custom_fields) || (!is_object($data->custom_fields) && !is_array($data->custom_fields)) )
			return;
		//print_r($data->custom_fields);die;
		foreach($data->custom_fields as $field => $field_value)
		{
			if( !property_exists($siatInvoice->cabecera, $field) )
				continue;
			$siatInvoice->cabecera->$field = $field_value;
		}
	}
	/**
	 * Asigna campos personalizados del item de factura al detalle SIAT
	 * @param InvoiceItem $item
	 * @param InvoiceDetail $siatItem
	 */
	protected function bindInvoiceItemCustomField(InvoiceItem $item, InvoiceDetail $siatItem)
	{
		if( !isset($item->data->custom_fields) || !is_object($item->data->custom_fields) )
			return;
		//print_r($item->data->custom_fields);
		foreach($item->data->custom_fields as $field => $field_value)
		{
			if( !property_exists($siatItem, $field) )
				continue;
				$siatItem->$field = $field_value;
		}
	}
	protected function sanitizeXmlText($str)
	{
		return str_replace(['<', '>', '&', "'", '"'], ['&#60;', '&#62;', '&#38;', '&#39;', '&#34;'], $str);
	}
	protected function invoiceToSiatInvoice(Invoice $invoice)
	{
		//$config 		= $this->getUserConfig($user, $invoice->codigo_sucursal, $invoice->punto_venta);
		//$customer 		= $invoice->getCustomer();
		$config 		= $this->getConfig();
		$cufd			= $this->getCufd($config, null, $invoice->codigo_sucursal, $invoice->codigo_puntoventa);
		$user			= User::find($invoice->user_id);
		$detailClass 	= InvoiceDetail::class;
		$facturaSiat 	= SiatFactory::construirFacturaSector($invoice->codigo_documento_sector, $config->modalidad, $detailClass);
		//var_dump($invoice->codigo_documento_sector);die($detailClass);
		//$montoTotal = ($invoice->subtotal - $facturaSiat->cabecera->descuentoAdicional);
		$montoTotal = ($invoice->subtotal - $invoice->discount);
		$facturaSiat->cabecera->tipoCambio						= sb_number_format($invoice->tipo_cambio);
		$facturaSiat->cabecera->codigoCliente 					= $invoice->codigo_documento_sector != 23 ? $invoice->getCustomer()->contact_id : 'N/A';
		$facturaSiat->cabecera->codigoDocumentoSector 			= $invoice->codigo_documento_sector;
		$facturaSiat->cabecera->codigoMetodoPago				= $invoice->codigo_metodo_pago;
		$facturaSiat->cabecera->numeroTarjeta					= $invoice->numero_tarjeta ?: null;
		$facturaSiat->cabecera->codigoMoneda					= $invoice->codigo_moneda;
		$facturaSiat->cabecera->codigoPuntoVenta				= $invoice->codigo_puntoventa;
		$facturaSiat->cabecera->codigoSucursal					= $invoice->codigo_sucursal;
		$facturaSiat->cabecera->codigoTipoDocumentoIdentidad	= $invoice->tipo_documento_identidad;
		$facturaSiat->cabecera->complemento						= $invoice->complemento;
		$facturaSiat->cabecera->cuf								= $invoice->cuf ?: null;
		$facturaSiat->cabecera->cafc							= $invoice->cafc ?: null;
		$facturaSiat->cabecera->cufd							= $invoice->cufd ?: $cufd->codigo;
		$facturaSiat->cabecera->descuentoAdicional				= $invoice->discount ?: 0;
		$facturaSiat->cabecera->direccion						= $cufd ? $cufd->direccion : ''; //$customer->address_1;
		$facturaSiat->cabecera->fechaEmision					= date(SIAT_DATETIME_FORMAT, strtotime($invoice->invoice_datetime));
		$facturaSiat->cabecera->montoGiftCard					= $invoice->monto_giftcard > 0 ? $invoice->monto_giftcard : null;
		$facturaSiat->cabecera->montoTotal						= sb_number_format($montoTotal, 2, '.', '');
		$facturaSiat->cabecera->montoTotalMoneda				= sb_number_format($facturaSiat->cabecera->tipoCambio > 0 ? $montoTotal / $facturaSiat->cabecera->tipoCambio : $montoTotal, 2, '.', '');
		$facturaSiat->cabecera->montoTotalSujetoIva				= 0;
		if( !in_array($invoice->codigo_documento_sector, [6, 8, 28]) )
			$facturaSiat->cabecera->montoTotalSujetoIva = sb_number_format($montoTotal - $facturaSiat->cabecera->montoGiftCard, 2, '.', '');
		$facturaSiat->cabecera->municipio						= $config->ciudad ?: 'La Paz';
		$facturaSiat->cabecera->nitEmisor						= $config->nit;
		//$facturaSiat->cabecera->nombreRazonSocial				= htmlentities($invoice->customer);
		$facturaSiat->cabecera->nombreRazonSocial				= $this->sanitizeXmlText($invoice->customer);
		//htmlentities($invoice->customer/*$customer->GetBillingName()*/);//$invoice->customer;
		$facturaSiat->cabecera->numeroDocumento					= $invoice->nit_ruc_nif;
		$facturaSiat->cabecera->numeroFactura					= ((int)$invoice->invoice_number_cafc > 0) ? 
			$invoice->invoice_number_cafc : 
			$invoice->invoice_number;
		$facturaSiat->cabecera->razonSocialEmisor				= $config->razonSocial;
		$facturaSiat->cabecera->telefono						= $config->telefono ?: '77777777'; //empty($customer->phone) ? '77777777' : $customer->phone;
		$facturaSiat->cabecera->usuario							= $user->username;
		$facturaSiat->cabecera->leyenda							= $invoice->leyenda ?: $facturaSiat->cabecera->leyenda;
		//var_dump(htmlentities($facturaSiat->cabecera->nombreRazonSocial));die;
		if( isset($invoice->excepcion) && (int)$invoice->excepcion == 1 )
			$facturaSiat->cabecera->codigoExcepcion = 1;
			
		//if( $invoice->cafc )
		//	$facturaSiat->cabecera->cafc = $invoice->cafc;
		$this->bindInvoiceHeaderCustomFields($invoice, $facturaSiat);
		
		foreach($invoice->getItems() as $item)
		{
			$detalle = new $detailClass();
			$detalle->actividadEconomica 	= $item->codigo_actividad;
			$detalle->codigoProductoSin 	= $item->codigo_producto_sin;
			$detalle->codigoProducto		= $item->product_code;
			$detalle->descripcion			= $item->product_name;
			$detalle->cantidad				= $item->quantity;
			$detalle->unidadMedida			= $item->unidad_medida;
			$detalle->precioUnitario		= sb_number_format($item->price, 2, '.', '');
			$detalle->montoDescuento		= sb_number_format($item->discount, 2, '.', '');
			$detalle->subTotal				= sb_number_format($item->total, 2, '.', '');
			$detalle->numeroSerie			= $item->numero_serie != null ? $item->numero_serie : null;
			$detalle->numeroImei			= $item->numero_imei != null ? $item->numero_imei : null;
			$this->bindInvoiceItemCustomField($item, $detalle);
			$detalle->validate();
			$facturaSiat->detalle[] = $detalle;
		}
		//print_r($facturaSiat->detalle);die;
		return $facturaSiat;
	}
	public function invoicesToSiat(array $invoices)
	{
		$items = [];
		foreach($invoices as $inv)
		{
			$item = $this->invoiceToSiatInvoice($inv);
			$items[] = $item;
		}
		
		return $items;
	}
	public function create(Invoice $invoice)
	{
		if( $invoice->codigo_documento_sector == 23 )
		{
			$invoice->nit_ruc_nif = 0;
			$invoice->customer = 'S/N';
		}
		elseif( empty($invoice->nit_ruc_nif) )
			throw new Exception('Invalid invoice NIT/RUC/NIF');
		//if( !$invoice->total )
		//	throw new Exception(__('Invalid invoice amount', 'invoices'));
		if( !$invoice->invoice_datetime )
			throw new Exception('Invalid invoice date and time');
		if( !$invoice->user_id )
			throw new Exception('Invalid invoice user');
		if( (int)$invoice->customer_id <= 0 )
			throw new Exception('Invalid customer identifier');
		if( !$invoice->customer )
			throw new Exception('Invalid customer billing name');
		//if( !$invoice->currency_code )
		//	$invoice->currency_code = 'BOB';
		$customer = Contact::find($invoice->customer_id);
		if( !$customer )
			throw new Exception('Invalid customer');
		
		if( !$invoice->getSavedItems() || !count($invoice->getSavedItems()) )
			throw new Exception('The invoice has no items');
			
		$invoice->status	= Invoice::STATUS_ISSUED;
		
		foreach($invoice->getSavedItems() as $i)
		{
			$item = (object)$i;
			if( empty($item->product_code) )
				throw new Exception('El item de la factura no tiene codigo');
			if( empty($item->product_name) )
				throw new Exception('El item de la factura no tiene nombre');
			if( (int)$item->quantity <= 0 )
				throw new Exception('El item de la factura no tiene cantidad');
			if( (float)$item->price <= 0 )
				throw new Exception('El item de la factura no tiene precio');
			if( (int)$item->codigo_actividad <= 0 )
				throw new Exception('El item de la factura no tiene actividad economica');
			if( (int)$item->unidad_medida <= 0 )
				throw new Exception('El item de la factura no tiene unidad de medida');
			if( (int)$item->codigo_producto_sin <= 0 )
				throw new Exception('El item de la factura no codigo de producto SIN');
			if( $item->total <= 0 )
				throw new Exception('El subtotal de items no puede ser "0"');
		}
		$invoice->calculateTotals();
		if( $invoice->discount > 0 && $invoice->discount >= $invoice->subtotal )
			throw new Exception('El descuento no puede ser del total de la factura');
		
		$config = $this->getConfig();
		
		$invoice_number = $this->getNextInvoiceNumberBy('nit_emisor', $config->nit);
		if( (int)$invoice_number <= 0 )
			throw new Exception('La factura no tiene un numero asignado, no se puede emitir');
		$invoice->invoice_number = $invoice_number;
		//$leyenda = $this->obtenerLeyenda($user, $invoice->getSavedItems()[0]->codigo_actividad);
		$leyenda = $this->obtenerLeyenda($invoice->getSavedItems()[0]['codigo_actividad']);
		$invoice->leyenda = $leyenda;
		$invoice->ambiente = $config->ambiente;
		//$invoice->save();
		//$invoice->items()->createMany($items);
		$this->sendInvoice($invoice);
	}
	public function getNextInvoiceNumberBy($column, $value)
	{
		$count = Invoice::where($column, $value)->count();
		return $count + 1;
	}
	public function obtenerLeyenda(int $codigoActividad, int $sucursal = 0, int $puntoventa = 0)
	{
		$leyendas = $this->syncModel->getLeyendasFacturasS($sucursal, $puntoventa);
		//print_r($leyendas);die;
		$tl = count($leyendas->RespuestaListaParametricasLeyendas->listaLeyendas);
		if( !$tl )
			return null;
		if( $codigoActividad <= 0 )
			$text = $leyendas->RespuestaListaParametricasLeyendas->listaLeyendas[rand(0, $tl - 1)]->descripcionLeyenda;
		else
		{
			
			$items = [];
			foreach($leyendas->RespuestaListaParametricasLeyendas->listaLeyendas as $l)
			{
				if( $codigoActividad == $l->codigoActividad )
					$items[] = $l;
			}
			$tl = count($items);
			//var_dump($actividad);print_r($items);die(__FILE__);
			if( !$tl )
				return null;
				$text = $items[rand(0, $tl - 1)]->descripcionLeyenda;
		}
		return $text;
	}
	public function sendInvoice(Invoice $invoice)
	{
		
		//$user = SB_User::Get($invoice->user_id);
		//$config = $this->getUserConfig($user, $invoice->codigo_sucursal, $invoice->punto_venta);
		$config = $this->getUserConfig();
		//if( !$this->checkMainCodes($user, $invoice->codigo_sucursal, $invoice->punto_venta) )
		//	throw new ExceptionInvalidInvoiceData('Configuracion de usuario invalida, no se puede enviar la factura', null, $invoice);
		//$invoice_number = $this->invoiceModel->getNextInvoiceNumberBy('nit_emisor', $config->nit);
		//if( (int)$invoice_number <= 0 )
		//	throw new ExceptionInvalidInvoiceData('La factura no tiene un numero asignado, no se puede emitir', null, $invoice);
		//$invoice->invoice_number = $invoice_number;
		//$leyenda = $this->obtenerLeyenda($user, $invoice->items[0]->codigo_actividad);
		//var_dump($leyenda, $invoice->items[0]->codigo_actividad);die;
		if( in_array($invoice->codigo_documento_sector, [6, 8, 28]) )
		{
			$invoice->total_tax = 0;
		}
		//##check special codes
		if( in_array($invoice->nit_ruc_nif, ['99001', '99002', '99003']))
			$invoice->tipo_documento_identidad = 5;
				
		//print $facturaSiat->toXml()->asXML(); die;
		$facturaSiat = null;
		$evento = $this->eventosModel->obtenerEventoActivo($invoice->codigo_sucursal, $invoice->codigo_puntoventa);
		//##check for active event
		if( $evento )
		{
			//##obtener CUFD
			$cufd = $this->getCufdByCode($evento->cufd_evento);
			if( !$cufd )
				throw new Exception('El codigo CUFD del Evento registrado no existe en la base de datos');
			if( $evento->fecha_inicio && $evento->fecha_fin && $invoice->invoice_date_time )
				$this->eventosModel->isValidInvoiceDateTimes($evento, $invoice);
			//##si tipo documento NIT, forzar excepcion
			$invoice->excepcion = ($invoice->tipo_documento_identidad == 5) ? 1 : 0;
			//##validaciones CAFC
			if( in_array($evento->evento_id, [5, 6, 7]) )
			{
				$cafcData = $this->getSectorCafcData($invoice->codigo_documento_sector);
				//var_dump($$cafcData);die;
				if( empty(/*$config->cafc*/$cafcData) || !isset($cafcData->cafc) )
					throw new ExceptionInvalidInvoiceData('Codigo CAFC no asignado, no se puede generar la factura', null, $invoice);
				//if( (int)$config->cafc_inicio_nro_factura <= 0 )
				if( (int)$cafcData->inicio <= 0 )
					throw new ExceptionInvalidInvoiceData('Intervalo inicio nro de factura CAFC no asignado, no se puede generar la factura', null, $invoice);
				//if( (int)$config->cafc_fin_nro_factura <= 0 )
				if( (int)$cafcData->fin <= 0 )
					throw new ExceptionInvalidInvoiceData('Intervalo fin nro de factura CAFC no asignado, no se puede generar la factura', null, $invoice);
				if( (int)$invoice->invoice_number_cafc <= 0 )
					throw new ExceptionInvalidInvoiceData('El nro de factura CAFC no es valido, no se puede generar la factura', null, $invoice);
					/*if( (int)$invoice->data->nro_factura < (int)$config->cafc_inicio_nro_factura
					 || (int)$invoice->data->nro_factura > (int)$config->cafc_fin_nro_factura
					 )*/
				if( (int)$invoice->invoice_number_cafc < (int)$cafcData->inicio
					|| (int)$invoice->invoice_number_cafc > (int)$cafcData->fin
				)
					throw new ExceptionInvalidInvoiceData('El nro de factura CAFC no es valido, intervalo incorrecto, no se puede generar la factura', null, $invoice);
				//##verificar el numero de factura CAFC ya fue utilizado
				if( $this->cafcInvoiceExists($cafcData->cafc, (int)$invoice->invoice_number_cafc) )
					throw new ExceptionInvalidInvoiceData('El numero de factura CAFC no esta disponible', null, $invoice);
					
				//$invoice->cafc				= $evento->cafc;
				$invoice->cafc = $cafcData->cafc;
			}
			$invoice->tipo_emision 	= ( in_array($invoice->codigo_documento_sector, [23]) ) ? ServicioSiat::TIPO_EMISION_MASIVA : ServicioSiat::TIPO_EMISION_OFFLINE;
			$invoice->event_id 		= $evento->id;
			$invoice->control_code	= $cufd->codigo_control;
			$invoice->cufd			= $cufd->codigo;
			//print_r($invoice->items);die;
			$facturaSiat = $this->invoiceToSiatInvoice($invoice);
			if( !count($facturaSiat->detalle) )
				throw new Exception('La factura no tiene items, debe adicionar al menos uno');
			$facturaSiat->cabecera->checkAmounts();
			$facturaSiat->cabecera->cufd 	= $evento->cufd_evento;
			//$facturaSiat->cabecera->leyenda = $leyenda;
			$facturaSiat->buildCuf(0,
				$config->modalidad,
				$invoice->tipo_emision,
				$invoice->tipo_factura_documento,
				$cufd->codigo_control
			);
		}
		else
		{
			$invoice->tipo_emision 	= ( in_array($invoice->codigo_documento_sector, [23] ) ) ? 
					ServicioSiat::TIPO_EMISION_MASIVA : 
					ServicioSiat::TIPO_EMISION_ONLINE;
			if( $invoice->tipo_documento_identidad == 5 && (int)$invoice->excepcion != 1 )
			{
				$this->verificarNit((int)$invoice->nit_ruc_nif);
			}
			$facturaSiat = $this->invoiceToSiatInvoice($invoice);
			//$facturaSiat->cabecera->leyenda = $leyenda;
			$facturaSiat->cabecera->checkAmounts();
			$cuis = $this->getCuis($config, null, $invoice->codigo_sucursal, $invoice->codigo_puntoventa);
			$cufd = $this->getCufd($config, null, $invoice->codigo_sucursal, $invoice->codigo_puntoventa);
			//print_r($facturaSiat);die(__FILE__);
			//$service = self::obtenerServicioFacturaion($config, $user);
			if( !in_array($invoice->codigo_documento_sector, [23]) )
			{
				//print_r($cufd);die;
				$service = SiatFactory::obtenerServicioFacturacion($config, $cuis->codigo, $cufd->codigo, $cufd->codigo_control);
				$res = $service->recepcionFactura($facturaSiat, SiatInvoice::TIPO_EMISION_ONLINE, $invoice->tipo_factura_documento);
				$invoice->control_code	= $cufd->codigo_control;
				//print_r($res);die;
				if( $res->RespuestaServicioFacturacion->codigoEstado != 908 )
				{
					throw new ExceptionInvalidInvoiceData(
						'Ocurrio un error con la recepcion de la factura. SIAT: ' . \sb_siat_message($res->RespuestaServicioFacturacion),
						null,
						$invoice
						);
				}
				$invoice->siat_id 	= $res->RespuestaServicioFacturacion->codigoRecepcion;
			}
			else
			{
				$facturaSiat->buildCuf(0,
					$config->modalidad,
					$invoice->tipo_emision,
					$invoice->tipo_factura_documento,
					$cufd->codigo_control
				);
			}
			$invoice->cufd 		= $facturaSiat->cabecera->cufd;
		}
		
		$invoice->nit_emisor 	= $config->nit;
		$invoice->cuf			= $facturaSiat->cabecera->cuf;
		$invoice->save();
		$invoice->items()->saveMany($invoice->getItems());
		//print_r($invoice);die(__FILE__);
		//mb_invoice_update_meta($invoice->invoice_id, '_leyenda', $leyenda);
		if( $invoice->getCustomer()->email && ($invoice->tipo_emision != SiatInvoice::TIPO_EMISION_MASIVA) )
		{
			$invoiceNum = $facturaSiat->cabecera->numeroFactura;
			$fecha = sb_format_datetime($invoice->invoice_date_time);
			$pdf_filename = TEMP_DIR . SB_DS . 'factura-' . $invoiceNum . '.pdf';
			$tplSuffix = $config->tipoImpresion != 'page' ? $config->tipoImpresion : null;
			$pdf = $this->buildPdf($invoice, $tplSuffix);
			file_put_contents($pdf_filename, $pdf->output());
			$xml_filename = $this->buildXml($config, $invoice);
			//mb_invoice_update_meta($invoice->invoice_id, '_siat_xml', base64_encode(file_get_contents($xml_filename)));
			$message = "Estimado(a) {$invoice->customer}.\n\n".
				"Se adjunta los documentos fiscales\n" .
				"Factura: $invoiceNum\n".
				"Fecha: $fecha\n".
				"Monto: {$facturaSiat->cabecera->montoTotal}\n".
				"Codigo Autorización: {$facturaSiat->cabecera->cuf}\n";
			
			lt_mail($invoice->getCustomer()->email, sprintf("Factura - %s", SITE_TITLE), $message, null, [$xml_filename, $pdf_filename]);
			//unlink($pdf);
			unlink($xml_filename);
		}
		return true;
	}
	public function buildXml(SiatConfig $config, Invoice $invoice)
	{
		$facturaSiat = $this->invoiceToSiatInvoice($invoice);
		$servicio = SiatFactory::obtenerServicioFacturacion($config);
		//$servicio->recepcionFactura($factura);
		$xml = $servicio->buildInvoiceXml($facturaSiat);
		$temp_xml = TEMP_DIR . SB_DS . 'factura-' . $facturaSiat->cabecera->numeroFactura . '.xml';
		//$facturaSiat->toXml()->asXML($temp_xml);
		file_put_contents($temp_xml, $xml);
		return $temp_xml;
	}
	public function buildPdf(Invoice $invoice)
	{
		$syncModel		= $this->syncModel;
		$view_file 		= sprintf("Siat::invoices.invoice-ds-%d", $invoice->codigo_documento_sector);
		$logo			= null; //$this->getUserLogoFile($user);
		$logob64		= $logo ? base64_encode(file_get_contents($logo)) : null;
		$logo_mime		= $logo ? sb_get_file_mime($logo) : null;
		$config 		= $this->getConfig();
		$cufd 			= $this->getCufd($config, null, $invoice->codigo_sucursal, $invoice->codigo_puntoventa);
		$invoiceNum 	= ((int)$invoice->invoice_number_cafc > 0) ? $invoice->invoice_number_cafc : $invoice->invoice_number;
		$invoice_link 	= SiatInvoice::buildUrl($config->nit, $invoice->cuf, $invoiceNum, $invoice->ambiente); //b_route('/invoices/siat/' . $invoice->invoice_id . '/view');
		$qr64 			= 'data:image/png;base64,' . DNS2D::getBarcodePNG($invoice_link, 'QRCODE');
		$customer 		= $invoice->getCustomer();
		$view 			= view($view_file, get_defined_vars());
		$html 			= $view->render();
		$dompdf = new Dompdf();
		$dompdf->loadHtml($html);
		$dompdf->render();
		
		return $dompdf;
	}
	public function transaction2Invoice(Transaction $transaction)
	{
		
	}
	public function void(Invoice $invoice, object $obj)
	{
		if( (int)$obj->motivo_id <= 0 )
			throw new Exception('Codigo de anulacion invalido');
		
		$motivos = $this->syncModel->getMotivosAnulacionS($invoice->codigo_sucursal, $invoice->codigo_puntoventa);
		$motivo = null;
		foreach($motivos->RespuestaListaParametricas->listaCodigos as $ma)
		{
			if( $ma->codigoClasificador == $obj->motivo_id )
			{
				$motivo = $ma;
			}
		}
		if( !$motivo )
			throw new Exception('El motivo de anulacion no existe');
		$config		= $this->getConfig();
		//print_r($config);die;
		$cuis 		= $this->getCuis($config, null, $invoice->codigo_sucursal, $invoice->codigo_puntoventa);
		$cufd		= $this->getCufd($config, null, $invoice->codigo_sucursal, $invoice->codigo_puntoventa);
		$service 	= SiatFactory::obtenerServicioFacturacion($config, $cuis->codigo, $cufd->codigo, $cufd->codigo_control);
		//print_r($service);die;
		$res = $service->anulacionFactura(
			$motivo->codigoClasificador,
			$invoice->cuf,
			$invoice->codigo_sucursal,
			$invoice->codigo_puntoventa,
			$invoice->tipo_factura_documento,
			$invoice->tipo_emision,
			$invoice->codigo_documento_sector
		);
		//print_r($res);
		if( $res->RespuestaServicioFacturacion->codigoEstado != 905 )
			throw new Exception('No se pudo anular la factura. SIAT: ' . \sb_siat_message($res->RespuestaServicioFacturacion));
		$invoice->status = Invoice::STATUS_VOID;
		$invoice->save();
			//mb_invoice_update_meta($invoice->invoice_id, '_siat_void_code', $res->RespuestaServicioFacturacion->codigoRecepcion);
		$invoiceNum = (isset($invoice->invoice_number_cafc) && (int)$invoice->invoice_number_cafc > 0) ?
			(int)$invoice->invoice_number_cafc :
			$invoice->invoice_number;
		
		$siatInvoice = $this->invoiceToSiatInvoice($invoice);
		$customer = $invoice->getCustomer();
		if( $customer && $customer->email )
		{
			$pdf_filename = TEMP_DIR . SB_DS . 'factura-' . $invoice->invoice_id . '.pdf';
			$pdf = $this->buildPdf($user, $invoice);
			file_put_contents($pdf_filename, $pdf->output());
			$xml_filename = $this->buildXml($config, $invoice);
			$siat_url = SiatInvoice::buildUrl($invoice->nit_emisor, $invoice->cuf, $invoiceNum, $config->ambiente);
			$subject = sprintf("%s - Anulacion de Factura", SITE_TITLE);
			$message = "Hola {$customer->first_name} {$customer->last_name},<br><br>" .
			"Su factura fue anulada.<br>".
			"Datos de la factura.<br>".
			"Nro Factura: {$invoiceNum}<br>".
			"Monto: ". sb_number_format($siatInvoice->cabecera->montoTotal) . "<br>".
			"Fecha Anulacion: ". sb_format_datetime(time()) . "<br>".
			"Codigo Autorizacion: {$invoice->cuf}<br>".
			"Enlace: <a href='". $siat_url . "'>Abrir factura</a><br>".
			"<br>".
			SITE_TITLE;
			//$attachs = [$pdf_filename, $xml_filename];
			lt_mail($customer->email, $subject, $message, ['Content-Type: text/html'], null);
			unlink($xml_filename);
			unlink($pdf_filename);
		}
		
		return $res;
	}
	public function sendMassiveBatch(Batch $batch)
	{
		$invoices = Invoice::where('batch_id', $batch->id)->get();
		if( !count($invoices) )
			throw new Exception('El lote no tiene facturas');
		
		$siatInvoices = $this->invoicesToSiat($invoices);
		$config = $this->getConfig();
		$cuis = $this->getCuis($config, null, $batch->codigo_sucursal, $batch->codigo_puntoventa);
		$cufd = $this->getCufd($config, null, $batch->codigo_sucursal, $batch->codigo_puntoventa);
		$service = SiatFactory::obtenerServicioFacturacion($config, $cuis->codigo, $cufd->codigo, $cufd->codigo_control);
		$res = $service->recepcionMasivaFactura(
			$siatInvoices,
			SiatInvoice::TIPO_EMISION_MASIVA,
			$tipoFactura
		);
		$batch->codigo_recepcion = $res->RespuestaServicioFacturacion->codigoRecepcion;
		if( $res->RespuestaServicioFacturacion->codigoEstado != 901 )
		{
			$batch->save();
			throw new Exception('No se pudo realizar el envio del lote de facturas');
		}
		$this->validateMassiveBatch($batch);
		return $batch;
	}
	public function validateMassiveBatch(Batch $batch)
	{
		if( !$batch->codigo_recepcion )
			throw new Exception('No se puede validar el lote, no existe codigo de recepcion');
		$config = $this->getConfig();
		$cuis 	= $this->getCuis($config, null, $batch->codigo_sucursal, $batch->codigo_puntoventa);
		$cufd 	= $this->getCufd($config, null, $batch->codigo_sucursal, $batch->codigo_puntoventa);
		$service = SiatFactory::obtenerServicioFacturacion($config, $cuis->codigo, $cufd->codigo, $cufd->codigo_control);
		$res = $service->validacionRecepcionMasivaFactura($batch->codigo_sucursal, $batch->codigo_puntoventa, $batch->codigo_recepcion,
			$batch->tipo_factura_documento,
			$batch->codigo_documento_sector
		);
		$batch->codigo_recepcion = $res->RespuestaServicioFacturacion->codigoRecepcion;
		$batch->save();
		//if( $batch->codigo_recepcion != 901 )
		
	}
}