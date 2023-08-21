<?php
use Illuminate\Support\Facades\Route;
use App\Modules\Siat\Controllers\ApiCodesController;
use App\Modules\Siat\Controllers\ApiSyncController;
use App\Modules\Siat\Controllers\SiatController;
use App\Modules\Siat\Controllers\ApiPuntosVentaController;
use App\Modules\Siat\Controllers\ApiSucursalesController;
use App\Modules\Siat\Controllers\ApiEventsController;
use App\Modules\Siat\Controllers\ApiInvoices;
use App\Modules\Siat\Controllers\ApiInvoicesController;
use App\Modules\Siat\Controllers\ApiCustomersController;
use App\Modules\Siat\Controllers\ApiProductsController;

$middlewares = [];
$appName = env('APP_NAME');
if( $appName == 'ultimatePOS' )
	$middlewares = ['setData', 'auth', 'SetSessionData', 'language', 'timezone', 'AdminSidebarMenu', 'CheckUserLogin'];

//##uncomment next line to protect routes with user authentication middleware
//$middlewares[] = 'auth:users';

Route::prefix('/siat')->middleware($middlewares)->group(function()
//Route::prefix('/siat')->middleware(['auth', 'language', 'timezone'])->group(function()
{
	Route::get('/demo', [SiatController::class, 'demo'])->name('siat.demo');
	Route::get('/sync', [SiatController::class, 'sync'])->name('siat.sync');
	Route::get('/cufds', [SiatController::class, 'cufds'])->name('siat.cufds');
	Route::get('/clientes', [SiatController::class, 'clientes'])->name('siat.clientes');
	Route::get('/productos', [SiatController::class, 'productos'])->name('siat.productos');
	Route::get('/facturas', [SiatController::class, 'facturas'])->name('siat.facturas');
	Route::get('/facturas/{id}/view', [SiatController::class, 'view'])->name('siat.facturas.view');
	Route::get('/facturador', [SiatController::class, 'facturador'])->name('siat.facturador');
	Route::get('/eventos', [SiatController::class, 'eventos'])->name('siat.eventos');
	Route::get('/config', [SiatController::class, 'config'])->name('siat.config');
	Route::get('/config/read', [SiatController::class, 'readConfig'])->name('siat.config.read');
	Route::post('/config', [SiatController::class, 'saveConfig'])->name('siat.config');
	Route::post('/config/certs/upload', [SiatController::class, 'uploadCerts'])->name('siat.config.certs');
	Route::get('/branches', [SiatController::class, 'branches'])->name('siat.branches');
	Route::get('/pointofsales', [SiatController::class, 'pointofsales'])->name('siat.pointofsales');
	//Route::get('/sync', '\\App\Modules\Siat\Controllers\SiatController@sync')->name('siat.sync');
});
Route::middleware($middlewares)->group(function()
{
	Route::post('/invoices', [ApiInvoicesController::class, 'create']);
	Route::post('/invoices/{id}/void', [ApiInvoicesController::class, 'anular']);
	Route::get('/invoices/search', [ApiInvoicesController::class, 'search']);
	Route::get('/invoices/products/search', [ApiInvoicesController::class, 'searchProduct']);
});

Route::get('/invoices/testmail', function()
{
	lt_mail('marcenickg@gmail.com', 'Prueba', 'Mensaje de prueba');
	die;
});
Route::middleware($middlewares)->prefix('/invoices/siat/v2/')->group(function()
{
	Route::get('cuis', [ApiSyncController::class, 'cuis']);
	Route::get('cufd', [ApiSyncController::class, 'cufd']);
	Route::get('cufds', [ApiCodesController::class, 'leerCUFDS']);
	Route::get('actividades', [ApiSyncController::class, 'actividades']);
	Route::get('lista-actividades', [ApiSyncController::class, 'actividadesDocSector']);
	
	Route::get('lista-leyendas-factura', [ApiSyncController::class, 'leyendasFactura']);
	Route::get('lista-tipos-habitacion', [ApiSyncController::class, 'tiposHabitacion']);
	Route::get('lista-productos-servicios', [ApiSyncController::class, 'productosServicios']);
	Route::get('sync-eventos', [ApiSyncController::class, 'eventos']);
	Route::get('sync-motivos-anulacion', [ApiSyncController::class, 'motivosAnulacion']);
	Route::get('sync-unidades-medida', [ApiSyncController::class, 'unidadesMedida']);
	Route::get('sync-tipos-moneda', [ApiSyncController::class, 'tiposMoneda']);
	Route::get('sync-documentos-identidad', [ApiSyncController::class, 'documentosIdentidad']);
	Route::get('sync-metodos-pago', [ApiSyncController::class, 'metodosPago']);
	Route::get('sync-tipos-documentos-sector', [ApiSyncController::class, 'documentosSector']);
	Route::get('sync-tipos-emision', [ApiSyncController::class, 'tiposEmision']);
	Route::get('sync-tipos-punto-venta', [ApiSyncController::class, 'tiposPuntoVenta']);
	Route::get('sync-tipos-facturas', [ApiSyncController::class, 'tiposFactura']);
	
	Route::get('branches', [ApiSucursalesController::class, 'readAll']);
	Route::post('branches', [ApiSucursalesController::class, 'create']);
	Route::put('branches', [ApiSucursalesController::class, 'update']);
	Route::delete('branches/{id}', [ApiSucursalesController::class, 'delete']);
	
	Route::get('puntos-venta/sync', [ApiPuntosVentaController::class, 'sync']);
	Route::get('puntos-venta', [ApiPuntosVentaController::class, 'readAll']);
	Route::post('puntos-venta', [ApiPuntosVentaController::class, 'create']);
	Route::put('puntos-venta', [ApiPuntosVentaController::class, 'update']);
	Route::delete('puntos-venta/{id}', [ApiPuntosVentaController::class, 'delete']);
	
	Route::get('/eventos', [ApiEventsController::class, 'readAll']);
	Route::get('/eventos/activo', [ApiEventsController::class, 'eventoActivo']);
	Route::post('/eventos', [ApiEventsController::class, 'create']);
	Route::get('/eventos/{id}/stats', [ApiEventsController::class, 'stats']);
	Route::get('/eventos/{id}/cerrar', [ApiEventsController::class, 'close']);
	Route::get('/eventos/{id}/anular', [ApiEventsController::class, 'voidEvent']);
	//Route::prefix('eventos')->group(function()
	//{
	//	Route::get('/activo', [ApiEventsController::class, 'eventoActivo']);
	//});
	Route::get('invoices', [ApiInvoicesController::class, 'readAll']);
	//##customers route
	Route::get('customers', [ApiCustomersController::class, 'readAll'])->name('siat.api.customers');
	Route::get('customers/{id}', [ApiCustomersController::class, 'read'])->name('siat.api.customers.read');
	Route::post('customers', [ApiCustomersController::class, 'create'])->name('siat.api.customers.create');
	Route::put('customers', [ApiCustomersController::class, 'update'])->name('siat.api.customers.update');
	Route::delete('customers/{id}', [ApiCustomersController::class, 'delete'])->name('siat.api.customers.delete');
	//##products route
	Route::get('products', [ApiProductsController::class, 'readAll'])->name('siat.api.products');
	Route::get('products/{id}', [ApiProductsController::class, 'read'])->name('siat.api.products.read');
	Route::post('products', [ApiProductsController::class, 'create'])->name('siat.api.products.create');
	Route::put('products', [ApiProductsController::class, 'update'])->name('siat.api.products.update');
	Route::delete('products/{id}', [ApiProductsController::class, 'delete'])->name('siat.api.products.delete');
});
