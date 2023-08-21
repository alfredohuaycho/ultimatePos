<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Messages;

use Exception;

class SolicitudServicioValidacionRecepcionMasiva extends SolicitudRecepcion
{
	public	$codigoRecepcion;
	
	public function __construct()
	{
		
	}
	public function validate()
	{
		parent::validate();
		if( empty($this->codigoRecepcion) )
			throw new Exception('Codigo de recepcion invalido');
	}
}