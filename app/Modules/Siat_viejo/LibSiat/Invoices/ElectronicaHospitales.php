<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class ElectronicaHospitales extends Hospitales
{
	public function __construct()
	{
		parent::__construct();
		$this->classAlias = 'facturaElectronicaHospitalClinica';
	}
	public function validate()
	{
		parent::validate();
	}
}
