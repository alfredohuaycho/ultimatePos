<?php
namespace App\Modules\Siat\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SiatInvoice;

class ResourceInvoice extends JsonResource
{
	public function toArray($request)
	{
		$nro_factura = $this->invoice_number_cafc ?: $this->invoice_number;
		$data = (array)$this->resource->attributesToArray();
		//print_r($data);die;
		$data['siat_url'] = SiatInvoice::buildUrl($this->nit_emisor, $this->cuf, $nro_factura, $this->ambiente);
		$data['print_url'] = route('siat.facturas.view', ['id' => $this->resource->id]);
		return $data;
	}
}