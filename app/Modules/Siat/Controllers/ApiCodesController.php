<?php
namespace App\Modules\Siat\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Siat\Models\SiatModel;
use App\Modules\Siat\Entities\Cufd;
use Exception;

class ApiCodesController  extends Controller
{
	protected	$siatModel;
	
	public function __construct(SiatModel $model)
	{
		$this->siatModel = $model;
	}
	public function cuis()
	{
	}
	public function leerCUFDS()
	{
		$user = auth()->user();
		try
		{
			$limit 		= request()->get('limit', 50);
			$sucursal 	= request()->get('sucursal', 0);
			$puntoventa = request()->get('puntoventa', 0);
			$items 		= Cufd::where('codigo_sucursal', $sucursal)->where('codigo_puntoventa', $puntoventa)->orderBy('id', 'desc')->get();
			return response(['data' => $items])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage(), 'data' => null], 500)->header('Content-Type', 'application/json');
		}
	}
}