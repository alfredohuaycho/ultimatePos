<?php
namespace App\Modules\Siat\Entities;

use Illuminate\Database\Eloquent\Model;

class InvoiceItem extends Model
{
	protected	$table = 'mb_invoice_items';
	//protected	$guarded = ['id', 'updated_at', 'created_at'];
	protected	$fillable = [
		'id',
		'invoice_id',
		'product_id',
		'product_code',
		'product_name',
		'quantity',
		'price',
		'subtotal',
		'discount',
		'total',
		'codigo_actividad',
		'codigo_producto_sin',
		'unidad_medida',
		'imei',
		'numero_serie',
		'data',
	];
	
	public function save(array $options = [])
	{
		if( is_array($this->data) || is_object($this->data) )
			$this->data = json_encode($this->data);
		return parent::save($options);
	}
	public function calculateTotals()
	{
		$this->subtotal = ((float)$this->price * (float)$this->quantity);
		$this->total = ($this->subtotal - (float)$this->discount);
		
		return $this->total;
	}
}
