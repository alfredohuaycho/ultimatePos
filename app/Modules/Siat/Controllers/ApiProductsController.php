<?php
namespace App\Modules\Siat\Controllers;

use App\Http\Controllers\Controller;
use Exception;
use App\Modules\Siat\Entities\Product;

class ApiProductsController extends Controller
{
	public function create()
	{
		
		$user = auth()->user();
		try
		{
			$data = request()->json()->all();
			$product = new Product($data);
			$product->user_id = $user ? $user->id : 0;;
			$product->save();
			return response(['status' => 'ok', 'data' => $product])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['status' => 'error', 'error' => $e->getMessage()], 500);
		}
	}
	public function read()
	{
		
	}
	public function readAll()
	{
		try 
		{
			$keyword 	= request()->get('q');
			$page 		= (int)request()->get('page', 1);
			$limit		= (int)request()->get('limit', 25);
			$offset		= ($page <= 1) ? 0 : (($page - 1) * $limit);
			
			$count		= $keyword ? Product::where('code', 'like', "%{$keyword}%")->orWhere('name', 'like', "%{$keyword}%")->count() : Product::count();
			$total_pages	= ceil($count/$limit);
			
			$items 			= [];
			$query			= null;
			if( empty($keyword) )
				$query = Product::where('id', '>', 0);
			else 
			{
				$query = Product::where('code', 'like', "%{$keyword}%")->orWhere('name', 'like', "%{$keyword}%");
			}
			
			$items = $query->orderBy('id', 'desc')->offset($offset)->limit($limit)->get();
			
			return response(['status' => 'ok', 'data' => $items, 'total_products' => $count, 'total_pages' => $total_pages])
				->header('Content-Type', 'application/json')->header('Total-Pages', $total_pages);
		} 
		catch (Exception $e) 
		{
			return response(['status' => 'error', 'error' => $e->getMessage()], 500);
		}
	}
	public function update()
	{
		$user = auth()->user();
		try
		{
			$data = request()->json()->all();
			if( !$data['id'] )
				throw new Exception('Identificador de producto invalido');
			$product = Product::find($data['id']);
			if( !$product )
				throw new Exception('El producto no existe');
			$product->fill($data);
			$product->save();
			return response(['status' => 'ok', 'data' => $product])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['status' => 'error', 'error' => $e->getMessage()], 500);
		}
	}
	public function delete(int $id)
	{
		$user = auth()->user();
		try
		{
			$product = Product::find($id);
			if( !$product )
				throw new Exception('El producto no existe');
			$product->delete();
			return response(['status' => 'ok', 'data' => $product])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['status' => 'error', 'error' => $e->getMessage()], 500);
		}
	}
}
