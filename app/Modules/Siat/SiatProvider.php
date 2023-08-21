<?php
namespace App\Modules\Siat;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\Route;
use Illuminate\View\View;
use App\Events\TransactionComplete;
use App\Modules\Siat\Models\InvoiceModel;

defined('SB_DS') or define('SB_DS', DIRECTORY_SEPARATOR);
define('SIAT_MOD_VERSION', '1.0.14');
define('DATE_FORMAT', 'd-m-Y');
define('TIME_FORMAT', 'H:i:s');
define('TEMP_DIR', __DIR__ . SB_DS . 'xtemp');
define('SITE_TITLE', env('APP_TITLE'));
define('SIAT_MOD_DATA_DIR', storage_path() . SB_DS . 'siat');
define('SIAT_MOD_CFG_DIR',  SIAT_MOD_DATA_DIR . SB_DS . 'config');
define('SIAT_MOD_CERTS_DIR', SIAT_MOD_DATA_DIR . SB_DS . 'certs');

foreach([SIAT_MOD_DATA_DIR, SIAT_MOD_CFG_DIR, SIAT_MOD_CERTS_DIR, TEMP_DIR] as $dir)
{
	if( !is_dir($dir) )
		mkdir($dir, null, true);
}
require_once __DIR__ . SB_DS . 'functions.php';

class SiatProvider extends ServiceProvider
{
	protected	$namespace = 'App\Modules\Siat\Controllers';
	
	public function __construct($app)
	{
		parent::__construct($app);
		//$this->initLibSiat();
	}
	public function register()
	{
		view()->addNamespace('Siat', __DIR__ . DIRECTORY_SEPARATOR . 'views');
	}
	public function boot()
	{
		date_default_timezone_set('America/La_Paz');
		$this->initLibSiat();
		$this->registerRoutes();
		$this->addListeners();
		view()->composer('*', function(View $view)
		{
			$vars = $view->getData();
			$vars['siat_settings'] = Settings::getInstance();
			
			$view->with($vars);
		});
		
		$this->addFields();
	}
	protected function initLibSiat()
	{
		require_once __DIR__ . SB_DS . 'LibSiat' . SB_DS . 'autoload.php';
	}
	protected function registerRoutes()
	{
		$web_routes = __DIR__ . DIRECTORY_SEPARATOR . 'routes' . DIRECTORY_SEPARATOR . 'web.php';
		$api_routes = __DIR__ . DIRECTORY_SEPARATOR . 'routes' . DIRECTORY_SEPARATOR . 'api.php';
		
		Route::middleware('web')
			->namespace($this->namespace)
			->group($web_routes);
		
		Route::prefix('api')
			->middleware('api')
			->namespace($this->namespace)
			->group($api_routes);
		
	}
	protected function addListeners()
	{
		Event::listen('App\Events\TransactionComplete', function(TransactionComplete $event)
		{
			$model = new InvoiceModel();
			$model->transaction2Invoice($event->transaction);
		});
	}
	protected function addFields()
	{
		//##add product fields for UltimatePOS
		view()->composer(['product.create','product.edit'], function($view)
		{
			$vars = $view->getData();
			$vars['extra_fields'][] = 'Siat::products/extra-fields';
			$view->with($vars);
		});
	}
}
