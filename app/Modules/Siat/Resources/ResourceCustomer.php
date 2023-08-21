<?php
namespace App\Modules\Siat\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ResourceCustomer extends JsonResource
{
	public function toArray($request)
	{
		//print_r($this);die;
		$data = (array)$this->resource->attributesToArray();
		$data['text'] = trim(sprintf("%s %s", $this->firstname, $this->lastname));
		return $data;
	}
}