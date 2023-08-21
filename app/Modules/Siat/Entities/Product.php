<?php
namespace App\Modules\Siat\Entities;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
	protected	$table = 'mb_invoice_products';
	protected	$fillable = ['user_id', 'code', 'name', 'billing_name', 'description', 'price', 'barcode', 'serialnumber', 'imei', 'codigo_sin', 
		'codigo_actividad',
		'unidad_medida'
	];
	
	
}