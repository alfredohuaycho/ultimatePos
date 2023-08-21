<?php
namespace App\Modules\Siat\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Siat\Entities\Invoice;
use Dompdf\Dompdf;
use App\Modules\Siat\Models\InvoiceModel;

class SiatController extends Controller
{
	public function sync()
	{
		return view('Siat::sync');
	}
	public function cufds()
	{
		return view('Siat::cufds');
	}
	public function facturas()
	{
		return view('Siat::facturas');
	}
	public function facturador()
	{
		return view('Siat::facturador');
	}
	public function eventos()
	{
		return view('Siat::eventos');
	}
	public function view(int $id, InvoiceModel $model)
	{
		$invoice = Invoice::find($id);
		
		$dompdf = $model->buildPdf($invoice);
		
		return response()->stream(function() use($dompdf)
		{
			$dompdf->stream('invoice', ['Attachment' => 0]);
		}, 200, ['Content-Type' => 'application/pdf'])->sendContent();
	}
}