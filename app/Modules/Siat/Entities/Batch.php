<?php
namespace App\Modules\Siat\Entities;

use Illuminate\Database\Eloquent\Model;

class Batch extends Model
{
	protected	$table 		= 'mb_massive_batches';
	const STATUS_PROCESSING = 'PROCESSING';
	const STATUS_COMPLETED	= 'COMPLETED';
	
	public function invoices()
	{
		return $this->hasMany(Invoice::class, 'batch_id', 'id');
	}
}