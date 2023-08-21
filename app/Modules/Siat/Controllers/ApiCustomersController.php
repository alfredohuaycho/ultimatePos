<?php
namespace App\Modules\Siat\Controllers;

use App\Http\Controllers\Controller;
use Exception;
use App\Modules\Siat\Entities\Customer;
use App\Modules\Siat\Resources\ResourceCustomer;

class ApiCustomersController extends Controller
{
	public function create()
	{
		$user = auth()->user();
		try
		{
			$data = request()->json()->all();
			$customer = new Customer($data);
			$customer->user_id = $user ? $user->id : 0;
			if( !$customer->identity_document )
				$customer->identity_document = 0;
			if( !$customer->phone )
				$customer->phone = '';
			$customer->save();
			return response(['data' => $customer], 200, ['Content-Type' => 'application/json']);
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage()], 500, ['Content-Type' => 'application/json']);
		}
	}
	public function read()
	{
		try
		{
			$id = (int)request()->get('id');
			if( $id <= 0 )
				throw new Exception('Identificador de cliente invalido');
			$customer = Customer::find($id);
			if( !$customer )
				throw new Exception('El cliente no existe');
			return response(['data' => $customer], 200, ['Content-Type' => 'application/json']);
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage()], 500, ['Content-Type' => 'application/json']);
		}
	}
	public function readAll()
	{
		try
		{
			$keyword	= request()->get('q', null);
			$page 		= (int)request()->get('page', 1);
			$limit		= (int)request()->get('limit', 25);
			$offset		= ($page <= 1) ? 0 : (($page - 1) * $limit);
			if( !$keyword )
			{
				$count		= Customer::count();
				$total_pages= ceil($count/$limit);
				$items 		= Customer::orderBy('id', 'desc')->offset($offset)->limit($limit)->get();
				return response(['data' => $items->map(function($item){return new ResourceCustomer($item);})], 200, ['Content-Type' => 'application/json', 'Total-Pages' => $total_pages]);
			}
			//$items = Customer::where('firstname', 'like', "%{$keyword}%")->orWhere('lastname', 'like', "%{$keyword}%")->get();
			$qb = Customer::where(function($query) use ($keyword)
			{
				$query
					->where('firstname', 'like', "%{$keyword}%")
					->orWhere('lastname', 'like', "%{$keyword}%")
					->orWhere('email', 'like', "%{$keyword}%")
					->orWhere('nit_ruc_nif', 'like', "%{$keyword}%")
				;
			});
			//die($qb->toSql());
			$items = $qb->orderBy('lastname', 'asc')->limit($limit)->get();
		
			return response(['data' => $items->map(function($item){return new ResourceCustomer($item);})], 200, ['Content-Type' => 'application/json']);
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
			if( !$data['id'] )
				throw new Exception('Identificador de cliente invalido');
			$customer = Customer::find($data['id']);
			if( !$customer )
				throw new Exception('El cliente no existe');
			$customer->fill($data);
			$customer->save();
			return response(['status' => 'ok', 'data' => $customer])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage()], 500, ['Content-Type' => 'application/json']);
		}
	}
	public function delete(int $id)
	{
		try
		{
			//$id = (int)request()->get('id', 0);
			if( $id <= 0 )
				throw new Exception('Identificador de cliente invalido');
			$customer = Customer::find($id);
			if( !$customer )
				throw new Exception('El cliente no existe');
			$customer->delete();
			
			return response(['status' => 'ok', 'data' => null])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage()], 500, ['Content-Type' => 'application/json']);
		}
	}
}
