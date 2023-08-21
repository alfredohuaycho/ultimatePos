(function(ns)
{
	class ServiceConfig extends SBFramework.Classes.Api
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
		async save(data)
		{
			const headers = this.getHeaders();
			const res = await this.Post(`/siat/config`, data, headers);
			
			return res;
		}
		async read()
		{
			const headers = this.getHeaders();
			const res = await this.Get(`/siat/config/read`, headers);
			
			return res;
		}
	}
	ns.ServiceConfig = ServiceConfig;
})(SBFramework.Services);