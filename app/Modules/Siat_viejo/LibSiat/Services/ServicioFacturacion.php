<?php
/**
 * @author J. Marcelo Aviles Paco
 * @copyright Sintic Bolivia 
 */
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Messages\SolicitudServicioRecepcionFactura;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioSiat;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SiatInvoice;
use Exception;
use SoapFault;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Messages\SolicitudServicioRecepcionMasiva;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Messages\SolicitudServicioRecepcionPaquete;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\CompraVenta;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Messages\SolicitudServicioValidacionRecepcionMasiva;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Messages\SolicitudServicioValidacionRecepcionPaquete;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Messages\SolicitudServicioAnulacionFactura;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Messages\SolicitudServicioVerificacionEstadoFactura;

/**
 * Clase con servicios generales para la facturacion
 * 
 * @author J. Marcelo Aviles Paco
 * @desc Clase con servicios generales para la facturacion
 *
 */
class ServicioFacturacion extends ServicioSiat
{
	public function buildInvoiceXml(SiatInvoice $invoice)
	{
		return $invoice->toXml(null, true)->asXML();
	}
	/**
	 * Realiza en envio de una unica factura
	 * 
	 * @param SiatInvoice $factura
	 * @param int $tipoEmision
	 * @param int $tipoFactura
	 * @throws Exception
	 * @return Object Retorna la respuesta del servicio web siat
	 */
	public function recepcionFactura(SiatInvoice $factura, $tipoEmision = SiatInvoice::TIPO_EMISION_ONLINE, $tipoFactura = SiatInvoice::FACTURA_DERECHO_CREDITO_FISCAL)
	{
		$factura->cabecera->razonSocialEmisor	= $this->razonSocial;
		$factura->cabecera->nitEmisor 	= $this->nit;
		$factura->cabecera->cufd		= $this->cufd;
		$factura->buildCuf(0, $this->modalidad, $tipoEmision, $tipoFactura, $this->codigoControl);
		//die($factura->cuf);
		
		$factura->validate();
		//print_r($factura);die;
		$facturaXml = $this->buildInvoiceXml($factura);
		//print $facturaXml;die;
		//$facturaXml = file_get_contents('factura.xml');
		if( $this->debug )
			$this->debug($facturaXml, 1);
		//file_put_contents('factura.xml', $facturaXml);
		//var_dump($facturaXml);die;
		
		$solicitud = new SolicitudServicioRecepcionFactura();
		$solicitud->cufd 					= $this->cufd;
		$solicitud->cuis					= $this->cuis;
		$solicitud->codigoSistema			= $this->codigoSistema;
		$solicitud->nit						= $this->nit;
		$solicitud->codigoModalidad			= $this->modalidad;
		$solicitud->codigoAmbiente 			= $this->ambiente;
		$solicitud->codigoDocumentoSector 	= $factura->cabecera->codigoDocumentoSector;
		$solicitud->tipoFacturaDocumento	= $tipoFactura;
		$solicitud->codigoEmision			= $tipoEmision;
		$solicitud->fechaEnvio				= date("Y-m-d\TH:i:s.v");
		$solicitud->codigoSucursal			= $factura->cabecera->codigoSucursal;
		$solicitud->codigoPuntoVenta		= $factura->cabecera->codigoPuntoVenta;
		//print_r($solicitud);die;
		//print_r($facturaXml);die;
		$solicitud->setBuffer($facturaXml, true);
		$solicitud->validate();
		
		try
		{
			$data = [
				$solicitud->toArray()
			];
			//print_r($data);die;
			//$this->debug($factura->toArray(), 0);
			//$this->debug($solicitud->toArray(), 0);
			$this->wsdl = $factura->getEndpoint($this->modalidad, $this->ambiente);
			//var_dump($this->wsdl);die;
			$res = $this->callAction('recepcionFactura', $data);
			//print_r($res);die;
			return $res;
		}
		catch(\SoapFault $e)
		{
			//print_r($e->getMessage());
			throw new Exception($e->getMessage());
		}
	}
	/**
	 * Realiza en envio de multiples facturas de forma masiva
	 * Cantidad de facturas mayor a 500
	 * 
	 * @param SiatInvoice[] $facturas
	 * @param int $tipoEmision
	 * @param int $tipoFactura
	 */
	public function recepcionMasivaFactura(array $facturas, $tipoEmision = SiatInvoice::TIPO_EMISION_ONLINE, $tipoFactura = SiatInvoice::FACTURA_DERECHO_CREDITO_FISCAL)
	{
		try
		{
			//if( !count($facturas) )
			//	throw new Exception('Invalid siat invoices, the service requires atleast one invoice');
			
			$invoiceFiles = [];
			$invoicesXml = [];
			//##validate invoices
			foreach($facturas as $factura)
			{
				$factura->cabecera->cufd = $this->cufd;
				$factura->buildCuf(0, $this->modalidad, $tipoEmision, $tipoFactura, $this->codigoControl);
				$factura->validate();
				$facturaXml = $this->buildInvoiceXml($factura);
				$invoicesXml[] = $facturaXml;
				//echo "CUFD: ", $factura->cabecera->cufd, "\n";
			}
			//var_dump(count($facturas), count($invoicesXml));die;
			$solicitud = new SolicitudServicioRecepcionMasiva();
			$solicitud->cantidadFacturas		= count($facturas);
			$solicitud->cufd 					= $this->cufd;
			$solicitud->cuis					= $this->cuis;
			$solicitud->codigoSistema			= $this->codigoSistema;
			$solicitud->nit						= $this->nit;
			$solicitud->codigoModalidad			= $this->modalidad;
			$solicitud->codigoAmbiente 			= $this->ambiente;
			$solicitud->codigoEmision			= $tipoEmision;
			$solicitud->codigoDocumentoSector 	= isset($facturas[0]) ? $facturas[0]->cabecera->codigoDocumentoSector : DocumentTypes::FACTURA_COMPRA_VENTA;
			$solicitud->tipoFacturaDocumento	= $tipoFactura;
			$solicitud->codigoSucursal			= isset($facturas[0]) ? $facturas[0]->cabecera->codigoSucursal : 0;
			$solicitud->codigoPuntoVenta		= isset($facturas[0]) ? $facturas[0]->cabecera->codigoPuntoVenta : 0;
			$solicitud->fechaEnvio				= date("Y-m-d\TH:i:s.m0");
			$solicitud->setBufferFromInvoicesXml($invoicesXml);
			$solicitud->validate();
			$data = [
				$solicitud->toArray()
			];
			$this->wsdl = $facturas[0]->getEndpoint($this->modalidad, $this->ambiente);
			$res = $this->callAction('recepcionMasivaFactura', $data);
			return $res;
		}
		catch(SoapFault $e)
		{
			echo $e->getMessage();
		}
	}
	/**
	 * Realiza el envio de un paquete de facturas, cantidad de facturas menores a 500
	 * 
	 * @param SiatInvoice[] $facturas Arreglo de objectos factura
	 * @param int $codigoEvento
	 * @param int $tipoEmision
	 * @param int $tipoFactura
	 * @param string $cafc
	 * @throws Exception
	 * @return object
	 */
	public function recepcionPaqueteFactura(array $facturas, $codigoEvento, $tipoEmision = SiatInvoice::TIPO_EMISION_ONLINE, 
		$tipoFactura = SiatInvoice::FACTURA_DERECHO_CREDITO_FISCAL, $cafc = null)
	{
		try
		{
			if( !count($facturas) )
				throw new Exception('Invalid siat invoices, the service requires atleast one invoice');
			$xmlInvoices = [];
			//##validate invoices
			foreach($facturas as $factura)
			{
				if( $cafc && $factura->cabecera->cafc != $cafc )
					throw new Exception(sprintf("La facturacion %d no corresponde al CAFC \"%s\"", $factura->cabecera->numeroFactura, $cafc));
				if( empty($factura->cabecera->cuf) )
					throw new Exception(sprintf("La factura \"%d\" no tiene CUF", $factura->cabecera->numeroFactura));
				$factura->validate();
				//print_r($this->buildInvoiceXml($factura));
				$xmlInvoices[] = $this->buildInvoiceXml($factura);
			}
			//print_r($xmlInvoices);die();
			$solicitud = new SolicitudServicioRecepcionPaquete();
			$solicitud->cafc					= $cafc;
			$solicitud->cantidadFacturas		= count($facturas);
			$solicitud->codigoEvento			= $codigoEvento;
			$solicitud->cufd 					= $this->cufd;
			$solicitud->cuis					= $this->cuis;
			$solicitud->codigoSistema			= $this->codigoSistema;
			$solicitud->nit						= $this->nit;
			$solicitud->codigoModalidad			= $this->modalidad;
			$solicitud->codigoAmbiente 			= $this->ambiente;
			$solicitud->codigoDocumentoSector 	= $facturas[0]->cabecera->codigoDocumentoSector;
			$solicitud->tipoFacturaDocumento	= $tipoFactura;
			$solicitud->fechaEnvio				= date(SIAT_DATETIME_FORMAT);
			$solicitud->codigoEmision			= $tipoEmision;
			$solicitud->codigoPuntoVenta		= $facturas[0]->cabecera->codigoPuntoVenta;
			$solicitud->codigoSucursal			= $facturas[0]->cabecera->codigoSucursal;
			
			//$solicitud->setBuffer($xmlInvoices);
			$solicitud->setBufferFromInvoicesXml($xmlInvoices);
			$solicitud->validate();
			$data = [
				$solicitud->toArray()
			];
			
			$this->wsdl = $facturas[0]->getEndpoint($this->modalidad, $this->ambiente);
			$res = $this->callAction('recepcionPaqueteFactura', $data);
			return $res;
		}
		catch(SoapFault $e)
		{
			echo $e->getMessage();
		}
	}
	/**
	 * Valida la recepcion de un paquete
	 * 
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @param string $codigoRecepcion
	 * @param int $tipoFactura
	 * @param int $documentoSector
	 * @return object Respuesta del servicio siat
	 */
	public function validacionRecepcionPaqueteFactura($codigoSucursal, $codigoPuntoVenta, $codigoRecepcion,
		$tipoFactura = SiatInvoice::FACTURA_DERECHO_CREDITO_FISCAL,
		$documentoSector = DocumentTypes::FACTURA_COMPRA_VENTA
	)
	{
		$solicitud = new SolicitudServicioValidacionRecepcionPaquete();
		$solicitud->cuis 	= $this->cuis;
		$solicitud->cufd 	= $this->cufd;
		$solicitud->nit		= $this->nit;
		$solicitud->codigoSistema			= $this->codigoSistema;
		$solicitud->codigoAmbiente			= $this->ambiente;
		$solicitud->codigoModalidad			= $this->modalidad;
		$solicitud->codigoSucursal			= $codigoSucursal;
		$solicitud->codigoPuntoVenta		= $codigoPuntoVenta;
		$solicitud->codigoEmision			= SiatInvoice::TIPO_EMISION_OFFLINE;
		$solicitud->tipoFacturaDocumento	= $tipoFactura;
		$solicitud->codigoDocumentoSector	= $documentoSector;
		$solicitud->codigoRecepcion			= $codigoRecepcion;
		
		$data = [
			$solicitud->toArray()
		];
		$this->wsdl = SiatInvoice::getWsdl($this->modalidad, $this->ambiente, $documentoSector);
		$res = $this->callAction('validacionRecepcionPaqueteFactura', $data);
		return $res;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @param string $codigoRecepcion
	 * @param int $tipoFactura
	 * @param int $documentoSector
	 * @return object Respuesta del servicio siat
	 */
	public function validacionRecepcionMasivaFactura($codigoSucursal, $codigoPuntoVenta, $codigoRecepcion,
		$tipoFactura = SiatInvoice::FACTURA_DERECHO_CREDITO_FISCAL, 
		$documentoSector = DocumentTypes::FACTURA_COMPRA_VENTA
	)
	{
		$solicitud = new SolicitudServicioValidacionRecepcionMasiva();
		$solicitud->cuis 	= $this->cuis;
		$solicitud->cufd 	= $this->cufd;
		$solicitud->nit		= $this->nit;
		$solicitud->codigoSistema			= $this->codigoSistema;
		$solicitud->codigoAmbiente			= $this->ambiente;
		$solicitud->codigoModalidad			= $this->modalidad;
		$solicitud->codigoSucursal			= $codigoSucursal;
		$solicitud->codigoPuntoVenta		= $codigoPuntoVenta;
		$solicitud->codigoEmision			= SiatInvoice::TIPO_EMISION_MASIVA;
		$solicitud->tipoFacturaDocumento	= $tipoFactura;
		$solicitud->codigoDocumentoSector	= $documentoSector;
		$solicitud->codigoRecepcion			= $codigoRecepcion;
		
		$data = [
			$solicitud->toArray()
		];
		$this->wsdl = SiatInvoice::getWsdl($this->modalidad, $this->ambiente, $documentoSector);
		$res = $this->callAction('validacionRecepcionMasivaFactura', $data);
		return $res;
	}
	/**
	 * Realizar la anulacion de una factura
	 * 
	 * @param int $motivo codigo clasificador del motivo de anulacion
	 * @param string $cuf El codigo CUF de la factura	
	 * @param int $sucursal	El codigo de la sucursal
	 * @param int $puntoventa	El codigo del punto de venta
	 * @param int $tipoFactura	El tipo de factura CREDITO FISCAL, SIN CREDITO FISCAL, ETC
	 * @param int $tipoEmision	El tipo de emision ONLINE, OFFLINE, WEB
	 * @param int $documentoSector	El documento del sector COMPRA_VENTA, HOSPITALES, COLEGIOS, etc
	 * @return object
	 */
	public function anulacionFactura(int $motivo, string $cuf, int $sucursal, int $puntoventa, int $tipoFactura, int $tipoEmision, int $documentoSector)
	{
		$solicitud = new SolicitudServicioAnulacionFactura();
		$solicitud->cuis 					= $this->cuis;
		$solicitud->cufd 					= $this->cufd;
		$solicitud->nit						= $this->nit;
		$solicitud->codigoSistema			= $this->codigoSistema;
		$solicitud->codigoAmbiente			= $this->ambiente;
		$solicitud->codigoModalidad			= $this->modalidad;
		$solicitud->codigoSucursal			= $sucursal;
		$solicitud->codigoPuntoVenta		= $puntoventa;
		$solicitud->codigoEmision			= $tipoEmision;
		$solicitud->tipoFacturaDocumento	= $tipoFactura;
		$solicitud->codigoDocumentoSector	= $documentoSector;
		$solicitud->codigoMotivo			= $motivo;
		$solicitud->cuf						= $cuf;
		$solicitud->validate();
		
		$data = [
			$solicitud->toArray()
		];
		$this->wsdl = SiatInvoice::getWsdl($this->modalidad, $this->ambiente, $documentoSector);
		$res = $this->callAction('anulacionFactura', $data);
		
		return $res;
		
	}
	/**
	 * 
	 * @param SiatInvoice $invoice
	 * @param int $tipoFactura
	 * @return object
	 */
	public function verificacionEstadoFactura(SiatInvoice $invoice, int $tipoFactura)
	{
	    $solicitud = new SolicitudServicioVerificacionEstadoFactura();
	    $solicitud->cuis 					= $this->cuis;
	    $solicitud->cufd 					= $this->cufd;
	    $solicitud->nit						= $this->nit;
	    $solicitud->codigoSistema			= $this->codigoSistema;
	    $solicitud->codigoAmbiente			= $this->ambiente;
	    $solicitud->codigoModalidad			= $this->modalidad;
	    $solicitud->codigoSucursal			= $invoice->cabecera->codigoSucursal;
	    $solicitud->codigoPuntoVenta		= $invoice->cabecera->codigoPuntoVenta;
	    $solicitud->tipoFacturaDocumento	= $tipoFactura;
	    $solicitud->cuf						= $invoice->cabecera->cuf;
	    $solicitud->validate();
	    
	    $data = [
	    	$solicitud->toArray()
	    ];
	    $this->wsdl = $invoice->getEndpoint($this->modalidad, $this->ambiente);
	    $res = $this->callAction('verificacionEstadoFactura', $data);
	    
	    return $res;
	    
	}
}
