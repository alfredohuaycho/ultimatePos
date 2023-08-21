<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class ElectronicaHotel extends Hotel
{
	public function __construct()
	{
		parent::__construct();
		$this->classAlias 	= 'facturaElectronicaHotel';
	}
	public function validate()
	{
		parent::validate();
	}
}
