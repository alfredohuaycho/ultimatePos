<?php
namespace App\Modules\Siat;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\View;
use App\Events\TransactionComplete;
use App\Modules\Siat\Models\InvoiceModel;
defined('SB_DS') or define('SB_DS', DIRECTORY_SEPARATOR);
define('DATE_FORMAT', 'd-m-Y');
define('TIME_FORMAT', 'H:i:s');
define('TEMP_DIR', __DIR__ . SB_DS . 'xtemp');
define('SITE_TITLE', 'Terrapuerto');

if( !is_dir(TEMP_DIR) )
	mkdir(TEMP_DIR);
require_once __DIR__ . SB_DS . 'functions.php';

class SiatProvider extends ServiceProvider
{
	protected	$namespace = 'App\Modules\Siat\Controllers';
	
	public function __construct($app)
	{
		parent::__construct($app);
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
		view()->composer(['product.create','product.edit'], function($view)
		{
			$vars = $view->getData();
			$vars['extra_fields'][] = 'Siat::products/extra-fields';
			$view->with($vars);
		});
	}
}