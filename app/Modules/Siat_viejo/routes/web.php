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

Route::prefix('/siat')->middleware(['setData', 'auth', 'SetSessionData', 'language', 'timezone', 'AdminSidebarMenu', 'CheckUserLogin'])->group(function()
{
	Route::get('/sync', [SiatController::class, 'sync'])->name('siat.sync');
	Route::get('/cufds', [SiatController::class, 'cufds'])->name('siat.cufds');
	Route::get('/facturas', [SiatController::class, 'facturas'])->name('siat.facturas');
	Route::get('/facturas/{id}/view', [SiatController::class, 'view'])->name('siat.facturas.view');
	Route::get('/facturador', [SiatController::class, 'facturador'])->name('siat.facturador');
	Route::get('/eventos', [SiatController::class, 'eventos'])->name('siat.eventos');
	//Route::get('/sync', '\\App\Modules\Siat\Controllers\SiatController@sync')->name('siat.sync');
});
Route::post('/invoices', [ApiInvoicesController::class, 'create']);
Route::post('/invoices/{id}/void', [ApiInvoicesController::class, 'anular']);
Route::get('/invoices/search', [ApiInvoicesController::class, 'search']);
Route::get('/invoices/products/search', [ApiInvoicesController::class, 'searchProduct']);
Route::get('/invoices/testmail', function()
{
	lt_mail('marcenickg@gmail.com', 'Prueba', 'Mensaje de prueba');
	die;
});
Route::prefix('/invoices/siat/v2/')->group(function()
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
	
	Route::get('branches', [ApiSucursalesController::class, 'readAll']);
	Route::get('puntos-venta', [ApiPuntosVentaController::class, 'readAll']);
	
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
});
