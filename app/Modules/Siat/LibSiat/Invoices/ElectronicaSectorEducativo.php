<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class ElectronicaSectorEducativo extends SectorEducativo
{
	public function __construct()
	{
		parent::__construct();
		
		$this->classAlias 	= 'facturaElectronicaSectorEducativo';
	}
	public function validate()
	{
		parent::validate();
	}
}