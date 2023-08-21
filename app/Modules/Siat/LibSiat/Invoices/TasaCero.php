<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

class TasaCero extends CompraVenta
{
	public function __construct()
	{
		parent::__construct();
		
		$this->classAlias 				= 'facturaComputarizadaTasaCero';
		$this->cabecera->codigoDocumentoSector 	= DocumentTypes::FACTURA_TASA_CERO_LIBROS;
		$this->cabecera->addSkipProperty('numeroSerie');
		$this->cabecera->addSkipProperty('numeroImei');
	}
	public function validate()
	{
		parent::validate();
		$this->cabecera->montoTotalSujetoIva = 0;
		foreach($this->detalle as $d)
		{
			$d->addSkipProperty('numeroSerie');
			$d->addSkipProperty('numeroImei');
		}
	}
}