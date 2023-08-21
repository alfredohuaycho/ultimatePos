<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class Hotel extends SiatInvoice
{
	public function __construct()
	{
		parent::__construct();
		$this->classAlias 	= 'facturaComputarizadaHotel';
		$this->cabecera 	= new InvoiceHeaderTuristico();
		$this->cabecera->codigoDocumentoSector 	= DocumentTypes::FACTURA_HOTELES;
		$this->cabecera->addSkipProperty('razonSocialOperadorTurismo');
	}
	public function validate()
	{
		$this->cabecera->addSkipProperty('razonSocialOperadorTurismo');
		parent::validate();
	}
}
