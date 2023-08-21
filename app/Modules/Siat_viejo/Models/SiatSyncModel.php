<?php
namespace App\Modules\Siat\Models;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\SiatConfig;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioFacturacionSincronizacion;
use Exception;
use App\User as SB_User;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Exceptions\CufdExpired;

class SiatSyncModel extends SiatModel
{
	protected	$serviceSync;
	
	public function __construct(ServicioFacturacionSincronizacion $service)
	{
		$this->serviceSync = $service;
	}
	public function needsSync($time)
	{
		return (time() - $time) > 86400;
	}
	public function setModelServiceConfig(SiatConfig $config)
	{
		self::setServiceConfig($this->serviceSync, $config);
	}
	public function getActividades(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-actividades.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return json_decode(file_get_contents($filename));
			
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarActividades($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getActividadesDocumentoSector(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-actividades-documento-sector.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return json_decode(file_get_contents($filename));
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarListaActividadesDocumentoSector($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getLeyendasFacturas(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-leyendas-facturas.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return json_decode(file_get_contents($filename));
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarListaLeyendasFactura($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		
		return $res;
	}
	public function getTiposHabitacion(SB_User $user, int $sucursal, int $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-tipos-habitaciones.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return json_decode(file_get_contents($filename));
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarParametricaTipoHabitacion($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getProductosServicios(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-productos-servicios.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return json_decode(file_get_contents($filename));
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarListaProductosServicios($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getEventos($user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-eventos.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return json_decode(file_get_contents($filename));
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarParametricaEventosSignificativos($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getEventoPorCodigo($user, $sucursal, $puntoventa, int $codigo)
	{
		$res = $this->getEventos($user, $sucursal, $puntoventa);
		foreach($res->RespuestaListaParametricas->listaCodigos as $evt)
		{
			if( $codigo == $evt->codigoClasificador )
			{
				return $evt;
			}
		}
	}
	public function getMotivosAnulacion(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-motivos-anulacion.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return json_decode(file_get_contents($filename));
		$config = $this->getUserConfig($user);
		
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarParametricaMotivoAnulacion($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getTiposDocumentoIdentidad(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-documentos-identidad.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return json_decode(file_get_contents($filename));
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarParametricaTipoDocumentoIdentidad($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getTiposDocumentosSector(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-tipos-documentos-sector.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return json_decode(file_get_contents($filename));
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarParametricaTipoDocumentoSector($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getTiposEmision(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-tipos-emision.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && ($obj = json_decode(file_get_contents($filename))) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return $obj;
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarParametricaTipoEmision($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getTiposMetodosPago(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-tipos-metodos-pago.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && ($obj = json_decode(file_get_contents($filename))) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return $obj;
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarParametricaTipoMetodoPago($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getTiposMoneda(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-tipos-moneda.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && ($obj = json_decode(file_get_contents($filename))) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return $obj;
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarParametricaTipoMoneda($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getTiposPuntoVenta(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-tipos-punto-venta.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && ($obj = json_decode(file_get_contents($filename))) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return $obj;
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarParametricaTipoPuntoVenta($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getTiposFactura(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-tipos-factura.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && ($obj = json_decode(file_get_contents($filename))) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return $obj;
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarParametricaTiposFactura($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getUnidadesMedida(SB_User $user, $sucursal, $puntoventa)
	{
		$filename = sprintf("%s/%d-%d-unidades-medida.json", sb_user_get_dir($user), $sucursal, $puntoventa);
		if( is_file($filename) && ($obj = json_decode(file_get_contents($filename))) && (!$this->needsSync(filemtime($filename)) || !$this->isOnline()) )
			return $obj;
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarParametricaUnidadMedida($sucursal, $puntoventa);
		
		file_put_contents($filename, json_encode($res));
		return $res;
	}
	public function getUnidadMedidaPorCodigo(SB_User $user, $sucursal, $puntoventa, $codigo)
	{
		$items = $this->getUnidadesMedida($user, $sucursal, $puntoventa);
		$umd = null;
		foreach($items->RespuestaListaParametricas->listaCodigos as $um)
		{
			if( $um->codigoClasificador == $codigo )
			{
				$umd = $um->descripcion;
				break;
			}
		}
		return $umd;
	}
	public function fechaHora(SB_User $user, $sucursal = 0, $puntoventa = 0)
	{
		$config = $this->getUserConfig($user);
		$cuis = $this->getCuis($config, $user, $sucursal, $puntoventa);
		$this->serviceSync->setConfig((array)$config);
		$this->serviceSync->cuis = $cuis->codigo;
		$res = $this->serviceSync->sincronizarFechaHora($sucursal, $puntoventa);
		
		return $res;
	}
}