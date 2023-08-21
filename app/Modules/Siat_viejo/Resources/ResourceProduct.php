<?php
namespace App\Modules\Siat\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SiatInvoice;
use App\Variation;

class ResourceProduct extends JsonResource
{
	public function toArray($request)
	{
		$variation = Variation::where('product_id', $this->resource->id)->first();
		$data = (array)$this->resource->attributesToArray();
		$data['code'] 		= $data['sku'];
		$data['price'] 		= (float)$variation->default_sell_price;
		$data['numserie'] 	= '';
		$data['imei'] 		= '';
		$data['codigo_sin'] = $data['codigo_producto_sin'];
		$data['codigo_actividad'] = $data['actividad_economica'];
		
		return $data;
	}
}