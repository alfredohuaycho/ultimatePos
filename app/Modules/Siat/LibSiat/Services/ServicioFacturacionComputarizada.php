<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services;

/**
 * Clase para el servicio de Facturacion Computarizada en linea
 * @author J. Marcelo Aviles
 * 
 *
 */
class ServicioFacturacionComputarizada extends ServicioFacturacion
{
	protected	$wsdl 		= 'https://pilotosiatservicios.impuestos.gob.bo/v2/ServicioFacturacionComputarizada?wsdl';
	
	public function __construct($cuis = null, $cufd = null, $token = null, $endpoint = null)
	{
		parent::__construct($cuis, $cufd, $token, $endpoint);
		//$this->modalidad = self::MOD_COMPUTARIZADA_ENLINEA;
	}
	
}