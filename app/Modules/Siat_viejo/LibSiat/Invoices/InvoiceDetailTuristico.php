<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

class InvoiceDetailTuristico extends InvoiceDetail
{
	public	$actividadEconomica;
	public	$codigoProductoSin;
	public	$codigoProducto;
	public	$descripcion;
	public	$codigoTipoHabitacion;
	public	$cantidad;
	public	$unidadMedida;
	public	$precioUnitario;
	public	$montoDescuento;
	public	$subTotal;
	public	$detalleHuespedes;
	
	public function __construct()
	{
		parent::__construct();
		$this->xmlAttributes = array_merge($this->xmlAttributes, [
			'detalleHuespedes'			=> [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
		]);
		$this->skipProperties[] = 'numeroSerie';
		$this->skipProperties[] = 'numeroImei';
	}
	public function validate()
	{
		parent::validate();
	}
}