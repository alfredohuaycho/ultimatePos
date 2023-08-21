<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class ElectronicaServicioBasico extends ServicioBasico
{
	public function __construct()
	{
		parent::__construct();
		$this->classAlias = 'facturaElectronicaServicioBasico';
	}
}