<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services;

class ServicioOperaciones extends ServicioSiat
{
	protected $wsdl = 'https://pilotosiatservicios.impuestos.gob.bo/v2/FacturacionOperaciones?wsdl';
	
	public function setConfig(array $data)
	{
		parent::setConfig($data);
		if( $this->ambiente == self::AMBIENTE_PRODUCCION )
		{
			$this->wsdl = 'https://siatrest.impuestos.gob.bo/v2/FacturacionOperaciones?wsdl';
		}
	}
	protected function buildData($codigoSucursal, $codigoPuntoVenta, $fecha)
	{
		$data = [
			[
				'SolicitudConsultaEvento' => [
					'codigoAmbiente' 	=> $this->ambiente,
					'codigoPuntoVenta'	=> $codigoPuntoVenta,
					'codigoSistema'		=> $this->codigoSistema,
					'codigoSucursal'	=> $codigoSucursal,
					'cufd'				=> $this->cufd,
					'cuis'				=> $this->cuis,
					'nit'				=> $this->nit,
					'fechaEvento'		=> $fecha,
				]
			]
		];
		
		return $data;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @param string $fecha
	 * @return object Respuesta del servicio Siat
	 */
	public function consultaEventoSignificativo($codigoSucursal, $codigoPuntoVenta, $fecha)
	{
		list(, $method) = explode('::', __METHOD__);
		
		$data = $this->buildData($codigoSucursal, $codigoPuntoVenta, $fecha);
		$res = $this->callAction($method, $data);
		
		return $res;
	}
	/**
	 * Registra un evento significativo o contingencia
	 * Se debe tener un codigo CUFD y CODIGO DE CONTROL cuando ocurrio el evento (codigos antiguos)
	 * 
	 * @param int $codigoMotivoEvento
	 * @param string $descripcion
	 * @param string $cufdEvento El CUFD del evento
	 * @param string $fechaInicio Fecha y hora del inicio del evento
	 * @param string $fechaFin Fecha y hora de la finalizacion del evento
	 * @param int $codigoSucursal
	 * @param int $codigoPuntoVenta
	 * @return object Respuesta del servicio Siat
	 */
	public function registroEventoSignificativo($codigoMotivoEvento, $descripcion, $cufdEvento, $fechaInicio, $fechaFin, $codigoSucursal = 0, $codigoPuntoVenta = 0)
	{
		list(, $method) = explode('::', __METHOD__);
		$data = [
			[
				'SolicitudEventoSignificativo' => [
					'codigoAmbiente' 		=> $this->ambiente,
					'codigoMotivoEvento'	=> $codigoMotivoEvento,
					'codigoPuntoVenta'		=> $codigoPuntoVenta,
					'codigoSistema'			=> $this->codigoSistema,
					'codigoSucursal'		=> $codigoSucursal,
					'cufd'					=> $this->cufd,
					'cufdEvento'			=> $cufdEvento,
					'cuis'					=> $this->cuis,
					'descripcion'			=> $descripcion,
					'fechaHoraInicioEvento'	=> $fechaInicio,
					'fechaHoraFinEvento'	=> $fechaFin,
					'nit'					=> $this->nit,
					
				]
			]
		];
		$res = $this->callAction($method, $data);
		
		return $res;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @param int $tipoPuntoVenta
	 * @param string $nombrePuntoVenta
	 * @param string $descripcion
	 * @return unknown
	 */
	public function registroPuntoVenta(int $codigoSucursal, int $tipoPuntoVenta, string $nombrePuntoVenta, string $descripcion = '')
	{
		list(, $method) = explode('::', __METHOD__);
		$data = [
			[
				'SolicitudRegistroPuntoVenta' => [
					'codigoAmbiente' 		=> $this->ambiente,
					'codigoModalidad'		=> $this->modalidad,
					'codigoSistema'			=> $this->codigoSistema,
					'codigoSucursal'		=> $codigoSucursal,
					'codigoTipoPuntoVenta'	=> $tipoPuntoVenta,
					'cuis'					=> $this->cuis,
					'descripcion'			=> $descripcion,
					'nit'					=> $this->nit,
					'nombrePuntoVenta'		=> $nombrePuntoVenta,
				]
			]
		];
		$res = $this->callAction($method, $data);
		
		return $res;
	}
	/**
	 * 
	 * @param int $codigoSucursal
	 * @return object
	 */
	public function consultaPuntoVenta(int $codigoSucursal)
	{
		list(, $method) = explode('::', __METHOD__);
		$data = [
			[
				'SolicitudConsultaPuntoVenta' => [
					'codigoAmbiente' 		=> $this->ambiente,
					'codigoSistema'			=> $this->codigoSistema,
					'codigoSucursal'		=> $codigoSucursal,
					'cuis'					=> $this->cuis,
					'nit'					=> $this->nit,
				]
			]
		];
		$res = $this->callAction($method, $data);
		
		return $res;
	}
	/**
	 * 
	 * @param int $sucursal
	 * @param int $puntoVenta
	 * @return object
	 */
	public function cierrePuntoVenta(int $sucursal, int $puntoVenta)
	{
		list(, $method) = explode('::', __METHOD__);
		$data = [
			[
				'SolicitudCierrePuntoVenta' => [
					'codigoAmbiente' 		=> $this->ambiente,
					'codigoPuntoVenta'		=> $puntoVenta,
					'codigoSistema'			=> $this->codigoSistema,
					'codigoSucursal'		=> $sucursal,
					'cuis'					=> $this->cuis,
					'nit'					=> $this->nit,
				]
			]
		];
		$res = $this->callAction($method, $data);
		
		return $res;
	}
	/**
	 * 
	 * @param int $sucursal
	 * @param int $puntoVenta
	 * @return object
	 */
	public function cierreOperacionesSistema(int $sucursal, int $puntoVenta)
	{
		list(, $method) = explode('::', __METHOD__);
		$data = [
			[
				'SolicitudOperaciones' => [
					'codigoAmbiente' 		=> $this->ambiente,
					'codigoModalidad'		=> $this->modalidad,
					'codigoPuntoVenta'		=> $puntoVenta,
					'codigoSistema'			=> $this->codigoSistema,
					'codigoSucursal'		=> $sucursal,
					'cuis'					=> $this->cuis,
					'nit'					=> $this->nit,
				]
			]
		];
		$res = $this->callAction($method, $data);
		
		return $res;
	}
	public function verificarComunicacion()
	{
		list(, $method) = explode('::', __METHOD__);
		$data = [
			[
				
			]
		];
		$res = $this->callAction($method, $data);
		
		return $res;
	}
}