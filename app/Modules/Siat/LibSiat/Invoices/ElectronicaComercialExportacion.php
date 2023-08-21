<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class ElectronicaComercialExportacion extends ElectronicaCompraVenta
{
	
	public function __construct()
	{
		parent::__construct();
		$this->cabecera = new InvoiceHeaderComercialExportacion();
		$this->classAlias 						= 'facturaElectronicaComercialExportacion';
		$this->cabecera->codigoDocumentoSector 	= DocumentTypes::FACTURA_COMERCIAL_EXPORTACION;
	}
	public function validate()
	{
		parent::validate();
	}
}