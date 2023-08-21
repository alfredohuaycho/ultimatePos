<?php
namespace App\Modules\Siat\Entities;

use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
	const STATUS_ENABLED	= 'ENABLED';
	const STATUS_DISABLED	= 'DISABLED';
	const STATUS_BLOCKED	= 'BLOCKED';
	
	protected	$table 		= 'mb_customers';
	protected	$fillable 	= [
		'external_id', 'user_id', 'code', 'firstname', 'lastname', 'identity_document', 'nit_ruc_nif', 'phone', 'email', 'address', 'status'
	];
	
	public function save(array $options = [])
	{
		if( empty($this->status) )
			$this->status = self::STATUS_ENABLED;
		
		return parent::save($options);
	}
}