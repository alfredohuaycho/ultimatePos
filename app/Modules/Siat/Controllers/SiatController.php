<?php
namespace App\Modules\Siat\Controllers;

use App\Http\Controllers\Controller;
use App\Modules\Siat\Entities\Invoice;
use App\Modules\Siat\Models\InvoiceModel;
use App\Modules\Siat\Settings;
use Exception;
use App\Modules\Siat\Models\SiatModel;
use Illuminate\Support\Facades\Storage;

class SiatController extends Controller
{
	protected function getCommonVars()
	{
		$vars = [
			'layout' 			=> Settings::getInstance()->getLayout(),
			'section_scripts' 	=> Settings::getInstance()->section_scripts,
		];
		if( Settings::getInstance()->isUltimatePOS() )
			$vars['layout'] = 'layouts.app';
			
		return $vars;
	}
	public function sync()
	{
		$vars = $this->getCommonVars();
		return view('Siat::sync', $vars);
		//return view('home.index');
	}
	public function cufds()
	{
		$vars = $this->getCommonVars();
		return view('Siat::cufds', $vars);
	}
	public function clientes()
	{
		$vars = $this->getCommonVars();
		return view('Siat::customers', $vars);
	}
	public function productos()
	{
		$vars = $this->getCommonVars();
		return view('Siat::products', $vars);
	}
	public function facturas()
	{
		$vars = $this->getCommonVars();
		return view('Siat::facturas', $vars);
	}
	public function facturador()
	{
		$vars = $this->getCommonVars();
		return view('Siat::facturador', $vars);
	}
	public function eventos()
	{
		$vars = $this->getCommonVars();
		return view('Siat::eventos', $vars);
	}
	public function config()
	{
		$vars = $this->getCommonVars();
		return view('Siat::config', $vars);
	}
	public function readConfig(SiatModel $model)
	{
		$config = $model->getConfig();
		return response()->json(['data' => $config, 200])->header('Content-Type', 'application/json');
	}
	public function saveConfig(SiatModel $model)
	{
		try
		{
			$data = (object)request()->json()->all();
			$model->saveConfig($data);
			return response()->json(['message' => 'Configuracion guardada', 200])->header('Content-Type', 'application/json');
		}
		catch(Exception $e)
		{
			return response()->json(['error' => $e->getMessage(), 500])->header('Content-Type', 'application/json');
		}
	}
	public function uploadCerts(SiatModel $model)
	{
		try
		{
			$private 		= request()->file('private_key');//->store('siat/config');
			$cert 			= request()->file('certificate');//->store('siat/config');
			$logo			= request()->file('logo');
			//$pathPrivate 	= Storage::put('siat/certs', $private);
			//$pathCert 		= Storage::put('siat/certs', $cert);
			$config = $model->getConfig();
			if( $logo && $logo->getSize() > 0 )
			{
				if( $config->logo && is_file($config->logo) )
					unlink($config->logo);
				$pathLogo 	= SIAT_MOD_CERTS_DIR . SB_DS . md5(time() . 'logo') . '-logo.pem';
				file_put_contents($pathLogo, $logo->get());
				$config->logo 	= $pathLogo;
			}
			if( $private && $private->getSize() > 0 )
			{
				if( $config->privCert && is_file($config->privCert) )
					unlink($config->privCert);
				$pathPrivate 	= SIAT_MOD_CERTS_DIR . SB_DS . md5(time()) . '-private.pem';
				file_put_contents($pathPrivate, $private->get());
				$config->privCert 	= $pathPrivate;
			}
			if( $cert && $cert->getSize() > 0 )
			{
				if( $config->pubCert && is_file($config->pubCert) )
					unlink($config->pubCert);
				$pathCert 		= SIAT_MOD_CERTS_DIR . SB_DS . md5(time()) . '-cert.pem';
				file_put_contents($pathCert, $cert->get());
				$config->pubCert	= $pathCert;
			}
			
			$model->saveConfig($config);
			return response()->json(['message' => 'Certificados guardados', 200, 'data' => $config])->header('Content-Type', 'application/json');
			
		}
		catch(Exception $e)
		{
			return response()->json(['error' => $e->getMessage(), 500])->header('Content-Type', 'application/json');
		}
	}
	public function branches()
	{
		$vars = $this->getCommonVars();
		return view('Siat::sucursales', $vars);
	}
	public function pointofsales()
	{
		$vars = $this->getCommonVars();
		return view('Siat::puntosventa', $vars);
	}
	public function view(int $id, InvoiceModel $model)
	{
		$tpl 		= request()->get('tpl');
		$invoice 	= Invoice::find($id);
		if( !$invoice )
			die('La factura no existe');
		
		$dompdf = $model->buildPdf($invoice, $tpl);
		
		return response()->stream(function() use($dompdf)
		{
			$dompdf->stream('invoice', ['Attachment' => 0]);
		}, 200, ['Content-Type' => 'application/pdf'])->sendContent();
	}
	public function demo()
	{
		return view('Siat::demo.index');
	}
}
