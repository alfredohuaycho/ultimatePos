<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Message;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\SiatInvoice;
use Exception;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class ElectronicaPreValorada extends PreValorada
{
	
	public function __construct()
	{
		parent::__construct();
		$this->classAlias 	= 'facturaElectronicaPrevalorada';
	}
	public function validate()
	{
		parent::validate();
	}
}
