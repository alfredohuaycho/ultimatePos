<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class EntidadFinanciera extends SiatInvoice
{
	public function __construct()
	{
		parent::__construct();
		$this->cabecera = new InvoiceHeaderEntidadFinanciera();
		$this->classAlias 						= 'facturaComputarizadaEntidadFinanciera';
		$this->cabecera->codigoDocumentoSector 	= DocumentTypes::FACTURA_ENT_FINANCIERA;
	}
	public function validate()
	{
		foreach($this->detalle as $d)
		{
			$d->addSkipProperty('numeroSerie');
			$d->addSkipProperty('numeroImei');
		}
		parent::validate();
	}
}