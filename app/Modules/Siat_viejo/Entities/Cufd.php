<?php
namespace App\Modules\Siat\Entities;

use Illuminate\Database\Eloquent\Model;

class Cufd extends Model
{
	protected	$table = 'mb_siat_cufd';
	
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