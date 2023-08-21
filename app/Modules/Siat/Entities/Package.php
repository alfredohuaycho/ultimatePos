<?php
namespace App\Modules\Siat\Entities;

use Illuminate\Database\Eloquent\Model;

class Package extends Model
{
	protected	$table = 'mb_siat_event_packages';
	
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