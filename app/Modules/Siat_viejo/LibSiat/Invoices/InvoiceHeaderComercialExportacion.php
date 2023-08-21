<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class InvoiceHeaderComercialExportacion extends InvoiceHeader
{
	public	$nitEmisor;
	public	$razonSocialEmisor;
	public	$municipio;
	public	$telefono;
	public	$numeroFactura;
	public	$cuf;
	public	$cufd;
	public	$codigoSucursal;
	public	$direccion;
	public	$codigoPuntoVenta;
	public	$fechaEmision;
	public	$nombreRazonSocial;
	public	$codigoTipoDocumentoIdentidad;
	public	$numeroDocumento;
	public	$complemento;
	public	$direccionComprador;
	public	$codigoCliente;
	public 	$incoterm;
	public 	$incotermDetalle;
	public 	$puertoDestino;
	public 	$lugarDestino;
	public 	$codigoPais;
	public	$codigoMetodoPago;
	public	$numeroTarjeta;
	public	$montoTotal;
	public 	$costosGastosNacionales;
	public 	$totalGastosNacionalesFob;
	public 	$costosGastosInternacionales;
	public 	$totalGastosInternacionales;
	public 	$montoDetalle;
	public	$montoTotalSujetoIva;
	public	$codigoMoneda;
	public	$tipoCambio;
	public	$montoTotalMoneda;
	public 	$numeroDescripcionPaquetesBultos;
	public 	$informacionAdicional;
	public	$descuentoAdicional;
	public	$codigoExcepcion;
	public	$cafc;
	public	$leyenda = 'Ley Nro 453: Tienes derecho a recibir información sobre las características y contenidos de los servicios que utilices.';
	public	$usuario;
	public	$codigoDocumentoSector;
	
	public function __construct()
	{
		parent::__construct();
		$this->skipProperties[] = 'montoGiftCard';
		
	}
	public function validate()
	{
		parent::validate();
	}
}