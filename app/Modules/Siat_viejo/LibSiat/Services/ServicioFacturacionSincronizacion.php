<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services;

/**
 * Clase para el servicio de sincronizacion de datos de impuestos
 * @author J. Marcelo Aviles Paco
 *
 */
class ServicioFacturacionSincronizacion extends ServicioSiat
{
	protected $wsdl = 'https://pilotosiatservicios.impuestos.gob.bo/v2/FacturacionSincronizacion?wsdl';
	
	public function setConfig(array $data)
	{
		parent::setConfig($data);
		if( $this->ambiente == self::AMBIENTE_PRODUCCION )
		{
			$this->wsdl = 'https://siatrest.impuestos.gob.bo/v2/FacturacionSincronizacion?wsdl';
		}
	}
	protected function buildData($codigoSucursal = 0, $codigoPuntoVenta = 0)
	{
		$data = [
			[
				'SolicitudSincronizacion' => [
					'codigoAmbiente' 	=> $this->ambiente,
					'codigoPuntoVenta'	=> $codigoPuntoVenta,
					'codigoSistema'		=> $this->codigoSistema,
					'codigoSucursal'	=> $codigoSucursal,
					'cuis'				=> $this->cuis,
					'nit'				=> $this->nit,
				]
			]
		];
		return $data;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @return object Respuesta servicio Siat
	 */
	public function sincronizarParametricaMotivoAnulacion(int $codigoSucursal = 0, int $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @return object Respuesta servicio Siat
	 */
	public function sincronizarListaActividadesDocumentoSector(int $codigoSucursal = 0, int $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @return object Respuesta servicio Siat
	 */
	public function sincronizarParametricaTipoDocumentoSector(int $codigoSucursal = 0, int $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @return object Respuesta servicio Siat
	 */
	public function sincronizarParametricaTiposFactura(int $codigoSucursal = 0, int $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @return object Respuesta servicio Siat
	 */
	public function sincronizarListaMensajesServicios(int $codigoSucursal = 0, int $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	/**
	 * 
	 * @return object Respuesta servicio Siat
	 */
	public function verificarComunicacion()
	{
		list(, $method) = explode('::', __METHOD__);
		$res = $this->callAction($method, [[]]);
		return $res;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @return object Respuesta servicio Siat
	 */
	public function sincronizarParametricaEventosSignificativos(int $codigoSucursal = 0, int $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @return object Respuesta servicio Siat
	 */
	public function sincronizarParametricaTipoPuntoVenta(int $codigoSucursal = 0, int $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @return object Respuesta servicio Siat
	 */
	public function sincronizarListaProductosServicios(int $codigoSucursal = 0, int $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @return object Respuesta servicio Siat
	 */
	public function sincronizarParametricaTipoMoneda(int $codigoSucursal = 0, int $codigoPuntoVenta = 0)
	{
		/*
		$servCodigos = new ServicioFacturacionCodigos(null, null, Config::$tokenDelegado);
		
		$servCodigos->ambiente		= Config::$ambiente;
		$servCodigos->modalidad		= Config::$modalidad;
		$servCodigos->codigoSistema = Config::$codigoSistema;
		$servCodigos->nit			= Config::$nit;
		
		$res = $servCodigos->cuis();
		//print_r($res);
		$cuis = $res->RespuestaCuis->codigo;
		$servCodigos->cuis = $cuis;
		*/
		list(, $method) = explode('::', __METHOD__);
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;//->RespuestaListaParametricas;
	}
	public function sincronizarActividades($codigoSucursal = 0, $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	public function sincronizarParametricaTipoEmision($codigoSucursal = 0, $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	public function sincronizarParametricaTipoDocumentoIdentidad($codigoSucursal = 0, $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	public function sincronizarListaLeyendasFactura($codigoSucursal = 0, $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	public function sincronizarParametricaTipoMetodoPago($codigoSucursal = 0, $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	public function sincronizarParametricaUnidadMedida($codigoSucursal = 0, $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	public function sincronizarParametricaPaisOrigen($codigoSucursal = 0, $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	public function sincronizarFechaHora($codigoSucursal = 0, $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
	public function sincronizarParametricaTipoHabitacion($codigoSucursal = 0, $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$res = $this->callAction($method, $this->buildData($codigoSucursal, $codigoPuntoVenta));
		return $res;
	}
}
