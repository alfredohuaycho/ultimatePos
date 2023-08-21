<?php
namespace App\Modules\Siat\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
//use Illuminate\Http\Resources\Json\Resource;
//use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SiatInvoice;
use App\Variation;
use App\Modules\Siat\Settings;

class ResourceProduct extends JsonResource
//class ResourceProduct extends Resource
{
	public function toArray($request)
	{
		$data = (array)$this->resource->attributesToArray();
		if( Settings::getInstance()->isUltimatePOS() )
		{
			$variation = Variation::where('product_id', $this->resource->id)->first();
			
			$data['code'] 		= $data['sku'];
			$data['price'] 		= (float)$variation->default_sell_price;
			$data['numserie'] 	= '';
			$data['imei'] 		= '';
			$data['codigo_sin'] = $data['codigo_producto_sin'];
			$data['codigo_actividad'] = $data['actividad_economica'];
			
		}
		$data['price'] = (float)$data['price'];
		return $data;
		
	}
}
