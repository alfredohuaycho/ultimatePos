<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class Telecomunicaciones extends SiatInvoice
{
	public function __construct()
	{
		parent::__construct();
		
		$this->classAlias	= 'facturaComputarizadaTelecomunicacion';
		$this->cabecera		= new InvoiceHeaderTelecomunicaciones();
		$this->endpoint		= 'https://pilotosiatservicios.impuestos.gob.bo/v2/ServicioFacturacionCompraVenta?wsdl';
	}
	public function validate()
	{
		parent::validate();
	}
	public function checkAmounts()
	{
		
	}
}
