<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class ServicioBasico extends CompraVenta
{
	public function __construct()
	{
		parent::__construct();
		$this->cabecera = new InvoiceHeaderServicioBasico();
		$this->classAlias 						= 'facturaComputarizadaServicioBasico';
		$this->cabecera->codigoDocumentoSector 	= DocumentTypes::FACTURA_SERV_BASICOS;
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