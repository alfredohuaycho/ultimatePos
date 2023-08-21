<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class CompraVenta extends SiatInvoice
{
	public function __construct()
	{
		parent::__construct();
		
		$this->classAlias 				= 'facturaComputarizadaCompraVenta';
		$this->cabecera->codigoDocumentoSector 	= DocumentTypes::FACTURA_COMPRA_VENTA;
		
		$this->endpoint					= 'https://pilotosiatservicios.impuestos.gob.bo/v2/ServicioFacturacionCompraVenta?wsdl';
	}
	public function validate()
	{
		parent::validate();
	}
}
