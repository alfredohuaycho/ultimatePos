<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Message;
use Exception;

class InvoiceHeaderHospital extends InvoiceHeader
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
	public	$codigoCliente;
	public	$modalidadServicio; //## CA ##
	public	$codigoMetodoPago;
	public	$numeroTarjeta;
	public	$montoTotal;
	public	$montoTotalSujetoIva;
	public	$codigoMoneda;
	public	$tipoCambio;
	public	$montoTotalMoneda;
	public	$montoGiftCard = null;
	public	$descuentoAdicional;
	public	$codigoExcepcion;
	public	$cafc;
	public	$leyenda = 'Ley Nro 453: Tienes derecho a recibir información sobre las características y contenidos de los servicios que utilices.';
	public	$usuario;
	public	$codigoDocumentoSector;
	
	public function __construct()
	{
		parent::__construct();
	}
	public function validate()
	{
		parent::validate();
	}
}