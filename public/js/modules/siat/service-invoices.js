(function(ns)
{
	class ServiceInvoices extends SBFramework.Classes.Api
	{
		constructor()
		{
			super();
		}
		async obtenerCuis(renew)
		{
			let res = await this.Get('/invoices/siat/v2/cuis?renew=' + ( renew ? 1 : 0));
			
			return res;
		}
		async obtenerCufd(sucursal, puntoventa, renew)
		{
			let res = await this.Get('/invoices/siat/v2/cufd?renew=' + ( renew ? 1 : 0) + `&sucursal=${sucursal}&puntoventa=${puntoventa}`);
			
			return res;
		}
		async obtenerCufds(sucursal, puntoventa)
		{
			let res = await this.Get(`/invoices/siat/v2/cufds?sucursal=${sucursal}&puntoventa=${puntoventa}`);
			
			return res;
		}
		async obtenerSucursales()
		{
			let res = await this.Get('/invoices/siat/v2/branches');
			
			return res;
		}
		async obtenerPuntosVenta()
		{
			let res = await this.Get('/invoices/siat/v2/puntos-venta');
			
			return res;
		}
		async obtenerTiposProductos()
		{
			let res = await this.Get('/invoices/siat/v2/lista-productos-servicios');
			
			return res;
		}
		async obtenerUnidadesMedida()
		{
			let res = await this.Get('/invoices/siat/v2/sync-unidades-medida');
			
			return res;
		}
		async obtenerMonedas()
		{
			let res = await this.Get('/invoices/siat/v2/sync-tipos-moneda');
			
			return res;
		}
		async obtenerDocumentosIdentidad()
		{
			let res = await this.Get('/invoices/siat/v2/sync-documentos-identidad');
			
			return res;
		}
		async obtenerMetodosPago()
		{
			let res = await this.Get('/invoices/siat/v2/sync-metodos-pago');
			
			return res;
		}
		async obtenerActividades()
		{
			let res = await this.Get('/invoices/siat/v2/actividades');
			
			return res;
		}
		async obtenerActividadesDocumentoSector()
		{
			let res = await this.Get('/invoices/siat/v2/lista-actividades');
			return res;
		}
		async obtenerMotivosAnulacion()
		{
			let res = await this.Get('/invoices/siat/v2/sync-motivos-anulacion');
			return res;
		}
		async obtenerDocumentosIdentidad()
		{
			let res = await this.Get('/invoices/siat/v2/sync-documentos-identidad');
			return res;
		}
		async obtenerEventos()
		{
			let res = await this.Get('/invoices/siat/v2/sync-eventos');
			return res;
		}
		async obtenerLeyendas()
		{
			let res = await this.Get('/invoices/siat/v2/lista-leyendas-factura');
			return res;
		}
		async obtenerProductosServicios()
		{
			let res = await this.Get('/invoices/siat/v2/lista-productos-servicios');
			return res;
		}
		async obtenerTiposDocumentoSector()
		{
			let res = await this.Get('/invoices/siat/v2/sync-tipos-documentos-sector');
			return res;
		}
		async obtenerTiposEmision()
		{
			let res = await this.Get('/invoices/siat/v2/sync-tipos-emision');
			return res;
		}
		async obtenerTiposFactura()
		{
			let res = await this.Get('/invoices/siat/v2/sync-tipos-facturas');
			return res;
		}
		async obtenerTiposHabitacion()
		{
			let res = await this.Get('/invoices/siat/v2/lista-tipos-habitacion');
			return res;
		}
		async obtenerTiposMetodoPago()
		{
			let res = await this.Get('/invoices/siat/v2/sync-metodos-pago');
			return res;
		}
		async obtenerTiposMoneda()
		{
			let res = await this.Get('/invoices/siat/v2/sync-tipos-moneda');
			return res;
		}
		async obtenerTiposPuntoVenta()
		{
			let res = await this.Get('/invoices/siat/v2/sync-tipos-punto-venta');
			return res;
		}
		async crearEvento(evento, system)
		{
			const res = await this.Post(`/invoices/siat/v2/eventos?system=${system}`, evento);
			
			return res;
		}
		async crearFactura(invoice)
		{
			const headers = {
				'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
			};
			const res = await this.Post(`/invoices`, invoice, headers);
			
			return res;
		}
		async obtenerFacturas(page, limit, keyword)
		{
			const res = await this.Get('/invoices/siat/v2/invoices?page=' + page);
			//console.log(res.headers.get("total-pages"));
			return res;
		}
		async anular(id, obj)
		{
			const headers = {
				'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
			};
			const res = await this.Post('/invoices/' + id + '/void', obj, headers);
			return res;
		}
		async buscarProducto(keyword)
		{
			const res = await this.Get(`/invoices/products/search?keyword=${keyword}`);
			
			return res;
		}
		async buscar(keyword)
		{
			const res = await this.Get(`/invoices/search?keyword=${keyword}`);
			
			return res;
		}
	}
	ns.ServiceInvoices = ServiceInvoices;
})(SBFramework.Services);