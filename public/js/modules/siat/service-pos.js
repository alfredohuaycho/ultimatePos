(function(ns)
{
	class ServicePointOfSale extends SBFramework.Classes.Api
	{
		constructor()
		{
			super();
		}
		getHeaders()
		{
			const headers = {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content};
			
			return headers;
		}
		async readAll()
		{
			const headers = this.getHeaders();
			const res = await this.Get(`/invoices/siat/v2/puntos-venta`, headers);
			
			return res;
		}
		async read(id)
		{
			const headers = this.getHeaders();
			const res = await this.Get(`/invoices/siat/v2/puntos-venta/${id}`, headers);
			
			return res;
		}
		async create(branch)
		{
			const headers = this.getHeaders();
			const res = await this.Post(`/invoices/siat/v2/puntos-venta`, branch, headers);
			
			return res;
		}
		async update(branch)
		{
			const headers = this.getHeaders();
			const res = await this.Put(`/invoices/siat/v2/puntos-venta`, branch, headers);
			
			return res;
		}
		async remove(id)
		{
			const headers = this.getHeaders();
			const res = await this.Delete(`/invoices/siat/v2/puntos-venta/${id}`, headers);
			
			return res;
		}
		async sync()
		{
			const headers = this.getHeaders();
			const res = await this.Get(`/invoices/siat/v2/puntos-venta/sync`, headers);
			
			return res;
		}
	}
	ns.ServicePointOfSale = ServicePointOfSale;
})(SBFramework.Services);