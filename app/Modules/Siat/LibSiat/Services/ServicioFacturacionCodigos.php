<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services;

/**
 * Clases para el servicio de obtencion de codigos CUIS y CUF
 * @author mac
 *
 */
class ServicioFacturacionCodigos extends ServicioSiat
{
	protected $wsdl = 'https://pilotosiatservicios.impuestos.gob.bo/v2/FacturacionCodigos?wsdl';
	
	public function setConfig(array $data)
	{
		parent::setConfig($data);
		if( (int)$this->ambiente == self::AMBIENTE_PRODUCCION )
		{
			$this->wsdl = 'https://siatrest.impuestos.gob.bo/v2/FacturacionCodigos?wsdl';
		}
	}
	public function cuis($codigoPuntoVenta = 0, $codigoSucursal = 0)
	{
		$data = [
			[
				'SolicitudCuis' => [
					'codigoAmbiente'	=> $this->ambiente,
					'codigoModalidad'	=> $this->modalidad,
					'codigoPuntoVenta'	=> $codigoPuntoVenta,
					'codigoSistema'		=> $this->codigoSistema,
					'codigoSucursal'	=> $codigoSucursal,
					'nit'				=> $this->nit,
				]
			]
		];
		//print_r($this);print_r($data);die($this->wsdl);
		list(,$action) = explode('::', __METHOD__);
		$res = $this->callAction($action, $data);
		
		return $res;
	}
	public function cufd($codigoPuntoVenta = 0, $codigoSucursal = 0)
	{
		list(,$action) = explode('::', __METHOD__);
		$data = [
			[
				'SolicitudCufd' => [
					'codigoAmbiente'	=> $this->ambiente,
					'codigoModalidad'	=> $this->modalidad,
					'codigoPuntoVenta'	=> $codigoPuntoVenta,
					'codigoSistema'		=> $this->codigoSistema,
					'codigoSucursal'	=> $codigoSucursal,
					'cuis'				=> $this->cuis,
					'nit'				=> $this->nit,
				]
			]
		];
		$res = $this->callAction($action, $data);
		
		return $res;
	}
	public function verificarNit($nit, $sucursal = 0)
	{
		list(,$action) = explode('::', __METHOD__);
		$data = [
			[
				'SolicitudVerificarNit' => [
					'codigoAmbiente'	=> $this->ambiente,
					'codigoModalidad'	=> $this->modalidad,
					'codigoSistema'		=> $this->codigoSistema,
					'codigoSucursal'		=> $sucursal,
					'cuis'					=> $this->cuis,
					'nit'					=> $this->nit,
					'nitParaVerificacion'	=> $nit
				]
			]
		];
		$res = $this->callAction($action, $data);
		
		return $res;
	}
}