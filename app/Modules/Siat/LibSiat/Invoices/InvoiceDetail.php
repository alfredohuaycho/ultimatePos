<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Message;

class InvoiceDetail extends Message
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
	public	$numeroSerie;
	public	$numeroImei;
	
	public function __construct()
	{
		$this->unidadMedida	= 58;
		$this->xmlAttributes = [
			'numeroSerie' => [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
			'numeroImei' => [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
		];
	}
	public function validate()
	{
		foreach($this->xmlAttributes as $attr => $data)
		{
			//var_dump($attr, $this->$attr);
			if( $this->$attr === null ) continue;
			//if( (int)$this->$attr === 0 || !empty($this->$attr) )
			unset($this->xmlAttributes[$attr]);
		}
	}
}