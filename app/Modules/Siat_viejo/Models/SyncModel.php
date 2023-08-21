<?php
namespace App\Modules\Siat\Models;

class SyncModel extends SiatSyncModel
{
	/**
	 * 
	 * @return \Illuminate\Contracts\Auth\Authenticatable|NULL
	 */
	public function getCurrentUser()
	{
		$user = auth()->user();
		return $user;
	}
	public function getActividadesS($sucursal, $puntoventa)
	{
		return $this->getActividades($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getActividadesDocumentoSectorS($sucursal, $puntoventa)
	{
		return $this->getActividadesDocumentoSector($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getLeyendasFacturasS($sucursal, $puntoventa)
	{
		return $this->getLeyendasFacturas($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getTiposHabitacionS(int $sucursal, int $puntoventa)
	{
		return $this->getTiposHabitacion($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getProductosServiciosS($sucursal, $puntoventa)
	{
		return $this->getProductosServicios($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getEventosS($sucursal, $puntoventa)
	{
		return $this->getEventos($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getEventoPorCodigoS($sucursal, $puntoventa, int $codigo)
	{
		return $this->getEventoPorCodigo($this->getCurrentUser(), $sucursal, $puntoventa, $codigo);
	}
	public function getMotivosAnulacionS($sucursal, $puntoventa)
	{
		return $this->getMotivosAnulacion($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getTiposDocumentoIdentidadS($sucursal, $puntoventa)
	{
		return $this->getTiposDocumentoIdentidad($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getTiposDocumentosSectorS($sucursal, $puntoventa)
	{
		return $this->getTiposDocumentosSector($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getTiposEmisionS($sucursal, $puntoventa)
	{
		return $this->getTiposEmision($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getTiposMetodosPagoS($sucursal, $puntoventa)
	{
		return $this->getTiposMetodosPago($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getTiposMonedaS($sucursal, $puntoventa)
	{
		return $this->getTiposMoneda($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getTiposPuntoVentaS($sucursal, $puntoventa)
	{
		return $this->getTiposPuntoVenta($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getTiposFacturaS($sucursal, $puntoventa)
	{
		return $this->getTiposFactura($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getUnidadesMedidaS($sucursal, $puntoventa)
	{
		return $this->getUnidadesMedida($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function getUnidadMedidaPorCodigoS($sucursal, $puntoventa, $codigo)
	{
		return $this->getUnidadMedidaPorCodigo($this->getCurrentUser(), $sucursal, $puntoventa, $codigo);
	}
	public function fechaHoraS($sucursal = 0, $puntoventa = 0)
	{
		return $this->fechaHora($this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function obtenerCuis($sucursal = 0, $puntoventa = 0)
	{
		return $this->getCuis($this->getConfig(), $this->getCurrentUser(), $sucursal, $puntoventa);
	}
	public function obtenerCufd($sucursal = 0, $puntoventa = 0)
	{
		return $this->getCufd($this->getConfig(), $this->getCurrentUser(), $sucursal, $puntoventa);
	}
}