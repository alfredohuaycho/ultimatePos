<?php
namespace App\Modules\Siat\Models;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\DocumentTypes;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\SiatConfig;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioSiat;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioFacturacion;
use Exception;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services\ServicioFacturacionCodigos;
use App\Modules\Siat\Entities\Cufd;
use App\Modules\Siat\Entities\PointOfSale;
use App\User;
use App\Modules\Siat\Classes\ExceptionInvalidNit;

class SiatModel 
{
	public function getConfig()
	{
		$config = new SiatConfig([
			'nombreSistema' => 'Terrapuertocb',
			'codigoSistema' => '7236AAC0462430AD49A61B6',
			'nit'           => 1023275028,
			'razonSocial'   => 'TERMINAL DE BUSES COCHABAMBA S.A.',
			'modalidad'     => ServicioSiat::MOD_ELECTRONICA_ENLINEA,
			'ambiente'      => ServicioSiat::AMBIENTE_PRUEBAS,
			'tokenDelegado'	=> 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJURVJCVVMxMiIsImNvZGlnb1Npc3RlbWEiOiI3MjM2QUFDMDQ2MjQzMEFENDlBNjFCNiIsIm5pdCI6Ikg0c0lBQUFBQUFBQUFETTBNREkyTWpjMU1MSUFBTEZwdG1nS0FBQUEiLCJpZCI6MTI1MDU2LCJleHAiOjE2OTU2MDAwMDAsImlhdCI6MTY2NDA4MDIyNCwibml0RGVsZWdhZG8iOjEwMjMyNzUwMjgsInN1YnNpc3RlbWEiOiJTRkUifQ.updk-225XlP8VLg2RcUplL4PVwpd6qxdXgiHG2Yt2quu_cRQQ-ed0jK2gUeHnPcsZ0SyU5A2xHqEjMCoz_sbQQ',
			'pubCert'		=> MOD_SIAT_DIR . SB_DS . 'certs' . SB_DS . 'terrapuerto' . SB_DS . 'certificado.pem',
			'privCert'		=> MOD_SIAT_DIR . SB_DS . 'certs' . SB_DS . 'terrapuerto' . SB_DS . 'llave_privada.pem',
			'telefono'		=> '34345435',
			'ciudad'		=> 'COCHABAMBA'
		]);
		
		return $config;
	}
	public function getUserConfig()
	{
		return $this->getConfig();
	}
	public function getAvailableSectors()
	{
		$sectors = [
			'compraventa' 	=> ['label' => 'Compra Venta', 'code' => DocumentTypes::FACTURA_COMPRA_VENTA],
			'alquiler'		=> ['label' => 'Alquiler Inmuebles', 'code' => DocumentTypes::FACTURA_ALQUILER_INMUEBLES],
			'prevalorada'	=> ['label' => 'PreValorada', 'code' => DocumentTypes::FACTURA_PREVALORADA],
			
		];
		
		return $sectors;
	}
	public function getCuis(SiatConfig $config, $user, int $sucursal = 0, int $puntoVenta = 0, $renew = false)
	{
		$path = sb_user_get_dir();
		
		$config = $this->getConfig();
		$filename = sprintf("%s/%d-%d-cuis.json", $path, $sucursal, $puntoVenta);
		
		$config->validate();
		//print_r($config);die;
		if( is_file($filename) && ($obj = json_decode(file_get_contents($filename))) && !$renew )
		{
			return $obj->RespuestaCuis;
		}
		
		$service = new ServicioFacturacionCodigos(null, null, $config->tokenDelegado);
		$service->setConfig((array)$config);
		$res = $service->cuis($puntoVenta, $sucursal);
		if( !isset($res->RespuestaCuis->codigo) )
		{
			$error = \sb_siat_get_messages($res->RespuestaCuis);
			throw new Exception(__('Unable to get cuis, invalid response. ' . implode('; ', $error)));
		}
		
		file_put_contents($filename, json_encode($res));
		
		return $res->RespuestaCuis;
	}
	/**
	 * 
	 * @param SiatConfig $config
	 * @param unknown $user
	 * @param int $sucursal
	 * @param int $puntoVenta
	 * @throws Exception
	 * @return \App\Modules\Siat\Entities\Cufd
	 */
	public function getCufd(SiatConfig $config, $user, int $sucursal = 0, int $puntoVenta = 0)
	{
		$cufd = $this->getLatestDbCufd($user, $sucursal, $puntoVenta);
		if( $cufd && !$cufd->expirado() )
			return $cufd;
		$cufd = $this->renewCufd($sucursal, $puntoVenta);
		
		
		return $cufd;
	}
	/**
	 * 
	 * @param SiatConfig $config
	 * @param int $sucursal
	 * @param int $puntoventa
	 * @throws Exception
	 * @return \App\Modules\Siat\Entities\Cufd
	 */
	public function renewCufd(int $sucursal, int $puntoventa)
	{
		$config = $this->getConfig();
		$cuis = $this->getCuis($config, null, $sucursal, $puntoventa);
		//$cuis->validate();
		$service = new ServicioFacturacionCodigos($cuis->codigo, null, $config->tokenDelegado);
		$service->setConfig((array)$config);
		$res = $service->cufd($puntoventa, $sucursal);
		//var_dump($config->cuis->codigo);print_r($res);die(__METHOD__);
		if( !isset($res->RespuestaCufd->codigo) )
			throw new Exception('Unable to get CUFD, invalid response. ' . \sb_siat_message($res->RespuestaCufd));
		$cufd = new Cufd();
		$cufd->codigo				= $res->RespuestaCufd->codigo;
		$cufd->codigo_control		= $res->RespuestaCufd->codigoControl;
		$cufd->direccion			= $res->RespuestaCufd->direccion;
		$cufd->codigo_sucursal		= $sucursal;
		$cufd->codigo_puntoventa	= $puntoventa;
		$cufd->fecha_vigencia		= date('Y-m-d H:i:s', strtotime($res->RespuestaCufd->fechaVigencia));
		$cufd->save();
		
		return $cufd;
	}
	/**
	 * 
	 * @param User $user
	 * @param number $sucursal
	 * @param number $puntoVenta
	 * @return Cufd
	 */
	public function getLatestDbCufd($user, $sucursal = 0, $puntoVenta = 0)
	{
		$cufd = Cufd::where('codigo_sucursal', $sucursal)->where('codigo_puntoventa', $puntoVenta)->orderBy('created_at', 'desc')->first();
		return $cufd;
	}
	public function getCufdByCode($cufd)
	{
		return Cufd::where('codigo', $cufd)->first();
	}
	public function verificarNit(int $nit)
	{
		$config 	= $this->getConfig();
		$cuis 		= $this->getCuis($config, null);
		//print_r($cuis);die(__METHOD__);
		$service 	= new ServicioFacturacionCodigos($cuis->codigo, null, $config->tokenDelegado);
		$service->setConfig((array)$config);
		$res = $service->verificarNit($nit);
		
		if( $res->RespuestaVerificarNit->mensajesList->codigo == 994 )
			throw new ExceptionInvalidNit("El NIT $nit no es valido", null, null);
		return true;
	}
	public function obtenerPuntosVenta()
	{
		$items = PointOfSale::all();
		return $items;
	}
	public function isOnline()
	{
		return true;
	}
	public function getSectorCafcData(int $documentoSector)
	{
		
		$data = [
			1 => (object)[
				'cafc'		=> '1013D3AE36D5D',
				'inicio' 	=> 1,
				'fin'		=> 1000
			],
			2 => (object)[
				'cafc'		=> '1026A3961305D',
				'inicio' 	=> 1,
				'fin'		=> 1000
			],
			23 => (object)[
				'cafc'		=> null,
				'inicio' 	=> 1,
				'fin'		=> 1000
			],
		];
		if( !isset($data[$documentoSector]) )
			throw new Exception('El documento de secto no tiene datos CAFC');
		
		return $data[$documentoSector];
	}
	public function cafcInvoiceExists()
	{
		return false;
	}
}