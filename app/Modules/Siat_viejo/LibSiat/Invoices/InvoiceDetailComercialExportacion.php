<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\InvoiceDetail;
use Exception;

class InvoiceDetailComercialExportacion extends InvoiceDetail
{
	public	$actividadEconomica;
	public	$codigoProductoSin;
	public	$codigoProducto;
	public	$codigoNandina;
	public	$descripcion;
	public	$cantidad;
	public	$unidadMedida;
	public	$precioUnitario;
	public	$montoDescuento;
	public	$subTotal;
	
	
	public function __construct()
	{
		parent::__construct();
		$this->skipProperties[] = 'numeroSerie';
		$this->skipProperties[] = 'numeroImei';
	}
	public function validate()
	{
		parent::validate();
		if( empty($this->codigoNandina) )
			throw new Exception('ERROR VALIDACION: Codigo nandina esta vacio');
	}
}