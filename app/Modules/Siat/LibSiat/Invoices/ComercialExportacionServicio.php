<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class ComercialExportacionServicio extends CompraVenta
{
	public function __construct()
	{
		parent::__construct();
		$this->cabecera = new InvoiceHeaderExportacionServicios();
		$this->classAlias 						= 'facturaComputarizadaComercialExportacionServicio';
		$this->cabecera->codigoDocumentoSector 	= DocumentTypes::FACTURA_COM_EXPORT_SERVICIOS;
	}
	public function validate()
	{
		foreach($this->detalle as $d)
		{
			$d->addSkipProperty('numeroSerie');
			$d->addSkipProperty('numeroImei');
		}
		parent::validate();
	}
}