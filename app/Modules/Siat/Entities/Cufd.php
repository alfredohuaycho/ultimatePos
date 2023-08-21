<?php
namespace App\Modules\Siat\Entities;

use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class Cufd extends Model
{
	protected	$table = 'mb_siat_cufd';
	
	protected $casts = [
		'updated_at' => 'datetime:Y-m-d H:i:s',
		'created_at' => 'datetime:Y-m-d H:i:s',
	];
	/**
	 * Prepare a date for array / JSON serialization.
	 */
	protected function serializeDate(DateTimeInterface $date): string
	{
		return $date->format('Y-m-d H:i:s');
	}
	
	public function expirado()
	{
		if( !$this->created_at || !$this->fecha_vigencia )
			return true;
		$vtime = strtotime($this->fecha_vigencia);
		if( time() > $vtime )
			return true;
		
		return false;
	}
}