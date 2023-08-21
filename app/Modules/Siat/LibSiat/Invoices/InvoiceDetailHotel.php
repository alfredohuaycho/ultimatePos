<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use Exception;

class InvoiceDetailHotel extends InvoiceDetail
{
	public	$actividadEconomica;
	public	$codigoProductoSin;
	public	$codigoProducto;
	public	$codigoTipoHabitacion;
	public	$descripcion;
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
		if( (int)$this->codigoTipoHabitacion <= 0 )
			throw new Exception('Debe especificar el codigo tipo habitacion para el detalle');
		parent::validate();
	}
}