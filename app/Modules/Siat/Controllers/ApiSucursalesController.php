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
	public function create()
	{
		try
		{
			$data = request()->json()->all();
			$branch = new Branch($data);
			$branch->save();
			return response(['status' => 'ok', 'data' => $branch])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage()], 500, ['Content-Type' => 'application/json']);
		}
	}
	public function update()
	{
		try
		{
			$data = request()->json()->all();
			if( !isset($data['id']) )
				throw new Exception('Identificador de sucursal invalido');
			$branch = Branch::find($data['id']);
			if( !$branch )
				throw new Exception('La sucursal no existe');
			$branch->fill($data);
			$branch->save();
			
			return response(['status' => 'ok', 'data' => $branch, 'message' => 'Sucursal actualizada'])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage()], 500, ['Content-Type' => 'application/json']);
		}
	}
	public function delete($id)
	{
		try
		{
			$branch = Branch::find($id);
			if( !$branch )
				throw new Exception('La sucursal no existe');
			$branch->delete();
			return response(['status' => 'ok', 'message' => 'Sucursal borrada'])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage()], 500, ['Content-Type' => 'application/json']);
		}
	}
}