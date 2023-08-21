<?php
namespace App\Modules\Siat\Entities;

use Illuminate\Database\Eloquent\Model;

class Branch extends Model
{
	protected	$table = 'mb_siat_sucursales';
	protected	$fillable = [
		'code', 'name', 'address', 'city'
	];
}