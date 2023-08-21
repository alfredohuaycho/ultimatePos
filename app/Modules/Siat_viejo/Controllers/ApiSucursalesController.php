<?php
namespace App\Modules\Siat\Controllers;

use App\Http\Controllers\Controller;
use Exception;
use App\Modules\Siat\Entities\Branch;

class ApiSucursalesController extends Controller
{
	public function readAll()
	{
		$items = Branch::all();
		
		return response(['data' => $items])->header('Content-Type', 'application/json');
	}
}