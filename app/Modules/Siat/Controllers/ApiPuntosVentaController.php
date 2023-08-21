<?php
namespace App\Modules\Siat\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Siat\Entities\PointOfSale;
use App\Modules\Siat\Models\OperationsModel;
use Exception;

class ApiPuntosVentaController extends Controller
{
	public function readAll()
	{
		$sucursal = (int)request()->get('sucursal', 0);
		//$items = PointOfSale::where('codigo_sucursal', $sucursal)->get();
		$items = PointOfSale::all();
		
		return response(['data' => $items])->header('Content-Type', 'application/json');
	}
	public function sync(OperationsModel $operationsModel)
	{
		$user = auth()->user();
		$sucursalId = (int)request()->get('sucursal', 0);
		
		$res = $operationsModel->getPuntosVenta($sucursalId);
		//print_r($res);die;
		if( $res->RespuestaConsultaPuntoVenta
			&& isset($res->RespuestaConsultaPuntoVenta->mensajesList)
			&& $res->RespuestaConsultaPuntoVenta->mensajesList->codigo == 982 )
		{
			
			PointOfSale::query()->delete();
		}
		else
		{
			$codes = [];
			foreach($res->RespuestaConsultaPuntoVenta->listaPuntosVentas as $pv)
			{
				$lpv = PointOfSale::where('codigo', $pv->codigoPuntoVenta)
					//->where('user_id', $user->user_id)
					->first();
				$codes[] = $pv->codigoPuntoVenta;
				if( $lpv )
				{
					
				}
				else
				{
					$npv = new PointOfSale();
					$npv->nombre 	= $pv->nombrePuntoVenta;
					$npv->codigo 	= $pv->codigoPuntoVenta;
					$npv->tipo 		= $pv->tipoPuntoVenta;
					$npv->tipo_id	= 0;
					//$npv->user_id 	= $user ? $user->user_id : 0;
					$npv->codigo_sucursal = $sucursalId;
					$npv->save();
				}
			}
		}
		return response(['data' => $res->RespuestaConsultaPuntoVenta->listaPuntosVentas, 'message' => 'Puntos de venta sicronizados'])
			->header('Content-Type', 'application/json');
	}
	public function create(OperationsModel $operationsModel)
	{
		try
		{
			$data = request()->json()->all();
			if( (int)$data['sucursal_id'] < 0 )
				throw new Exception('Debe seleccionar una sucursal');
			if( !isset($data['tipo_id']) || (int)$data['tipo_id'] <= 0 )
				throw new Exception('Debe seleccionar un tipo de punto de venta');
			if( !isset($data['nombre']) )
				throw new Exception('Debe ingresar un nombre para el punto de venta');
			$pos = new PointOfSale($data);
			$pos->codigo_sucursal = (int)$data['sucursal_id'];
			//var_dump($pos->codigo_sucursal, (int)$pos->tipo_id, $pos->nombre);die;
			$res = $operationsModel->crearPuntoVenta($pos->codigo_sucursal, (int)$pos->tipo_id, $pos->nombre);
			if( !isset($res->RespuestaRegistroPuntoVenta) )
				throw new \Exception('Respuesta invalida'); 
			if( isset($res->RespuestaRegistroPuntoVenta->mensajesList) && is_object($res->RespuestaRegistroPuntoVenta->mensajesList) )
				throw new Exception(sprintf("%d: %s",
					$res->RespuestaRegistroPuntoVenta->mensajesList->codigo,
					$res->RespuestaRegistroPuntoVenta->mensajesList->descripcion)
				);
			$pos->codigo = $res->RespuestaRegistroPuntoVenta->codigoPuntoVenta;
			//$pos->user_id = $user->user_id;
			$pos->save();
			
			return response(['status' => 'ok', 'data' => $pos])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage()], 500, ['Content-Type' => 'application/json']);
		}
	}
	public function delete(int $id, OperationsModel $operationsModel)
	{
		try
		{
			$pos = PointOfSale::find($id);
			if( !$pos )
				throw new Exception('El punto de venta no existe, no se puede borrar');
			if( (int)$pos->codigo > 0 )
			{
				$res = $operationsModel->borrarPuntoVenta($pos->codigo_sucursal, $pos->codigo);
				if( $res && isset($res->RespuestaCierrePuntoVenta) && $res->RespuestaCierrePuntoVenta->transaccion )
				{
					$pos->delete();
				}
			}
			$pos->delete();
			
			return response(['status' => 'ok', 'data' => null, 'message' => 'Punto de venta borrado'])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['error' => $e->getMessage()], 500, ['Content-Type' => 'application/json']);
		}
	}
}