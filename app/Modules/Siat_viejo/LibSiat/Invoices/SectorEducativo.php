<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class SectorEducativo extends SiatInvoice
{
	public function __construct()
	{
		parent::__construct();
		
		$this->classAlias 	= 'facturaComputarizadaSectorEducativo';
		$this->cabecera 	= new InvoiceHeaderEducativo();
		$this->cabecera->codigoDocumentoSector 	= DocumentTypes::FACTURA_SECTOR_EDUCATIVO;
		
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