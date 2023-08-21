<?php
namespace App\Modules\Siat\Middleware;

use Closure;
use Menu;
use App\Modules\Siat\Controllers\SiatController;

class SiatSidebarMenu
{
	/**
	 * Handle an incoming request.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @param  \Closure  $next
	 * @return mixed
	 */
	public function handle($request, Closure $next)
	{
		if ($request->ajax()) {
			return $next($request);
		}
		$user = auth()->user();
		if( !$user )
			return $next($request);
		
		$enabled_modules = !empty(session('business.enabled_modules')) ? session('business.enabled_modules') : [];
		$common_settings = !empty(session('business.common_settings')) ? session('business.common_settings') : [];
		$pos_settings = !empty(session('business.pos_settings')) ? json_decode(session('business.pos_settings'), true) : [];
		$is_admin = $user->hasRole('Admin#' . session('business.id')) ? true : false;
		
		//$menu = Menu::create('admin-sidebar-menu');
		$menus = Menu::all();
		$menu = isset($menus['admin-sidebar-menu']) ? $menus['admin-sidebar-menu'] : null;
		if( !$menu )
			return $next($request);
		$menu->dropdown(
			__('Facturacion SIAT'),
			function ($sub) use ($enabled_modules) 
			{
				$sub->route(
					//'/siat/sync',
					'siat.sync',
					//action('\\App\\Modules\\Siat\\Controllers\\SiatController@sync'),
					__('Sincronizacion'),
					[],
					['icon' => 'fa fas fa-cogs', 'active' => request()->segment(2) == 'sync', 'id' => "tour_step2"]
				);
				$sub->route(
					'siat.eventos',
					__('Eventos'),
					[],
					['icon' => 'fa fas fa-cogs', 'active' => request()->segment(2) == 'eventos', 'id' => "tour_step2"]
				);
				$sub->route(
					'siat.cufds',
					__('CUFDs'),
					[],
					['icon' => 'fa fas fa-cogs', 'active' => request()->segment(2) == 'cufds', 'id' => "tour_step2"]
				);
				$sub->route(
					'siat.facturas',
					__('Facturas'),
					[],
					['icon' => 'fa fas fa-cogs', 'active' => request()->segment(2) == 'facturas', 'id' => "tour_step2"]
				);
				$sub->route(
					'siat.facturador',
					__('Facturador'),
					[],
					['icon' => 'fa fas fa-cogs', 'active' => request()->segment(2) == 'facturador', 'id' => "tour_step2"]
				);
			},
			['icon' => 'fa fas fa-receipt']
		)->order(15);
			
		//print_r($menu);die;
		return $next($request);
	}
}