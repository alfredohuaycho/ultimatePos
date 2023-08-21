<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat;


use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\InvoiceDetail;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioSiat;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaCompraVenta;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\CompraVenta;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaComercialExportacion;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ComercialExportacion;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\InvoiceDetailComercialExportacion;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaServicioTuristicoHospedaje;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\InvoiceDetailTuristico;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ServicioTuristicoHospedaje;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaTasaCero;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\TasaCero;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaSectorEducativo;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaHotel;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\InvoiceDetailHotel;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaHospitales;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\InvoiceDetailHospital;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaComercialExportacionServicio;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SectorEducativo;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\Hotel;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\Hospitales;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ComercialExportacionServicio;
use Exception;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaServicioBasico;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaEntidadFinanciera;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ServicioBasico;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\EntidadFinanciera;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioFacturacionElectronica;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioFacturacionComputarizada;

class SiatFactory
{
	/**
	 * 
	 * @param int $documentoSector
	 * @param int $modalidad
	 * @throws Exception
	 * @return \SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaCompraVenta|\SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\CompraVenta|\SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ComercialExportacion|\SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ServicioTuristicoHospedaje|\SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\TasaCero|\SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SectorEducativo|\SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\Hotel|\SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\Hospitales|\SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ComercialExportacionServicio|\SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ServicioBasico|\SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\EntidadFinanciera
	 */
	public static function construirFacturaSector(int $documentoSector, int $modalidad, &$detailClass)
	{
		$factura = null;
		$detailClass = InvoiceDetail::class;
		
		if( $modalidad == ServicioSiat::MOD_ELECTRONICA_ENLINEA )
		{
			if( $documentoSector == DocumentTypes::FACTURA_COMPRA_VENTA )
				$factura = new ElectronicaCompraVenta();
			else if( $documentoSector == DocumentTypes::FACTURA_COMERCIAL_EXPORTACION )
			{
				$factura = new ElectronicaComercialExportacion();
				$detailClass = InvoiceDetailComercialExportacion::class;
			}
			else if( $documentoSector == DocumentTypes::FACTURA_SERVICIO_TURISTICO )
			{
				$factura = new ElectronicaServicioTuristicoHospedaje();
				$detailClass = InvoiceDetailTuristico::class;
			}
			else if( $documentoSector == DocumentTypes::FACTURA_TASA_CERO_LIBROS )
			{
				$factura = new ElectronicaTasaCero();
				//$detailClass = InvoiceDetailTuristico::class;
			}
			else if( $documentoSector == DocumentTypes::FACTURA_SECTOR_EDUCATIVO )
			{
				$factura = new ElectronicaSectorEducativo();
			}
			else if( $documentoSector == DocumentTypes::FACTURA_HOTELES )
			{
				$factura = new ElectronicaHotel();
				$detailClass = InvoiceDetailHotel::class;
			}
			else if( $documentoSector == DocumentTypes::FACTURA_HOSPITALES )
			{
				$factura = new ElectronicaHospitales();
				$detailClass = InvoiceDetailHospital::class;
			}
			else if( $documentoSector == DocumentTypes::FACTURA_COM_EXPORT_SERVICIOS )
			{
				$factura = new ElectronicaComercialExportacionServicio();
				//$detailClass = InvoiceDetailComercialExportacion::class;
			}
			else if( $documentoSector == DocumentTypes::FACTURA_SERV_BASICOS )
			{
				$factura = new ElectronicaServicioBasico();
			}
			else if( $documentoSector == DocumentTypes::FACTURA_ENT_FINANCIERA )
			{
				$factura = new ElectronicaEntidadFinanciera();
			}
		}
		else
		{
			if( $documentoSector == DocumentTypes::FACTURA_COMPRA_VENTA )
				$factura = new CompraVenta();
			else if( $documentoSector == DocumentTypes::FACTURA_COMERCIAL_EXPORTACION )
			{
				$factura = new ComercialExportacion();
				$detailClass = InvoiceDetailComercialExportacion::class;
			}
			else if( $documentoSector == DocumentTypes::FACTURA_SERVICIO_TURISTICO )
			{
				$factura = new ServicioTuristicoHospedaje();
				$detailClass = InvoiceDetailTuristico::class;
			}
			else if( $documentoSector == DocumentTypes::FACTURA_TASA_CERO_LIBROS )
			{
				$factura = new TasaCero();
				//$detailClass = InvoiceDetailTuristico::class;
			}
			else if( $documentoSector == DocumentTypes::FACTURA_SECTOR_EDUCATIVO )
			{
				$factura = new SectorEducativo();
			}
			else if( $documentoSector == DocumentTypes::FACTURA_HOTELES )
			{
				$factura = new Hotel();
				$detailClass = InvoiceDetailHotel::class;
			}
			else if( $documentoSector == DocumentTypes::FACTURA_HOSPITALES )
			{
				$factura = new Hospitales();
				$detailClass = InvoiceDetailHospital::class;
			}
			else if( $documentoSector == DocumentTypes::FACTURA_COM_EXPORT_SERVICIOS )
			{
				$factura = new ComercialExportacionServicio();
				//$detailClass = InvoiceDetailComercialExportacion::class;
			}
			else if( $documentoSector == DocumentTypes::FACTURA_SERV_BASICOS )
			{
				$factura = new ServicioBasico();
			}
			else if( $documentoSector == DocumentTypes::FACTURA_ENT_FINANCIERA )
			{
				$factura = new EntidadFinanciera();
			}
		}
		if( !$factura )
			throw new Exception('El documento sector no se encuentra o no esta implementado');
		//$factura->detalle = new $detailClass();
		
		return $factura;
	}
	/**
	 * Crear el servicio de factura segun datos de la configuracion
	 * 
	 * @param SiatConfig $config
	 * @return \SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioFacturacionElectronica|\SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioFacturacionComputarizada
	 */
	public static function obtenerServicioFacturacion(SiatConfig $config, string $cuis = '', string $cufd = '', string $codigoControl = '')
	{
		$servicio = $config->modalidad == ServicioSiat::MOD_ELECTRONICA_ENLINEA ?
			new ServicioFacturacionElectronica($cuis, $cufd) : 
			new ServicioFacturacionComputarizada($cuis, $cufd);
		$servicio->setConfig((array)$config);
		if( $codigoControl )
			$servicio->codigoControl = $codigoControl;
		if( $config->modalidad == ServicioSiat::MOD_ELECTRONICA_ENLINEA )
		{
			$servicio->setPrivateCertificateFile($config->privCert);
			$servicio->setPublicCertificateFile($config->pubCert);
		}
		
		return $servicio;
	}
}