<?php
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioSiat;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaCompraVenta;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\CompraVenta;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\InvoiceDetail;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SiatInvoice;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioFacturacionCodigos;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioFacturacionSincronizacion;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioOperaciones;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioFacturacionComputarizada;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioFacturacionElectronica;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;
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
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ServicioBasico;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaServicioBasico;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\EntidadFinanciera;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaEntidadFinanciera;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\SiatFactory;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaAlquilerBienInmueble;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\AlquilerBienInmueble;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\InvoiceDetailAlquiler;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\PreValorada;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\InvoiceDetailPreValorada;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaPreValorada;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\ElectronicaTelecomunicaciones;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\Telecomunicaciones;

function test_log($data, $destFile = null)
{
	global $config;
	
	$filename = __DIR__ . '/nit-' . $config->nit . ($destFile ? '-' . $destFile : '') . '.log';
	$fh = fopen($filename, is_file($filename) ? 'a+' : 'w+');
	fwrite($fh, sprintf("[%s]#\n%s\n", date('Y-m-d H:i:s'), print_r($data, 1)));
	fclose($fh);
	print_r($data);
}
function construirFactura($codigoPuntoVenta = 0, $codigoSucursal = 0, $modalidad = 0, $documentoSector = 1, $codigoActividad = '620100', $codigoProductoSin = '')
{
	global $config;
	
	$subTotal = 0;
	$factura = null;
	$detailClass = InvoiceDetail::class;
	
	if( $modalidad == ServicioSiat::MOD_ELECTRONICA_ENLINEA )
	{
		if( $documentoSector == DocumentTypes::FACTURA_COMPRA_VENTA )
			$factura = new ElectronicaCompraVenta();
		else if( $documentoSector == DocumentTypes::FACTURA_ALQUILER_INMUEBLES )
		{
			$factura = new ElectronicaAlquilerBienInmueble();
			$detailClass = InvoiceDetailAlquiler::class;
		}
		else if( $documentoSector == DocumentTypes::FACTURA_PREVALORADA )
		{
			$factura = new ElectronicaPreValorada();
			$detailClass = InvoiceDetailPreValorada::class;
		}
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
		else if( $documentoSector == DocumentTypes::FACTURA_TELECOMUNICACIONES )
		{
			$factura = new ElectronicaTelecomunicaciones();
			
		}
	}
	else
	{
		if( $documentoSector == DocumentTypes::FACTURA_COMPRA_VENTA )
			$factura = new CompraVenta();
		else if( $documentoSector == DocumentTypes::FACTURA_ALQUILER_INMUEBLES )
		{
			$factura = new AlquilerBienInmueble();
			$detailClass = InvoiceDetailAlquiler::class;
		}
		else if( $documentoSector == DocumentTypes::FACTURA_PREVALORADA )
		{
			$factura = new PreValorada();
			$detailClass = InvoiceDetailPreValorada::class;
		}
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
		else if( $documentoSector == DocumentTypes::FACTURA_TELECOMUNICACIONES )
		{
			$factura = new Telecomunicaciones();
			
		}
	}
	
	for($i = 0; $i < ($documentoSector == DocumentTypes::FACTURA_PREVALORADA ? 1 : 2); $i++)
	{
		$detalle = new $detailClass();
		$detalle->cantidad				= 1;
		$detalle->actividadEconomica	= $codigoActividad;
		$detalle->codigoProducto		= 'D001-' . rand(2001, 3000);
		$detalle->codigoProductoSin		= $codigoProductoSin;
		$detalle->descripcion			= 'Nombre del producto #0' . ($i + 1);
		$detalle->precioUnitario		= 10 * rand(1, 4000);
		$detalle->montoDescuento		= 0;
		$detalle->subTotal				= $detalle->cantidad * $detalle->precioUnitario;
		
		if( in_array($documentoSector, [DocumentTypes::FACTURA_COMERCIAL_EXPORTACION]) )
		{
			$detalle->codigoNandina = '0909610000';
		}
		elseif( in_array($documentoSector, [DocumentTypes::FACTURA_SERVICIO_TURISTICO, DocumentTypes::FACTURA_HOTELES]) )
		{
			$detalle->codigoTipoHabitacion = '10';
			$detalle->detalleHuespedes = '[{"nombreHuesped":"Juan Perez","documentoIdentificacion":"44864646","codigoPais":"1"}]';
		}
		elseif( $documentoSector == DocumentTypes::FACTURA_HOSPITALES )
		{
			$detalle->especialidad = 'Traumatologia';
			$detalle->especialidadDetalle = 'Reduccion de fractura';
			$detalle->nroQuirofanoSalaOperaciones = 2;
			$detalle->especialidadMedico = 'Traumatologia';
			$detalle->nombreApellidoMedico = 'Alguien XXX';
			$detalle->nitDocumentoMedico = 1020703023;
			$detalle->nroMatriculaMedico = '312312ASDAS';
			$detalle->nroFacturaMedico = rand(1, 6000);
			$detalle->especialidad		= 'Especialidad medica';
			$detalle->especialidadDetalle		= 'Especialidad medica detalle';
			$detalle->nroQuirofanoSalaOperaciones	= 5;
			$detalle->especialidadMedico		= 'Cirujano';
			$detalle->nombreApellidoMedico 		= 'Pepito Cirujano';
			$detalle->nitDocumentoMedico		= 3301256011;
			$detalle->nroMatriculaMedico		= 45435;
			$detalle->nroFacturaMedico			= 12;
		}
		else if( $documentoSector == DocumentTypes::FACTURA_ALQUILER_INMUEBLES )
		{
			
		}
		$subTotal += $detalle->subTotal;
		$factura->detalle[] = $detalle;
	}
	$minNum = defined('SIAT_TEST_MIN_NUM') ? SIAT_TEST_MIN_NUM: 1;
	$maxNum = defined('SIAT_TEST_MAX_NUM') ? SIAT_TEST_MAX_NUM: 1000;
	
	$factura->cabecera->razonSocialEmisor	= $config->razonSocial;
	$factura->cabecera->municipio			= 'La Paz';
	$factura->cabecera->telefono			= '88867523';
	$factura->cabecera->numeroFactura		= rand($minNum, $maxNum);
	$factura->cabecera->codigoSucursal		= $codigoSucursal;
	$factura->cabecera->direccion			= 'Pedro Kramer #109';
	$factura->cabecera->codigoPuntoVenta	= $codigoPuntoVenta;
	$factura->cabecera->fechaEmision		= date('Y-m-d\TH:i:s.v');
	$factura->cabecera->nombreRazonSocial	= 'Perez';
	$factura->cabecera->codigoTipoDocumentoIdentidad	= 1; //CI - CEDULA DE IDENTIDAD
	$factura->cabecera->numeroDocumento		= 2287567;
	$factura->cabecera->codigoCliente		= 'CC-2287567';
	$factura->cabecera->codigoMetodoPago	= 1;
	$factura->cabecera->montoTotal			= $subTotal;
	$factura->cabecera->montoTotalMoneda	= $factura->cabecera->montoTotal;
	$factura->cabecera->montoTotalSujetoIva	= $factura->cabecera->montoTotal;
	$factura->cabecera->descuentoAdicional	= 0;
	$factura->cabecera->codigoMoneda		= 1; //BOLIVIANO
	$factura->cabecera->tipoCambio			= 1;
	$factura->cabecera->usuario				= 'MonoBusiness User 01';
	
	if( $documentoSector == DocumentTypes::FACTURA_COMERCIAL_EXPORTACION )
	{
		$factura->cabecera->montoDetalle = $factura->cabecera->montoTotal;
		$factura->cabecera->codigoMoneda = 2; //USD
		$factura->cabecera->tipoCambio = 6.86;
		$factura->cabecera->direccionComprador = 'Av. Los Tajibos';
		$factura->cabecera->incoterm = 'CIF';
		$factura->cabecera->incotermDetalle = 'CIF-WEBEX';
		$factura->cabecera->puertoDestino = 'Arica';
		$factura->cabecera->lugarDestino = 'Chile';
		$factura->cabecera->codigoPais = '100';
		$factura->cabecera->costosGastosNacionales = '[]';
		$factura->cabecera->totalGastosNacionalesFob = $factura->cabecera->montoDetalle;
		$factura->cabecera->costosGastosInternacionales = '[]';
		$factura->cabecera->totalGastosInternacionales = 0;
		$factura->cabecera->montoTotalMoneda = $factura->cabecera->montoDetalle + $factura->cabecera->totalGastosInternacionales;
		$factura->cabecera->montoTotal = $factura->cabecera->montoTotalMoneda * $factura->cabecera->tipoCambio;
		$factura->cabecera->montoTotalSujetoIva = 0;
		$factura->cabecera->numeroDescripcionPaquetesBultos = 'NINGUNA';
		$factura->cabecera->informacionAdicional = 'NINGUNA';
	}
	else if( $documentoSector == DocumentTypes::FACTURA_ALQUILER_INMUEBLES )
	{
		$factura->cabecera->periodoFacturado = date('j');
	}
	else if( $documentoSector == DocumentTypes::FACTURA_PREVALORADA )
	{
		$factura->cabecera->codigoCliente = 'N/A';
		$factura->cabecera->nombreRazonSocial = 'S/N';
		$factura->cabecera->numeroDocumento = 0;
		$factura->cabecera->codigoTipoDocumentoIdentidad = 5; //NIT
	}
	elseif( $documentoSector == DocumentTypes::FACTURA_COM_EXPORT_SERVICIOS )
	{
		$factura->cabecera->direccionComprador = 'Av. Los Tajibos';
		$factura->cabecera->lugarDestino = 'Chile';
		$factura->cabecera->codigoPais = '100';
		$factura->cabecera->montoTotalSujetoIva = 0;
		$factura->cabecera->informacionAdicional = 'NINGUNA';
	}
	elseif( in_array($documentoSector, [DocumentTypes::FACTURA_SERVICIO_TURISTICO, DocumentTypes::FACTURA_HOTELES]) )
	{
		if( $documentoSector == DocumentTypes::FACTURA_SERVICIO_TURISTICO )
			$factura->cabecera->montoTotalSujetoIva = 0;
			
			$factura->cabecera->razonSocialOperadorTurismo = 'TURISMO LA PAZ';
			$factura->cabecera->cantidadHuespedes = 3;
			$factura->cabecera->cantidadHabitaciones = 1;
			$factura->cabecera->cantidadMayores = 2;
			$factura->cabecera->cantidadMenores = 1;
			$factura->cabecera->fechaIngresoHospedaje = date('Y-m-d\TH:i:s.v', time() + 63500);
	}
	elseif( $documentoSector == DocumentTypes::FACTURA_SECTOR_EDUCATIVO )
	{
		$factura->cabecera->nombreEstudiante = 'Pepito Perez';
		$factura->cabecera->periodoFacturado = 'ABRIL ' . date('Y');
	}
	elseif( $documentoSector == DocumentTypes::FACTURA_HOSPITALES )
	{
		$factura->cabecera->modalidadServicio = 'Post Operatorio';
	}
	elseif( $documentoSector == DocumentTypes::FACTURA_SERV_BASICOS )
	{
		$factura->cabecera->mes 	= date('m');
		$factura->cabecera->gestion = date('Y');
		$factura->cabecera->ciudad	= 'La Paz';
		$factura->cabecera->zona	= 'Zona Central';
		$factura->cabecera->numeroMedidor	= '34234';
		$factura->cabecera->domicilioCliente	= 'Direccion X';
		$factura->cabecera->consumoPeriodo		= $factura->cabecera->montoTotal;
		$factura->cabecera->beneficiarioLey1886 = 0;
		$factura->cabecera->montoDescuentoLey1886	= 0;
		$factura->cabecera->montoDescuentoTarifaDignidad = 0;
		$factura->cabecera->tasaAseo = 5;
		$factura->cabecera->tasaAlumbrado = 3;
		$factura->cabecera->ajusteNoSujetoIva = 0;
		$factura->cabecera->detalleAjusteNoSujetoIva = null;
		$factura->cabecera->montoTotal += $factura->cabecera->tasaAseo + $factura->cabecera->tasaAlumbrado;
		$factura->cabecera->montoTotalMoneda = $factura->cabecera->montoTotal;
	}
	else if( $documentoSector == DocumentTypes::FACTURA_TELECOMUNICACIONES )
	{
		$factura->cabecera->nitConjunto = null;
	}
	return $factura;
}
function construirFacturas($sucursal, $puntoventa, int $cantidad, $documentoSector, $codigoActividad, $codigoProductoSin, &$fechaEmision = null, $cufdAntiguo = null, $cafc = null)
{
	global $config;
	
	$facturas = [];
	for($i = 0; $i < $cantidad; $i++)
	{
		$factura = construirFactura($puntoventa, $sucursal, $config->modalidad, $documentoSector, $codigoActividad, $codigoProductoSin);
		$factura->cabecera->nitEmisor = $config->nit;
		$factura->cabecera->razonSocialEmisor = $config->razonSocial;
		$factura->cabecera->fechaEmision = $fechaEmision ?: date('Y-m-d\TH:i:s.v');
		$factura->cabecera->cufd = $cufdAntiguo;
		$factura->cabecera->cafc = $cafc;
		$facturas[] = $factura;
		$fechaEmision = date('Y-m-d\TH:i:s.v', strtotime($fechaEmision) + 10);
		print "Factura Nro: {$i}\r";
		flush();
	}
	
	return $facturas;
}
function testAnular($motivo, $cuf, $sucursal, $puntoventa, $tipoFactura, $tipoEmision, $documentoSector)
{
	global $config;
	
	$resCuis = obtenerCuis($puntoventa, $sucursal);
	$resCufd = obtenerCufd($puntoventa, $sucursal, $resCuis->RespuestaCuis->codigo);
	
	$service = new ServicioFacturacionComputarizada();
	$service->setConfig((array)$config);
	$service->cuis = $resCuis->RespuestaCuis->codigo;
	$service->cufd = $resCufd->RespuestaCufd->codigo;
	
	$res = $service->anulacionFactura($motivo, $cuf, $sucursal, $puntoventa, $tipoFactura, $tipoEmision, $documentoSector);
	
	return $res;
	sb_number_format($number);
}
function registroEvento($cuis, $cufd, $sucursal, $puntoventa, object $evento, $cufdAntiguo, $fechaInicio, $fechaFin)
{
	global $config;
	
	$serviceOps = new ServicioOperaciones();
	$serviceOps->setConfig((array)$config);
	$serviceOps->cuis = $cuis;
	$serviceOps->cufd = $cufd;
	$resEvent = $serviceOps->registroEventoSignificativo(
		$evento->codigoClasificador,
		$evento->descripcion,
		$cufdAntiguo,
		$fechaInicio,
		$fechaFin,
		$sucursal,
		$puntoventa
	);
	return $resEvent;
}
/**
 * Registra un nuevo punto de venta
 * 
 * @param int $codigoSucursal
 * @param int $nombrePuntoVenta
 * @return object Respuesta Siat
 */
function registroPuntoVenta($codigoSucursal, $nombrePuntoVenta)
{
	global $config;
	
	$resCuis = obtenerCuis(null, $codigoSucursal, true);
	//var_dump($resCuis);
	
	$service = new ServicioOperaciones();
	$service->setConfig((array)$config);
	$service->cuis = $resCuis->RespuestaCuis->codigo;
	
	$res = $service->registroPuntoVenta($codigoSucursal, 2, $nombrePuntoVenta);
	
	return $res;
}
/**
 * Obtiene un CUIS nuevo si aun no se tiene uno
 * 
 * @param int $codigoPuntoVenta
 * @param int $codigoSucursal
 * @param boolean $new true en caso de querer forzar para obtener un nuevo CUIS
 * @return object RespuestaCuis
 */
function obtenerCuis($codigoPuntoVenta, $codigoSucursal, $new = false)
{
	static $resCuis;
	global $config;
	
	if( $resCuis && !$new )
		return $resCuis;
		
	$serviceCodigos = new ServicioFacturacionCodigos(null, null, $config->tokenDelegado);
	$serviceCodigos->debug = true;
	$serviceCodigos->setConfig((array)$config);
	$resCuis = $serviceCodigos->cuis($codigoPuntoVenta, $codigoSucursal);
	
	
	return $resCuis;
}
function obtenerCufd($codigoPuntoVenta, $codigoSucursal, $cuis, $new = false)
{
	static $resCufd;
	global $config;
	
	if( $resCufd && !$new )
		return $resCufd;
		
	//$resCuis = obtenerCuis($codigoPuntoVenta, $codigoSucursal);
	
	$serviceCodigos = new ServicioFacturacionCodigos(null, null, $config->tokenDelegado);
	$serviceCodigos->setConfig((array)$config);
	$serviceCodigos->cuis = $cuis;
	$resCufd = $serviceCodigos->cufd($codigoPuntoVenta, $codigoSucursal);
	
	test_log($resCufd, 'cufd');
	
	return $resCufd;
}
/**
 * Obtiene las parametricas de eventos del servicio de sincronizacion
 * 
 * @param number $codigoSucursal
 * @param number $codigoPuntoVenta
 * @param int $buscarId
 * @return object|NULL La respuesta del servicio siat
 */
function obtenerListadoEventos($codigoSucursal = 0, $codigoPuntoVenta = 0, $buscarId = null)
{
	global $config;
	
	$resCuis = obtenerCuis($codigoPuntoVenta, $codigoSucursal);
	//##obtener listado de eventos
	$serviceSync = new ServicioFacturacionSincronizacion($resCuis->RespuestaCuis->codigo);
	$serviceSync->setConfig((array)$config);
	$serviceSync->cuis = $resCuis->RespuestaCuis->codigo;
	
	$eventsList = $serviceSync->sincronizarParametricaEventosSignificativos($codigoSucursal, $codigoPuntoVenta);
	if( !$buscarId )
		return $eventsList;
	
	//print_r($eventsList);
	$evento = null;
	foreach($eventsList->RespuestaListaParametricas->listaCodigos as $evt)
	{
		if( $evt->codigoClasificador == $buscarId )
		{
			$evento = $evt;
			break;
		}
	}
	
	return $evento;
}
function testFactura($sucursal, $puntoventa, SiatInvoice $factura, $tipoFactura)
{
	global $config;
	
	$resCuis = obtenerCuis($puntoventa, $sucursal);
	$resCufd = obtenerCufd($puntoventa, $sucursal, $resCuis->RespuestaCuis->codigo);
	
	echo "Codigo CUIS: ", $resCuis->RespuestaCuis->codigo, "\n";
	echo "Codigo CUFD: ", $resCufd->RespuestaCufd->codigo, "\n";
	echo "Codigo Control: ", $resCufd->RespuestaCufd->codigoControl, "\n";
	
	$service = SiatFactory::obtenerServicioFacturacion($config, $resCuis->RespuestaCuis->codigo, $resCufd->RespuestaCufd->codigo, $resCufd->RespuestaCufd->codigoControl);
	$service->debug = true;
	//$service = $config->modalidad == ServicioSiat::MOD_COMPUTARIZADA_ENLINEA ? 
	//	new ServicioFacturacionComputarizada($resCuis->RespuestaCuis->codigo, $resCufd->RespuestaCufd->codigo) :
	//	new ServicioFacturacionElectronica($resCuis->RespuestaCuis->codigo, $resCufd->RespuestaCufd->codigo);
	//$service->setConfig((array)$config);
	$service->codigoControl = $resCufd->RespuestaCufd->codigoControl;
	$res = $service->recepcionFactura($factura, SiatInvoice::TIPO_EMISION_ONLINE, $tipoFactura);
	test_log("RESULTADO RECEPCION FACTURA\n=============================");
	test_log($res);
	
	return $res;
}
function testPaquetes($codigoSucursal, $codigoPuntoVenta, array $facturas, $codigoControlAntiguo, $tipoFactura, $evento, $cafc = null)
{
	global $config;
	
	$resCuis = obtenerCuis($codigoPuntoVenta, $codigoSucursal);
	$resCufd = obtenerCufd($codigoPuntoVenta, $codigoSucursal, $resCuis->RespuestaCuis->codigo);
	//var_dump('CUIS PRIMARIO: ' . $resCuis->RespuestaCuis->codigo);
	
	if( !$evento )
		die('ERROR: No se encontro el evento');
	
	
	$service = SiatFactory::obtenerServicioFacturacion($config, $resCuis->RespuestaCuis->codigo, $resCufd->RespuestaCufd->codigo, $codigoControlAntiguo);
	//print_r($service);die;
	$res = $service->recepcionPaqueteFactura(
	 	$facturas,
		$evento->codigoRecepcionEventoSignificativo,
	 	SiatInvoice::TIPO_EMISION_OFFLINE,
	 	$tipoFactura,
	 	$cafc
	);
	test_log("RESULTADO RECEPCION PAQUETE\n=============================");
	test_log($res);
	//die;
	return $res;
}
function testRecepcionPaquete($codigoSucursal, $codigoPuntoVenta, $documentoSector, $tipoFactura, $codigoRecepcion)
{
	global $config;
	
	$resCuis = obtenerCuis($codigoPuntoVenta, $codigoSucursal);
	$resCufd = obtenerCufd($codigoPuntoVenta, $codigoSucursal, $resCuis->RespuestaCuis->codigo);
	
	$service = SiatFactory::obtenerServicioFacturacion($config,
		$resCuis->RespuestaCuis->codigo,
		$resCufd->RespuestaCufd->codigo,
		$resCufd->RespuestaCufd->codigoControl
	);
	//$service->codigoControl = $resCufd->RespuestaCufd->codigoControl;
	$res = $service->validacionRecepcionPaqueteFactura($codigoSucursal, $codigoPuntoVenta, $codigoRecepcion, $tipoFactura, $documentoSector);
	
	while( $res->RespuestaServicioFacturacion->codigoDescripcion == 'PENDIENTE' )
	{
		echo "REINTENTANTO RESPUESTA RECEPCION PAQUETE\n=====================\n";
		$res = $service->validacionRecepcionPaqueteFactura($codigoSucursal, $codigoPuntoVenta, $codigoRecepcion, $tipoFactura, $documentoSector);
	}
	echo "RESPUESTA RECEPCION PAQUETE\n=====================\n";
	print_r($res);
	return $res;
}
function testFirma($sucursal, $puntoventa, SiatInvoice $factura, $tipoFactura)
{
	global $config;
	
	//$pubCert 	= MOD_SIAT_DIR . SB_DS . 'certs' . SB_DS . 'gemgloo-publickey.pem';
	//$privCert 	= MOD_SIAT_DIR . SB_DS . 'certs' . SB_DS . 'GemgloosSA.pem';
	//echo $privCert, "\n";
	
	$config->modalidad 	= ServicioSiat::MOD_ELECTRONICA_ENLINEA;
	
	$resCuis = obtenerCuis($puntoventa, $sucursal);
	$resCufd = obtenerCufd($puntoventa, $sucursal, $resCuis->RespuestaCuis->codigo);

	echo "Codigo CUIS: ", $resCuis->RespuestaCuis->codigo, "\n";
	echo "Codigo CUFD: ", $resCufd->RespuestaCufd->codigo, "\n";
	echo "Codigo Control: ", $resCufd->RespuestaCufd->codigoControl, "\n";
	
	$service = new ServicioFacturacionElectronica($resCuis->RespuestaCuis->codigo, $resCufd->RespuestaCufd->codigo, $config->tokenDelegado);
	$service->setConfig((array)$config);
	$service->codigoControl = $resCufd->RespuestaCufd->codigoControl;
	$service->setPrivateCertificateFile($config->privCert);
	$service->setPublicCertificateFile($config->pubCert);
	$service->debug = !true;
	
	$tipoEmision 			= SiatInvoice::TIPO_EMISION_ONLINE;
	$res = $service->recepcionFactura($factura, $tipoEmision, $tipoFactura);
	
	return $res;
}
function testMasiva($codigoSucursal, $codigoPuntoVenta, $documentoSector, $facturas, $tipoFactura)
{
	global $config;
	
	$resCuis = obtenerCuis($codigoPuntoVenta, $codigoSucursal);
	$resCufd = obtenerCufd($codigoPuntoVenta, $codigoSucursal, $resCuis->RespuestaCuis->codigo);
	
	echo "Codigo CUIS: ", $resCuis->RespuestaCuis->codigo, "\n";
	echo "Codigo CUFD: ", $resCufd->RespuestaCufd->codigo, "\n";
	echo "Codigo Control: ", $resCufd->RespuestaCufd->codigoControl, "\n";
	
	$service = SiatFactory::obtenerServicioFacturacion($config, $resCuis->RespuestaCuis->codigo, $resCufd->RespuestaCufd->codigo, $resCufd->RespuestaCufd->codigoControl);
	$res = $service->recepcionMasivaFactura(
		$facturas,
		SiatInvoice::TIPO_EMISION_MASIVA,
		$tipoFactura
	);
	//print_r($res);
	return $res;
}
function testRecepcionMasiva($codigoSucursal, $codigoPuntoVenta, $documentoSector, $tipoFactura, $codigoRecepcion)
{
	global $config;
	
	$resCuis = obtenerCuis($codigoPuntoVenta, $codigoSucursal);
	$resCufd = obtenerCufd($codigoPuntoVenta, $codigoSucursal, $resCuis->RespuestaCuis->codigo);
	echo "Codigo CUIS: ", $resCuis->RespuestaCuis->codigo, "\n";
	echo "Codigo CUFD: ", $resCufd->RespuestaCufd->codigo, "\n";
	echo "Codigo Control: ", $resCufd->RespuestaCufd->codigoControl, "\n";
	
	$service = new ServicioFacturacionComputarizada(
		$resCuis->RespuestaCuis->codigo,
		$resCufd->RespuestaCufd->codigo
	);
	$service->setConfig((array)$config);
	//$service->codigoControl = $resCufd->RespuestaCufd->codigoControl;
	$res = $service->validacionRecepcionMasivaFactura($codigoSucursal, $codigoPuntoVenta, $codigoRecepcion, $tipoFactura, $documentoSector);
	print_r($res);
	
	while( $res->RespuestaServicioFacturacion->codigoDescripcion == 'PENDIENTE' )
	{
		sleep(3);
		echo "REINTENTANTO RESPUESTA RECEPCION MASIVA\n=====================\n";
		//$res = testRecepcionMasiva($codigoSucursal, $codigoPuntoVenta, $documentoSector, $tipoFactura, $codigoRecepcion);
		$res = $service->validacionRecepcionMasivaFactura($codigoSucursal, $codigoPuntoVenta, $codigoRecepcion, $tipoFactura, $documentoSector);
		print_r($res);
		
	}
	echo "RESPUESTA RECEPCION MASIVA\n===================\n";
	
	return $res;
}
function testCierreOperacionesSistema(int $sucursal, int $puntoventa)
{
	global $config;
	
	$resCuis = obtenerCuis($puntoventa, $sucursal);
	
	$service = new ServicioOperaciones($resCuis->RespuestaCuis->codigo);
	$service->setConfig((array)$config);
	$res = $service->cierreOperacionesSistema($sucursal, $puntoventa);
	
	return $res;
}
function listaPuntosVenta(int $sucursal = 0)
{
	global $config;
	
	$resCuis = obtenerCuis(0, $sucursal);
	
	$service = new ServicioOperaciones($resCuis->RespuestaCuis->codigo);
	$service->setConfig((array)$config);
	return $service->consultaPuntoVenta($sucursal);
}
function verificarComunicacion()
{
	global $config;
	$service = new ServicioFacturacionSincronizacion();
	$service->setConfig((array)$config);
	return $service->verificarComunicacion();
}