<?php
namespace App\Modules\Siat\Entities;

use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
	const STATUS_OPEN 		= 'OPEN';
	const STATUS_CLOSED 	= 'CLOSED';
	const STATUS_PROCESSING = 'PROCESSING';
	
	protected	$table = 'mb_siat_events';
	protected	$fillable = ['evento_id', 'codigo_sucursal', 'codigo_puntoventa', 'codigo_recepcion', 'descripcion', 'fecha_inicio', 'fecha_fin', 'cufd_evento',
		'data'
	];
	
	public function save(array $options = [])
	{
		if( is_array($this->data) || is_object($this->data) )
			$this->data = json_encode($this->data);
		return parent::save($options);
	}
	public function getData()
	{
		$data = null;
		
		if( is_string($this->data) && !empty($this->data) )
			$data = json_decode($this->data);
			
		if( !$data || (!is_array($data) && !is_object($data)))
			$data = (object)[];
			
		return $data;
	}
}