<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Message;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\SiatInvoice;
use Exception;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class PreValorada extends CompraVenta
{
	
	public function __construct()
	{
		parent::__construct();
		$this->cabecera							= new InvoiceHeaderPreValorada();
		$this->classAlias 						= 'facturaComputarizadaPrevalorada';
		$this->cabecera->codigoDocumentoSector 	= DocumentTypes::FACTURA_PREVALORADA;
	}
	public function validate()
	{
		parent::validate();
	}
}
