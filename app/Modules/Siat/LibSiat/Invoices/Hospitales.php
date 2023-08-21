<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class Hospitales extends SiatInvoice
{
	public function __construct()
	{
		parent::__construct();
		$this->classAlias	= 'facturaComputarizadaHospitalClinica';
		$this->cabecera 	= new InvoiceHeaderHospital();
		$this->cabecera->codigoDocumentoSector 	= DocumentTypes::FACTURA_HOSPITALES;
	}
	public function validate()
	{
		parent::validate();
	}
}
