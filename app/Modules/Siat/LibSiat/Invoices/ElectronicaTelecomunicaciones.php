<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class ElectronicaTelecomunicaciones extends Telecomunicaciones
{
	
	public function __construct()
	{
		parent::__construct();
		$this->classAlias 						= 'facturaElectronicaTelecomunicacion';
	}
	public function validate()
	{
		parent::validate();
	}
}