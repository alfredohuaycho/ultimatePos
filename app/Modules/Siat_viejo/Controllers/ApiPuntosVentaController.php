<?php
namespace App\Modules\Siat\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Siat\Entities\PointOfSale;

class ApiPuntosVentaController extends Controller
{
	public function readAll()
	{
		$sucursal = request()->get('sucursal', 0);
		$items = PointOfSale::where('codigo_sucursal', $sucursal)->get();
		
		return response(['data' => $items])->header('Content-Type', 'application/json');
	}
}