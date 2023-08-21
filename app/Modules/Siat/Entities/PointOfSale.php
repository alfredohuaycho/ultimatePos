<?php
namespace App\Modules\Siat\Entities;

use Illuminate\Database\Eloquent\Model;

class PointOfSale extends Model
{
	protected	$table = 'mb_siat_puntos_venta';
	protected	$fillable = ['codigo', 'codigo_sucursal', 'nombre', 'tipo_id', 'tipo'];
	
}