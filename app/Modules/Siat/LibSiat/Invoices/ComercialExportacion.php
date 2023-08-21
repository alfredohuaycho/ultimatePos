<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;

/**
 * 
 * @author J. Marcelo Aviles Paco
 */
class ComercialExportacion extends CompraVenta
{
	
	public function __construct()
	{
		parent::__construct();
		$this->cabecera = new InvoiceHeaderComercialExportacion();
		$this->classAlias 						= 'facturaComputarizadaComercialExportacion';
		$this->cabecera->codigoDocumentoSector 	= DocumentTypes::FACTURA_COMERCIAL_EXPORTACION;
	}
	public function validate()
	{
		parent::validate();
	}
	public function checkAmounts()
	{
		parent::checkAmounts();
		$this->cabecera->montoDetalle = 0;
		foreach($this->detalle as $detalle)
		{
			$this->cabecera->montoDetalle += $detalle->subTotal;
		}
		$this->cabecera->totalGastosNacionalesFob 		+= $this->cabecera->montoDetalle;
		$this->cabecera->montoTotalMoneda 				= $this->cabecera->totalGastosNacionalesFob + $this->cabecera->totalGastosInternacionales;
		$this->cabecera->montoTotal 					= sb_number_format($this->cabecera->montoTotalMoneda * $this->cabecera->tipoCambio, 2, '.', '');
		$this->cabecera->costosGastosNacionales			= $this->formatDetails($this->cabecera->costosGastosNacionales);
		$this->cabecera->costosGastosInternacionales 	= $this->formatDetails($this->cabecera->costosGastosInternacionales);
	}
	protected function formatDetails($jsonStr)
	{
		if( !($data = json_decode($jsonStr)) )
			return $jsonStr;
		
		$obj = [];
		foreach($data as $item)
		{
			foreach($item as $key => $val)
			{
				$obj[$key] = $val;
			}
		}
		//print_r($obj);
		return json_encode($obj);
	}
}