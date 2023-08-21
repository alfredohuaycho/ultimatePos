<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use Exception;

class InvoiceDetailPreValorada extends InvoiceDetail
{
	public	$actividadEconomica;
	public	$codigoProductoSin;
	public	$codigoProducto;
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
	}
}