(function(ns)
{
	class ServiceProducts extends SBFramework.Classes.Api
	{
		constructor()
		{
			super();
		}
		async create(product)
		{
			const res = await this.Post(`/invoices/siat/v2/products`, product, this.getHeaders());
			
			return res;
		}
		async read(id)
		{
			const res = await this.Get(`/invoices/siat/v2/products/${id}`);
			
			return res;
		}
		async readAll(page)
		{
			const res = await this.Get(`/invoices/siat/v2/products?page=${page}`);
			
			return res;
		}
		async update(product)
		{
			const res = await this.Put(`/invoices/siat/v2/products`, product, this.getHeaders());
			
			return res;
		}
		async remove(id)
		{
			const res = await this.Delete(`/invoices/siat/v2/products/${id}`, this.getHeaders());
			
			return {data: res};
		}
		async search(keyword, page)
		{
			const res = await this.Get(`/invoices/siat/v2/products?q=${keyword}`, this.getHeaders());
			return res;
			//return {data: res};
		}
	}
	ns.ServiceProducts = ServiceProducts;
})(SBFramework.Services);