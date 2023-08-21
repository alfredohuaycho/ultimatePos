<?php
namespace App\Modules\Siat\Controllers;

use App\Http\Controllers\Controller;
use Exception;
use App\Modules\Siat\Entities\Invoice;
use App\Modules\Siat\Entities\Batch;
use App\Modules\Siat\Models\InvoiceModel;
use App\Contact;
use Symfony\Component\HttpFoundation\ParameterBag;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Modules\Siat\Resources\ResourceInvoice;
use App\Modules\Siat\Classes\ExceptionInvalidNit;
use App\Product;
use App\Modules\Siat\Resources\ResourceProduct;

class ApiInvoicesController extends Controller
{
	/**
	 * @var InvoiceModel
	 */
	protected	$invoicesModel;
	/*
	public function __construct(InvoiceModel $model)
	{
		$this->invoicesModel = $model;
	}
	*/
	protected function fillInvoice(array $data)
	{
		$user = auth()->user();
		$invoice = new Invoice();
		$invoice->fill($data);
		
		$invoice->codigo_puntoventa = $data['punto_venta'];
		if( isset($data['data']['excepcion']) )
			$invoice->excepcion = $data['data']['excepcion'];
		if( isset($data['data']['nro_factura']) )
			$invoice->invoice_number_cafc = (int)$data['data']['nro_factura'];
		if( isset($data['invoice_date_time']) )
		{
			$invoice->invoice_datetime = date('Y-m-d H:i:s', strtotime($data['invoice_date_time']));
		}
		if( !$invoice->invoice_datetime )
			$invoice->invoice_datetime = date('Y-m-d H:i:s');
		
		$invoice->saveItems($data['items']);
		$invoice->user_id = $user->id;
		
		return $invoice;
	}
	public function create(InvoiceModel $model)
	{
		$user = auth()->user();
		try
		{
			$data = request()->json()->all();
			$invoice = $this->fillInvoice($data);
			
			if( in_array($invoice->codigo_documento_sector, [23]) )
			{
				if( (int)$data->mquantity <= 0 )
					throw new Exception('Debe especificar la cantidad de facturas a generar');
				DB::beginTransaction();
				$batch = new Batch();
				$batch->codigo_sucursal 		= $invoice->codigo_sucursal;
				$batch->codigo_puntoventa 		= $invoice->codigo_puntoventa;
				$batch->codigo_documento_sector = $invoice->codigo_documento_sector;
				$batch->cantidad				= (int)$data->mquantity;
				$batch->estado					= Batch::STATUS_PROCESSING;
				$batch->save();
				$invoices = [];
				for($i = 0; $i < (int)$data->mquantity; $i++)
				{
					$invoice->batch_id = $batch->id;
					$model->create($invoice);
					$invoices[] = $invoice;
					$invoice 	= $this->fillInvoice($data);
					$invoice->batch_id = $batch->id;
				}
				DB::commit();
				return response(['code' => 200, 'data' => $batch])->header('Content-Type', 'application/json');
			}
			else
			{
				DB::beginTransaction();
				$model->create($invoice);
				DB::commit();
				return response(['data' => new ResourceInvoice($invoice)])->header('Content-Type', 'application/json');
			}
			
			
		}
		catch (ExceptionInvalidNit $e)
		{
			DB::rollBack();
			return response(['error' => $e->getMessage(), 'response' => 'error_nit'], 500)->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			DB::rollBack();
			//print_r($e->getTrace());
			return response(['error' => $e->getMessage()], 500)->header('Content-Type', 'application/json');	
		}
	}
	public function read()
	{
		
	}
	public function readAll()
	{
		$user = auth()->user();
		try
		{
			$limit	= 25;
			$page 	= (int)request()->get('page');
			$offset = ($page <= 1) ? 0 : (($page - 1) * $limit);
			$count	= Invoice::all()->count();
			$total_pages = ceil($count / $limit);
			$items 	= Invoice::orderBy('id', 'desc')->offset($offset)->limit($limit)->get();
			$invoices = [];
			foreach($items as $item)
			{
				$invoices[] = new ResourceInvoice($item);
			}
			return response(['data' => $invoices])
				->header('Content-Type', 'application/json')
				->header('Total-Pages', $total_pages);
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage()], 500)->header('Content-Type', 'application/json');
		}
	}
	public function anular(int $id, InvoiceModel $model)
	{
		$user = auth()->user();
		try
		{
			$invoice = Invoice::find($id);
			if( !$invoice )
				throw new Exception('La factura no existe');
			$model->void($invoice, (object)request()->json()->all());
			
			return response(['data' => $invoice])
				->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage()], 500)->header('Content-Type', 'application/json');
		}
	}
	public function search()
	{
		$keyword = request()->get('keyword');
		$invoices = Invoice::where('invoice_number', 'like', '%' . $keyword . '%')
			->orWhere('customer', 'like', '%' . $keyword . '%')
			->orWhere('nit_ruc_nif', 'like', '%' . $keyword . '%')->limit(25)->get();
		$items = [];
		foreach($invoices as $inv)
		{
			$items[] = new ResourceInvoice($inv);
		}
		return response(['data' => $items])->header('Content-Type', 'application/json');
	}
	public function searchProduct()
	{
		$keyword = request()->get('keyword');
		$products = Product::where('sku', 'like', '%' . $keyword . '%')->orWhere('name', 'like', '%' . $keyword . '%')->limit(25)->get();
		$items = [];
		foreach($products as $prod)
		{
			$items[] = new ResourceProduct($prod);
		}
		return response(['data' => $items])
			->header('Content-Type', 'application/json');
	}
	public function sendMassiveBatch(int $id)
	{
		try
		{
			$batch = Batch::find($id);
			if( !$batch )
				throw new Exception('El lote de facturas no existe');
			$this->invoicesModel->sendMassiveBatch($batch);
			return response(['data' => $batch])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage()], 500)->header('Content-Type', 'application/json');
		}
	}
}