<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class ElectronicaServicioTuristicoHospedaje extends ServicioTuristicoHospedaje
{
	public function __construct()
	{
		parent::__construct();
		$this->classAlias 				= 'facturaElectronicaServicioTuristicoHospedaje';
	}
}