<?php
namespace App\Modules\Siat\Models;


use App\Modules\Siat\Entities\Event;
use Exception;
use App\Modules\Siat\Entities\Cufd;
use App\Modules\Siat\Entities\Package;
use App\Modules\Siat\Entities\PointOfSale;
use App\Modules\Siat\Entities\Invoice;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SiatInvoice;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioOperaciones;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\SiatConfig;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\SiatFactory;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Collection;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioSiat;

class EventsModel extends SiatModel
{
	/**
	 * @var OperationsModel
	 */
	protected	$siatOperacionesModel;
	/**
	 * @var SiatSyncModel
	 */
	protected	$siatSyncModel;
	/**
	 * @var InvoiceModel
	 */
	protected	$invoiceModel;
	
	public function __construct(OperationsModel $op, SyncModel $sync/*, InvoiceModel $invModel*/)
	{
		$this->siatOperacionesModel = $op;
		$this->siatSyncModel = $sync;
		//$this->invoiceModel = $invModel;
	}
	public function registrarEvento(Event $evento, $system = false)
	{
		if( (int)$evento->codigo_puntoventa < 0 )
			throw new Exception('Debe seleccionar el punto de venta');
		if( !$evento->evento_id )
			throw new Exception('Debe seleccionar el tipo de evento');
		if( !$evento->fecha_inicio )
			throw new Exception('Debe seleccionar el inicio del evento');
		if( !strtotime($evento->fecha_inicio) )
			throw new Exception('Formato de fecha de inicio invalida');
		if( (int)$evento->codigo_puntoventa > 0 )
		{
			$pv = PointOfSale::where('codigo', $evento->codigo_puntoventa)->first();
			if( !$pv )
				throw new Exception('El punto de venta no existe');
		}
		$config = $this->getConfig();
		//$config->validate();
		$cufd = $this->getCufd($config, null, $evento->codigo_sucursal, $evento->codigo_puntoventa);
		$evento->fecha_inicio = date('Y-m-d H:i:s', strtotime($evento->fecha_inicio));
		if( $evento->fecha_fin )
			$evento->fecha_fin = date('Y-m-d H:i:s', strtotime($evento->fecha_fin));
		
		if( strtotime($evento->fecha_inicio) > time() )
			throw new Exception('La fecha y hora del evento, no puede ser mayor a la fecha y hora actual');
		$eventoAbierto = $this->obtenerEventoPorFecha($evento->codigo_sucursal, $evento->codigo_puntoventa, date('Y-m-d', strtotime($evento->fecha_inicio)) );
		if( $eventoAbierto )
		{
			if( $eventoAbierto->status == Event::STATUS_OPEN )
				throw new Exception('Ya existe un evento registrado, cierre el evento antes de registrar uno nuevo');
		}
		$siatEvento = $this->siatSyncModel->getEventoPorCodigo(null, $evento->codigo_sucursal, $evento->codigo_puntoventa, $evento->evento_id);
		if( !$siatEvento )
			throw new Exception('El evento SIAT no existe');
			
		if( in_array($evento->evento_id, [5, 6, 7]) )
		{
			if( empty($evento->fecha_fin) )
			 	throw new Exception('Debe asignar una fecha de finalizacion');
		 	if( !strtotime($evento->fecha_fin) )
		 		throw new Exception('La fecha de finalizacion es invalida');
	 		if( strtotime($evento->fecha_fin) <= strtotime($evento->fecha_inicio) )
	 			throw new Exception('La fecha y hora fin del evento no puede ser inferior a la fecha y hora de inicio');
		 			
 			if( empty($evento->cufd_evento) )
 				throw new Exception('Debe asignar un CUFD para el evento');
 			/*
			$query = sprintf("SELECT id,creation_date FROM mb_siat_cufd WHERE user_id = %d AND sucursal_id = %d AND puntoventa_id = %d AND codigo = '%s' LIMIT 1",
				$user->user_id,
				$evento->sucursal_id,
				$evento->puntoventa_id,
				$evento->cufd_evento
			);
			*/
 			$cufd = Cufd::where('codigo_sucursal', $evento->codigo_sucursal)
 				->where('codigo_puntoventa', $evento->codigo_puntoventa)
 				->where('codigo', $evento->cufd_evento)
 				->first();
			if( !$cufd )
				throw new Exception('El CUFD para el evento no existe');
		 					
			//if( date('Y-m-d', strtotime($evento->fecha_inicio)) != date('Y-m-d', strtotime($cufd->creation_date)) )
			if( strtotime($evento->fecha_inicio) < strtotime($cufd->creation_date) )
				throw new Exception('La fecha de inicio no puede ser inferior a la fecha de creacion del CUFD');
			//if( strtotime($evento->fecha_inicio) > strtotime($cufd->fecha_vigencia) )
				//	throw new Exception('La fecha de inicio no puede ser mayor a la fecha de vigencia del CUFD');
 						
 						//##if( strtotime($evento->fecha_fin) > strtotime($cufd->fecha_vigencia) )
 						//##	throw new Exception('La fecha de finalizacion no puede ser mayor a la fecha de vigencia del CUFD');
 						//if( strtotime($evento->fecha_inicio) > strtotime($cufd->fecha_vigencia) )
 						//	throw new Exception('La fecha de inicio no puede ser mayor a la fecha de vigencia del CUFD');
 						//$evento->fecha_fin = date('Y-m-d H:i:s', strtotime($evento->fecha_fin));
 						//##obtener el CUFD de la fecha del evento
 						//if( $evento->fecha_inicio && $evento->fecha_fin )
 						//{
 						//	$cufdEvento = $this->siatInvoiceModel->getCufdDbByInitEndDate($user, $evento->fecha_inicio, $evento->fecha_fin, $evento->sucursal_id, $evento->puntoventa_id);
 						//}
 						//$evento->cafc = $config->cafc;
		}
		else
		{
			//$cufdEvento = $this->siatInvoiceModel->getCufdDbByDate($user, $evento->fecha_inicio, $evento->sucursal_id, $evento->puntoventa_id);
			//$cufdEvento = $this->siatInvoiceModel->getLatestDbCufd($user, $evento->sucursal_id, $evento->puntoventa_id);
			//if( !$cufdEvento )
			//	throw new Exception('No existe un CUFD para poder asignar al evento');
			//$evento->cufd_evento = $cufdEvento->codigo;
			$evento->cufd_evento = $cufd->codigo;
			$evento->fecha_fin = null;
		}
		$evento->estado = Event::STATUS_OPEN;
		$evento->descripcion = $siatEvento->descripcion;
		$evento->save();
		//##set event as manually created by user
		//sb_update_user_meta($user->user_id, '_SIAT_'. $evento->puntoventa_id . '_MANUAL_EVENT', $system ? 0 : $evento->evento_id);
	}
	/**
	 *
	 * @param int $sucursal
	 * @param int $puntoventa
	 * @param string $fecha
	 * @return Event
	 */
	public function obtenerEventoPorFecha(int $sucursal, int $puntoventa, $fecha)
	{
		$res = Event::where('codigo_sucursal', $sucursal)
			->where('codigo_puntoventa', $puntoventa)
			->whereDate('fecha_inicio', '=', $fecha);
		
		return $res->first();
	}
	/**
	 *
	 * @param int $sucursal
	 * @param int $puntoventa
	 * @param string $fecha
	 * @return Event
	 */
	public function obtenerEventosPorFecha(int $sucursal, int $puntoventa, $fecha)
	{
		$res = Event::where('codigo_sucursal', $sucursal)
			->where('codigo_puntoventa', $puntoventa)
			->whereDate('fecha_inicio', '=', $fecha);
		
		return $res->get();
	}
	public function consultarEventosSiat(int $sucursal, int $puntoventa, $fecha)
	{
		if( empty($fecha) )
			throw new Exception('Debe especificar la fecha del evento');
			$res = $this->siatOperacionesModel->consultarEventos($sucursal, $puntoventa, $fecha);
		return $res;
	}
	public function sync(int $sucursal, int $puntoventa, $fecha)
	{
		$res = $this->consultarEventosSiat($sucursal, $puntoventa, $fecha);
		
		if( isset($res->RespuestaListaEventos->mensajesList) )
			throw new Exception(sprintf("%d: %s", $res->RespuestaListaEventos->mensajesList->codigo, $res->RespuestaListaEventos->mensajesList->descripcion));
			
		if( !isset($res->RespuestaListaEventos) || !isset($res->RespuestaListaEventos->listaCodigos) )
			throw new Exception('Ocurrio un error al sincronizar eventos SIAT');
				
		foreach($res->RespuestaListaEventos->listaCodigos as $evt)
		{
			$repo = SB_Factory::getRepository(Evento::class);
			$repo->GetQuery()->where()
			->eq('sucursal_id', $sucursal)
			->eq('puntoventa_id', $puntoventa)
			->eq('user_id', $user->user_id)
			->eq('codigo_recepcion', $evt->codigoRecepcionEventoSignificativo);
			//->eq(new Column('DATE(mb_siat_eventos.fecha_inicio)', null), date('Y-m-d', strtotime($evt->fechaInicio)));
			if( $oldEvent = $repo->GetOne() )
			{
				if( $evt->fechaFin )
				{
					$oldEvent->fecha_fin = date('Y-m-d H:i:s', strtotime($evt->fechaFin));
					$oldEvent->status = Evento::STATUS_CLOSED;
				}
				$oldEvent->Save(0);
				continue;
			}
			$e = new Event();
			$e->user_id = $user->user_id;
			$e->evento_id = $evt->codigoEvento;
			$e->sucursal_id = $sucursal;
			$e->puntoventa_id = $puntoventa;
			$e->codigo_recepcion = $evt->codigoRecepcionEventoSignificativo;
			$e->descripcion = $evt->descripcion;
			$e->fecha_inicio = date('Y-m-d H:i:s', strtotime($evt->fechaInicio));
			if( $evt->fechaFin )
			{
				$e->fecha_fin = date('Y-m-d H:i:s', strtotime($evt->fechaFin));
				$e->status = Event::STATUS_CLOSED;
			}
			else
			{
				$e->status = Event::STATUS_OPEN;
			}
			//$e->cufd = null;
			$e->Save(0);
			
		}
		return $res;
	}
	/**
	 * Obtiene el evento activo
	 *
	 * @param int $sucursal
	 * @param int $puntoventa
	 * @return Event
	 */
	public function obtenerEventoActivo(int $sucursal, int $puntoventa)
	{
		$evento = Event::where('codigo_sucursal', $sucursal)->where('codigo_puntoventa', $puntoventa)->where('estado', Event::STATUS_OPEN)->first();
		return $evento;
	}
	public function getEventStats(int $eventId)
	{
		$count = Invoice::where('event_id', $eventId)->count();
		$stats = ['total_facturas' => $count];
		
		return $stats;
	}
	/**
	 * Cierra un evento siat
	 *
	 * @param int $eventId
	 * @throws Exception
	 * @return boolean
	 */
	public function closeEvent(int $eventId, $cafc = null)
	{
		set_time_limit(0);
		
		//$user = sb_get_current_user();
		$localEvent = Event::find($eventId);
		
		if( !$localEvent )
			throw new Exception('El evento no existe');
		//if( $localEvent->user_id != $user->user_id )
		//	throw new Exception('Acceso invalido');
				
		$siatEvent = $this->siatSyncModel->getEventoPorCodigo(null, $localEvent->codigo_sucursal, $localEvent->codigo_puntoventa, $localEvent->evento_id);
		if( !$siatEvent )
			throw new Exception('El evento siat no existe');
		
		$invoices = Invoice::where('event_id', $localEvent->id)
			->where('codigo_sucursal', $localEvent->codigo_sucursal)
			->where('codigo_puntoventa', $localEvent->codigo_puntoventa)
			->get();
		
		$total = count($invoices);
		if( $total <= 0 )
		{
			$localEvent->estado = Event::STATUS_CLOSED;
			$localEvent->save();
			//sb_update_user_meta($user->user_id, '_SIAT_'. $localEvent->puntoventa_id . '_MANUAL_EVENT', 0);
			return true;
		}
		$config	= $this->getConfig();
		//$config->validateExpirations();
		if( !in_array($localEvent->evento_id, [5, 6, 7]) )
			$localEvent->fecha_fin = date('Y-m-d H:i:s');
		//if( $localEvent->estado == Event::STATUS_PROCESSING )
		//	return;
							
		//$localEvent->estado = Event::STATUS_PROCESSING;
		//$localEvent->save();
							
		$cuis = $this->getCuis($config, null, $localEvent->codigo_sucursal, $localEvent->codigo_puntoventa);
		$cufd = $this->getCufd($config, null, $localEvent->codigo_sucursal, $localEvent->codigo_puntoventa);
		//##register event into SIAT
		if( (int)$localEvent->codigo_recepcion <= 0 )
		{
			if( empty($localEvent->fecha_fin) )
			{
				$localEvent->estado = Event::STATUS_OPEN;
				$localEvent->save();
				throw new Exception('El evento no tiene fecha de finalizacion, no se puede cerrar');
			}
			if( $cufd->codigo == $localEvent->cufd_evento )
				//##get new CUFD to close the event
				$cufd = $this->renewCufd($localEvent->codigo_sucursal, $localEvent->codigo_puntoventa);
				
			$serviceOp = new ServicioOperaciones($cuis->codigo, $cufd->codigo, $config->tokenDelegado);
			$serviceOp->setConfig((array)$config);
			$res = $serviceOp->registroEventoSignificativo(
				$siatEvent->codigoClasificador,
				$siatEvent->descripcion,
				$localEvent->cufd_evento,
				date(SIAT_DATETIME_FORMAT, strtotime($localEvent->fecha_inicio)),
				date(SIAT_DATETIME_FORMAT, strtotime($localEvent->fecha_fin)),
				$localEvent->codigo_sucursal,
				$localEvent->codigo_puntoventa
			);
			//SB_Factory::getApplication()->Log($res);
			if( !isset($res->RespuestaListaEventos->codigoRecepcionEventoSignificativo) || !$res->RespuestaListaEventos->transaccion )
			{
				$localEvent->estado = Event::STATUS_OPEN;
				$localEvent->save();
				//print_r($res->RespuestaListaEventos);
				$error = \sb_siat_message($res->RespuestaListaEventos);
				if( is_object($res->RespuestaListaEventos->mensajesList) && $res->RespuestaListaEventos->mensajesList->codigo == 981 )
					$error .= sprintf("%s - %s", $localEvent->fecha_inicio, $localEvent->fecha_fin);
					throw new Exception('.No se pudo registrar el evento en SIAT: '. $error);
			}
			
			$localEvent->codigo_recepcion = $res->RespuestaListaEventos->codigoRecepcionEventoSignificativo;
			$localEvent->save();
		}
							
							
		if( $total <= 500 )
		{
			$invoiceModel = new InvoiceModel($this->siatSyncModel, $this);
			//##envio paquete
			$service = SiatFactory::obtenerServicioFacturacion($config, $cuis->codigo, $cufd->codigo, $cufd->codigo_control);
			$paquets = $this->buildPackages($localEvent->id);
			//print_r($paquets);die;
			$pkgs_ok = true;
			foreach($paquets as $pkg)
			{
				$invoices 		= $this->getPackageInvoices($pkg);
				//print_r($invoices);die;
				$siatInvoices 	= $invoiceModel->invoicesToSiat($invoices->all());
				$res = $service->recepcionPaqueteFactura(
					$siatInvoices,
					$localEvent->codigo_recepcion,
					SiatInvoice::TIPO_EMISION_OFFLINE,
					$invoices[0]->tipo_factura_documento,
					$invoices[0]->cafc ?: null
					//$localEvent->cafc ?: null
				);
				$pkg->reception_status	= $res->RespuestaServicioFacturacion->codigoDescripcion;
				$pkg->reception_code 	= isset($res->RespuestaServicioFacturacion->codigoRecepcion) ? $res->RespuestaServicioFacturacion->codigoRecepcion : null;
				$pkg->reception_date 	= date('Y-m-d H:i:s');
				$pkg->data				= (object)['envio' => null, 'error_envio' => null, 'recepcion' => null, 'error_recepcion' => null];
				
				if( $res->RespuestaServicioFacturacion->codigoEstado != 901 ) //PENDIENTE
				{
					//$localEvent->status = Evento::STATUS_OPEN;
					//$localEvent->Save(0);
					//if( !is_object($localEvent->data) )
					//	$localEvent->data = (object)['error_envio' => null];
					//$localEvent->data->error_envio = $res->RespuestaServicioFacturacion->mensajesList;
					//$localEvent->Save(0);
					//throw new Exception('Ocurrio un error enviando el paquete. SIAT: ' . \sb_siat_message($res->RespuestaServicioFacturacion) );
					$pkg->data->error_envio = $res;
					$pkg->save();
					$pkgs_ok = false;
				}
				else
				{
					$pkg->data->envio = $res;
					$pkg->save();
					$this->verifyPackageReceipt($config, $localEvent, $pkg);
				}
			}
			$localEvent->cufd	= $cufd->codigo;
			$localEvent->estado = $pkgs_ok ? Event::STATUS_CLOSED : Event::STATUS_OPEN;
			$localEvent->save();
			//sb_update_user_meta($user->user_id, '_SIAT_'. $localEvent->puntoventa_id . '_MANUAL_EVENT', 0);
			/*
			 $res = $service->recepcionPaqueteFactura(
			 $siatInvoices,
			 $localEvent->codigo_recepcion,
			 SiatInvoice::TIPO_EMISION_OFFLINE,
			 $invoices[0]->tipo_factura_documento,
			 $invoices[0]->cafc ?: null,
			 //$localEvent->cafc ?: null
			 );
			 //SB_Factory::getApplication()->Log($res);
			 $localEvent->stado_recepcion = $res->RespuestaServicioFacturacion->codigoDescripcion;
			 if( $res->RespuestaServicioFacturacion->codigoEstado != 901 ) //PENDIENTE
			 {
			 $localEvent->status = Evento::STATUS_OPEN;
			 $localEvent->Save(0);
			 if( !is_object($localEvent->data) )
			 $localEvent->data = (object)['error_envio' => null];
			 $localEvent->data->error_envio = $res->RespuestaServicioFacturacion->mensajesList;
			 $localEvent->Save(0);
			 throw new Exception('Ocurrio un error enviando el paquete. SIAT: ' . \sb_siat_message($res->RespuestaServicioFacturacion) );
			 }
			 $localEvent->codigo_recepcion_paquete = $res->RespuestaServicioFacturacion->codigoRecepcion;
			 $localEvent->cufd	= $config->cufd->codigo;
			 //$localEvent->cafc 	= $cafc;
			 $localEvent->status = Evento::STATUS_CLOSED;
			 $localEvent->Save(0);
			 sb_update_user_meta($user->user_id, '_SIAT_'. $localEvent->puntoventa_id . '_MANUAL_EVENT', 0);
			 $this->verifyPackageReceipt($user, $config, $localEvent);
			 */
		}
		else
		{
			//##envio masivo
		}
	}
	/**
	 * Validar la recepcion del envio del paquete de facturas
	 * @param SiatConfig $config
	 * @param string $codigoRecepcion
	 * @return object Respuesta Siat
	 */
	public function verifyPackageReceipt(SiatConfig $config, Event $evento, Package $pkg)
	{
		$cuis = $this->getCuis($config, null, $evento->codigo_sucursal, $evento->codigo_puntoventa);
		$cufd = $this->getCufd($config, null, $evento->codigo_sucursal, $evento->codigo_puntoventa);
		$service = SiatFactory::obtenerServicioFacturacion($config, $cuis->codigo, $cufd->codigo, $cufd->codigo_control);
		$res = $service->validacionRecepcionPaqueteFactura(
			$evento->codigo_sucursal, 
			$evento->codigo_puntoventa, 
			$pkg->reception_code, 
			$pkg->invoice_type, 
			$pkg->sector_document
		);
		while( $res->RespuestaServicioFacturacion->codigoDescripcion == 'PENDIENTE' )
		{
			//echo "REINTENTANTO RESPUESTA RECEPCION PAQUETE\n=====================\n";
			$res = $service->validacionRecepcionPaqueteFactura(
				$evento->codigo_sucursal,
				$evento->codigo_puntoventa,
				$pkg->reception_code,
				$pkg->invoice_type,
				$pkg->sector_document
			);
		}
		//$evento->stado_recepcion = $res->RespuestaServicioFacturacion->codigoDescripcion;
		$pkg->reception_status = $res->RespuestaServicioFacturacion->codigoDescripcion;
		$pkg_data = $pkg->getData();
		$pkg_data->recepcion = $res;
		$pkg->data = $pkg_data;
		$pkg->save();
		//$evento->data->RespuestaServicioFacturacion = $res->RespuestaServicioFacturacion;
		//$evento->Save(0);
		if( $res->RespuestaServicioFacturacion->codigoDescripcion == 'VALIDADA' )
			DB::table('mb_invoices')
				->where('event_id', $evento->id)
				->where('package_id', $pkg->id)
				->update([
					'siat_id' 		=> $res->RespuestaServicioFacturacion->codigoRecepcion,
					'tipo_emision'	=> SiatInvoice::TIPO_EMISION_ONLINE,
				]);
			
		return $res;
	}
	/**
	 * Verifica si la factura esta dentro el rando de fecha y hora del evento
	 *
	 * @param Evento $evento
	 * @param Invoice $invoice
	 * @return	bool
	 */
	public function isValidInvoiceDateTimes(Evento $evento, Invoice $invoice)
	{
		if( !$evento->fecha_inicio || !$evento->fecha_fin )
			throw new ExceptionInvalidInvoiceData('El evento tiene la fecha inicio o fin incorrectas, no se puede validar', null, $invoice);
			if( strtotime($invoice->invoice_date_time) < strtotime($evento->fecha_inicio) )
				throw new ExceptionInvalidInvoiceData('La factura tiene la fecha y hora de inicio incorrecta, no corresponde al evento', null, $invoice);
				if( /*$evento->fecha_fin &&*/ (strtotime($invoice->invoice_date_time) > strtotime($evento->fecha_fin)) )
					throw new ExceptionInvalidInvoiceData('La factura tiene la fecha y hora fin incorrecta, no corresponde al evento', null, $invoice);
					
					return true;
	}
	/**
	 * Build event packages to send
	 * @param int $eventId
	 * @return Package
	 */
	public function buildPackages(int $eventId)
	{
		$pkgs = Package::where('event_id', $eventId)->get();
		if( count($pkgs) )
			return $pkgs;
		$rows = DB::table('mb_invoices')
			->selectRaw('count(id) as total_facturas, codigo_documento_sector,tipo_factura_documento')
			->where('event_id', $eventId)
			->where('tipo_emision', ServicioSiat::TIPO_EMISION_OFFLINE)
			->groupBy('codigo_documento_sector','tipo_factura_documento')
			->get();
		//print_r($rows);die;
		$pkgs = [];
		foreach($rows as $p)
		{
			$pkg = new Package();
			$pkg->event_id 			= $eventId;
			$pkg->invoice_type 		= $p->tipo_factura_documento;
			$pkg->sector_document	= $p->codigo_documento_sector;
			$pkg->save();
			$pkgs[] = $pkg;
		}
		
		return $pkgs;
	}
	/**
	 * 
	 * @param Package $pkg
	 * @return Collection
	 */
	public function getPackageInvoices(Package $pkg)
	{
		$invoices = Invoice::where('event_id', $pkg->event_id)
			->where('tipo_factura_documento', $pkg->invoice_type)
			->where('codigo_documento_sector', $pkg->sector_document)
			->get();
		
		DB::table('mb_invoices')
			->where('event_id', $pkg->event_id)
			->where('tipo_factura_documento', $pkg->invoice_type)
			->where('codigo_documento_sector', $pkg->sector_document)
			->where('tipo_emision', ServicioSiat::TIPO_EMISION_OFFLINE)
			->update(['package_id' => $pkg->id]);
		
		return $invoices;
	}
}