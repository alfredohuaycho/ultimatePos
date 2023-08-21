<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class ElectronicaEntidadFinanciera extends EntidadFinanciera
{
	public function __construct()
	{
		parent::__construct();
		$this->classAlias = 'facturaElectronicaEntidadFinanciera';
	}
	public function validate()
	{
		parent::validate();
	}
}