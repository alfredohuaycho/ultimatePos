<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;


class ElectronicaComercialExportacionServicio extends ComercialExportacionServicio
{
	public function __construct()
	{
		parent::__construct();
		$this->classAlias = 'facturaElectronicaComercialExportacionServicio';
	}
	public function validate()
	{
		parent::validate();
	}
}