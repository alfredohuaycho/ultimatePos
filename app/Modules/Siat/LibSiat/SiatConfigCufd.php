<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat;

class SiatConfigCufd extends SiatConfigCode
{
	public 	$codigoControl;
	
	public function bind($data)
	{
		if( isset($data->codigo_control) )
			$this->codigoControl = $data->codigo_control;
		if( isset($data->fecha_vigencia) )
			$this->fechaVigencia = $data->fecha_vigencia;
		
		parent::bind($data);
	}
}