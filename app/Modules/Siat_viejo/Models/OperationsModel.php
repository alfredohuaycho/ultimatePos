<?php
namespace App\Modules\Siat\Models;

use App\Modules\Siat\Entities\Event;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioOperaciones;

class OperationsModel extends SiatModel
{
	protected	$serviceOperaciones;
	
	public function __construct(ServicioOperaciones $service)
	{
		$this->serviceOperaciones = $service;
		$config = $this->getUserConfig();
		$this->serviceOperaciones->setConfig((array)$config);
	}
	public function crearPuntoVenta(int $sucursalId, int $tipo, string $nombre)
	{
		$config = $this->getUserConfig();
		$cuis = $this->getCuis($config, null, $sucursalId);
		$this->serviceOperaciones->cuis = $cuis->codigo;
		$res = $this->serviceOperaciones->registroPuntoVenta($sucursalId, $tipo, $nombre);
		
		return $res;
	}
	public function getPuntosVenta(int $sucursalId)
	{
		$config = $this->getUserConfig();
		$cuis = $this->getCuis($config, null, $sucursalId);
		$this->serviceOperaciones->cuis = $cuis->codigo;
		$res = $this->serviceOperaciones->consultaPuntoVenta($sucursalId);
		if( isset($res->RespuestaConsultaPuntoVenta->listaPuntosVentas) && !is_array($res->RespuestaConsultaPuntoVenta->listaPuntosVentas) )
			$res->RespuestaConsultaPuntoVenta->listaPuntosVentas = [$res->RespuestaConsultaPuntoVenta->listaPuntosVentas];
			return $res;
	}
	public function borrarPuntoVenta(int $sucursalId, int $puntoVentaId)
	{
		$config = $this->getConfig();
		$cuis = $this->getCuis($config, $user, $sucursalId);
		$this->serviceOperaciones->cuis = $cuis->codigo;
		$res = $this->serviceOperaciones->cierrePuntoVenta($sucursalId, $puntoVentaId);
		
		return $res;
	}
	public function registrarEvento(Event $evento)
	{
		$config = $this->getConfig();
		$cuis = $this->getCuis($config, null, $evento->sucursal_id);
		$cufd = $this->getCufd($config, null, $evento->sucursal_id, $evento->puntoventa_id);
		$this->serviceOperaciones->cuis = $cuis->codigo;
		$this->serviceOperaciones->cufd = $cufd->codigo;
		
		$fechaInicio 	= date('Y-m-d\TH:i:s.v', strtotime($evento->fecha_inicio));
		$fechaFin 		= date('Y-m-d\TH:i:s.v', strtotime($evento->fecha_fin));
		$res = $this->serviceOperaciones->registroEventoSignificativo(
			$evento->evento_id,
			$evento->descripcion,
			$evento->cufd_evento,
			$fechaInicio,
			$fechaFin,
			$evento->sucursal_id, $evento->puntoventa_id
		);
		$evento->cufd = $cufd->codigo;
		return $res->RespuestaListaEventos;
	}
	public function consultarEventos(int $sucursalId, int $puntoventaId, $fecha)
	{
		$config = $this->getConfig();
		$config->validate();
		$config->validateExpirations();
		$this->serviceOperaciones->cuis = $config->cuis->codigo;
		$this->serviceOperaciones->cufd = $config->cufd->codigo;
		$res = $this->serviceOperaciones->consultaEventoSignificativo($sucursalId, $puntoventaId, $fecha);
		
		return $res;
	}
}