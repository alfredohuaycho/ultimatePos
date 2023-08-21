<?php
namespace App\Modules\Siat\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Siat\Models\SyncModel;
use Illuminate\Http\Request;

class ApiSyncController extends Controller
{
	/**
	 * 
	 * @var SyncModel
	 */
	protected	$syncModel;
	
	public function __construct(SyncModel $syncModel)
	{
		$this->syncModel = $syncModel;
	}
	public function cuis(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		$res = $this->syncModel->obtenerCuis();
		
		return json_encode(['status' => 'ok', 'data' => $res]);
	}
	public function cufd(Request $request)
	{
		$renew 		= (int)$request->get('renew', 0);
		$sucursal 	= $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		$res		= null;
		if( $renew == 1 )
			$res = $this->syncModel->renewCufd($sucursal, $puntoventa);
		else
			$res = $this->syncModel->obtenerCufd($sucursal, $puntoventa);
		
		return json_encode(['status' => 'ok', 'data' => $res]);
	}
	public function puntosVenta(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$res = $this->syncModel->getTiposPuntoVentaS($sucursal, $puntoventa);
		
		return json_encode(['status' => 'ok', 'data' => $res]);
	}
	public function actividades(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$res = $this->syncModel->getActividadesS($sucursal, $puntoventa);
		
		return json_encode(['status' => 'ok', 'data' => $res]);
	}
	public function actividadesDocSector(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$res = $this->syncModel->getActividadesDocumentoSectorS($sucursal, $puntoventa);
		
		return json_encode(['status' => 'ok', 'data' => $res]);
	}
	public function leyendasFactura(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$res = $this->syncModel->getLeyendasFacturasS($sucursal, $puntoventa);
		
		return response(['status' => 'ok', 'data' => $res])->header('Content-Type', 'application/json');
	}
	public function tiposHabitacion(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$res = $this->syncModel->getTiposHabitacionS($sucursal, $puntoventa);
		
		return response(['status' => 'ok', 'data' => $res])->header('Content-Type', 'application/json');
	}
	public function productosServicios(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$res = $this->syncModel->getProductosServiciosS($sucursal, $puntoventa);
		
		return response(['status' => 'ok', 'data' => $res])->header('Content-Type', 'application/json');
	}
	public function eventos(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$res = $this->syncModel->getEventosS($sucursal, $puntoventa);
		
		return response(['status' => 'ok', 'data' => $res])->header('Content-Type', 'application/json');
	}
	public function motivosAnulacion(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$res = $this->syncModel->getMotivosAnulacionS($sucursal, $puntoventa);
		
		return response(['status' => 'ok', 'data' => $res])->header('Content-Type', 'application/json');
	}
	public function unidadesMedida(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$res = $this->syncModel->getUnidadesMedidaS($sucursal, $puntoventa);
		
		return response(['status' => 'ok', 'data' => $res])->header('Content-Type', 'application/json');
	}
	public function tiposMoneda(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$res = $this->syncModel->getTiposMonedaS($sucursal, $puntoventa);
		
		return response(['status' => 'ok', 'data' => $res])->header('Content-Type', 'application/json');
	}
	public function documentosIdentidad(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$res = $this->syncModel->getTiposDocumentoIdentidadS($sucursal, $puntoventa);
		
		return response(['status' => 'ok', 'data' => $res])->header('Content-Type', 'application/json');
	}
	public function metodosPago(Request $request)
	{
		$sucursal = $request->get('sucursal', 0);
		$puntoventa = $request->get('puntoventa', 0);
		
		$res = $this->syncModel->getTiposMetodosPagoS($sucursal, $puntoventa);
		
		return response(['status' => 'ok', 'data' => $res])->header('Content-Type', 'application/json');
	}
}