(function(ns)
{
	class ServiceBranches extends SBFramework.Classes.Api
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
			const res = await this.Get(`/invoices/siat/v2/branches`, headers);
			
			return res;
		}
		async read(id)
		{
			
		}
		async create(branch)
		{
			const headers = this.getHeaders();
			const res = await this.Post(`/invoices/siat/v2/branches`, branch, headers);
			
			return res;
		}
		async update(branch)
		{
			const headers = this.getHeaders();
			const res = await this.Put(`/invoices/siat/v2/branches`, branch, headers);
			
			return res;
		}
		async remove(id)
		{
			const headers = this.getHeaders();
			const res = await this.Delete(`/invoices/siat/v2/branches/${id}`, headers);
			
			return res;
		}
	}
	ns.ServiceBranches = ServiceBranches;
})(SBFramework.Services);