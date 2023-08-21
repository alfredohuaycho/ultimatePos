<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Message;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\SiatInvoice;
use Exception;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class AlquilerBienInmueble extends CompraVenta
{
	
	public function __construct()
	{
		parent::__construct();
		$this->cabecera = new InvoiceHeaderAlquiler();
		$this->classAlias 						= 'facturaComputarizadaAlquilerBienInmueble';
		$this->cabecera->codigoDocumentoSector 	= DocumentTypes::FACTURA_ALQUILER_INMUEBLES;
	}
	public function validate()
	{
		parent::validate();
	}
}
