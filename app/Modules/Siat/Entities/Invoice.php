<?php
namespace App\Modules\Siat\Entities;

use Illuminate\Database\Eloquent\Model;
use App\Contact;
use App\Modules\Siat\Settings;

class Invoice extends Model
{
	const STATUS_ISSUED = 'ISSUED';
	const STATUS_VOID 	= 'VOID';
	
	protected	$table 		= 'mb_invoices';
	//protected	$guarded 	= ['invoice_id', 'created_at', 'updated_at'];
	protected	$fillable	= [
		'id', 
		'customer_id',
		'event_id',
		'package_id',
		'codigo_sucursal',
		'codigo_puntoventa',
		'codigo_documento_sector',
		'tipo_emision',
		'tipo_factura_documento',
		'tipo_documento_identidad',
		'codigo_metodo_pago',
		'codigo_moneda',
		'nit_emisor',
		'customer',
		'nit_ruc_nif',
		'complemento',
		'subtotal',
		'discount',
		'tax',
		'total',
		'giftcard_amount',
		'invoice_number',
		'invoice_number_cafc',
		'control_code',
		'cuf',
		'cufd',
		'cafc',
		'numero_tarjeta',
		'invoice_datetime',
		'tipo_cambio',
		'siat_id',
		'leyenda',
		'excepcion',
		'data',
		'ambiente',
		'user_id'
	];
	protected	$savedItems;
	/**
	 *
	 * @return \Illuminate\Database\Eloquent\Relations\HasMany
	 */
	public function items()
	{
		//return $this->morphMany(Comment::class, 'object', 'object_type');
		return $this->hasMany(InvoiceItem::class, 'invoice_id', 'id');
		//->orderBy('created_at', 'desc');
	}
	public function contact()
	{
		if( Settings::getInstance()->isUltimatePOS() )
			return $this->hasOne(Contact::class, 'id', 'customer_id');
			
		return $this->hasOne(\App\Modules\Siat\Entities\Customer::class, 'id', 'customer_id');
	}
	public function calculateTotals()
	{
		$this->subtotal = 0;
		$this->total 	= 0;
		
		foreach($this->getItems() as $item)
		{
			$this->subtotal += method_exists($item, 'calculateTotals') ? 
				$item->calculateTotals() : 
				(((float)$item->price * (float)$item->quantity) - (float)$item->discount);
		}
		
		$this->total = $this->subtotal - $this->discount;
		$this->tax = $this->total * 0.13;
	}
	/**
	 * 
	 * @return \Illuminate\Database\Eloquent\Relations\HasOne
	 */
	public function getCustomer()
	{
		return $this->contact;
	}
	public function saveItems($items)
	{
		$this->savedItems = $items;
	}
	public function getSavedItems()
	{
		return $this->savedItems;
	}
	/**
	 * 
	 * @return \App\Modules\Siat\Entities\InvoiceItem[]
	 */
	public function getItems()
	{
		$items = $this->items()->get();
		//var_dump($items);die;
		if( !count($items) && count($this->getSavedItems()) )
		{
			foreach($this->getSavedItems() as $i)
			{
				$item = new InvoiceItem($i);
				$item->calculateTotals();
				$items[] = $item;
			}
		}
		
		return $items;
	}
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
	public function getCustomFields()
	{
		$data = $this->getData();
		
		if( !isset($data->custom_fields) )
			return (object)[];
		
		return (object)$data->custom_fields;
	}
	public function getCustomField($field)
	{
		$fields = $this->getCustomFields();
		
		return property_exists($fields, $field) ? $fields->$field : null;
	}
}
