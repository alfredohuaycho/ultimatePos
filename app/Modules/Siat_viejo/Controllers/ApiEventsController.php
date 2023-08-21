<?php
namespace App\Modules\Siat\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Siat\Models\EventsModel;
use Illuminate\Http\Request;
use App\Modules\Siat\Entities\Event;
use Exception;

class ApiEventsController extends Controller
{
	/**
	 * @var EventsModel
	 */
	protected	$eventsModel;
	
	
	public function __construct(EventsModel $model)
	{
		$this->eventsModel = $model;
	}
	
	public function eventoActivo(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$event = $this->eventsModel->obtenerEventoActivo($sucursal, $puntoventa);
		
		return response(['data' => $event])->header('Content-Type', 'application/json');
	}
	public function readAll(Request $request)
	{
		$page		= $request->get('page', 1);
		$sucursal 	= $request->get('sucursal_id', 0);
		$puntoventa = $request->get('puntoventa_id', 0);
		$limit		= 25;
		$offset		= ($page <= 1) ? 0 : (($page - 1) * $limit);
		$count		= Event::count();
		$total_pages	= ceil($count/$limit);
		$items = Event::orderBy('id', 'desc')->offset($offset)->limit($limit)->get();
		
		return response(['data' => $items])->header('Content-Type', 'application/json');
	}
	public function create()
	{
		$user = auth()->user();
		try 
		{
			$data = request()->json()->all();
			$evento = new Event($data);
			$evento->user_id = $user->id;
			$evento->codigo_sucursal = $data['sucursal_id'];
			$evento->codigo_puntoventa = $data['puntoventa_id'];
			
			$this->eventsModel->registrarEvento($evento);
			return response(['status' => 'ok', 'data' => $evento])->header('Content-Type', 'application/json');
		} 
		catch (Exception $e) 
		{
			return response(['status' => 'error', 'error' => $e->getMessage(), 'data' => null], 500)->header('Content-Type', 'application/json');
		}
	}
	public function stats(int $eventId)
	{
		$res = $this->eventsModel->getEventStats($eventId);
		return response(['status' => 'ok', 'data' => $res])->header('Content-Type', 'application/json');
	}
	public function close(int $eventId)
	{
		$user = auth()->user();
		try
		{
			$this->eventsModel->closeEvent($eventId);
			return response(['status' => 'ok', 'data' => null])->header('Content-Type', 'application/json');
		}
		catch (Exception $e)
		{
			return response(['status' => 'error', 'error' => $e->getMessage(), 'data' => null], 500)->header('Content-Type', 'application/json');
		}
	}
	public function voidEvent(int $eventId)
	{
		try
		{
			if( (int)$eventId <= 0 )
				throw new Exception('Identificador de evento invalido');
				
			$evento = Event::find($eventId);
			if( !$evento )
				throw new Exception('El evento no existe en la base de datos');
			
			$evento->estado = Event::STATUS_CLOSED;
			$evento->save();
			return response(['status' => 'ok', 'data' => $evento])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response(['status' => 'error', 'error' => $e->getMessage(), 'data' => null], 500)->header('Content-Type', 'application/json');
		}
	}
}