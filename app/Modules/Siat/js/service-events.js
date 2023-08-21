(function(ns)
{
	class ServiceEvents extends SBFramework.Classes.Api
	{
		constructor()
		{
			super();
		}
		async obtenerActivo(sucursal, puntoventa)
		{
			let res = await this.Get(`/invoices/siat/v2/eventos/activo?sucursal=${sucursal}&puntoventa=${puntoventa}`);
			
			return res;
		}
		async crear(evento)
		{
			const headers = {
				'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
			};
			const res = await this.Post('/invoices/siat/v2/eventos', evento, headers);
			
			return res;
		}
		async cerrar(eventId)
		{
			const res = await this.Get(`/invoices/siat/v2/eventos/${eventId}/cerrar`);
			return res;
		}
		async anular(eventId)
		{
			const res = await this.Get('/invoices/siat/v2/eventos/' + eventId + '/anular');
			
			return res;
		}
		async validarRecepcion(eventId)
		{
			const res = await this.Get(`/invoices/siat/v2/eventos/${eventId}/validar-recepcion`);
			
			return res;
		}
		async obtenerEventos(sucursal, puntoventa, page)
		{
			page = page || 1;
			const res = await this.Get(`/invoices/siat/v2/eventos?page=${page}&sucursal_id=${sucursal}&puntoventa_id=${puntoventa}`)
			return res;
		}
		async syncEventos(sucursal, puntoventa, date)
		{
			const res = this.Get(`/invoices/siat/v2/eventos/sync?sucursal_id=${sucursal}&puntoventa_id=${puntoventa}&fecha=${date}`);
			
			return res;
		}
		async stats(eventId)
		{
			const res = await this.Get(`/invoices/siat/v2/eventos/${eventId}/stats`);
			
			return res;
		}
	}
	ns.ServiceEvents = ServiceEvents;
})(SBFramework.Services);