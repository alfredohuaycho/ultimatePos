(function(ns)
{
	class ServiceCustomers extends SBFramework.Classes.Api
	{
		constructor()
		{
			super();
		}
		async create(customer)
		{
			let data = {
				type: 'customer',
				contact_type_radio: 'individual',
				first_name: customer.first_name,
				last_name: customer.last_name,
				middle_name: '',
				mobile: '',
				email: customer.email,
				tax_number: customer.meta._nit_ruc_nif,
				shipping_address: customer.address_1,
				mobile: '1',
				position: '',
				landline: '',
				prefix: '',
				customer_group_id: '',
				city: '',
				state: '',
				country: '',
				zip_code: '',
			};
			const headers = {
				'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
			};
			const res = await this.Post(`/contacts`, data, headers);
			
			return res;
		}
		async read(id)
		{
			const res = await this.Get(`/invoices/customers/${id}`);
			
			return res;
		}
		async search(keyword)
		{
			const res = await this.Get(`/contacts/customers?q=${keyword}`, {'X-CSRF-TOKEN': document.head.querySelector('[name=csrf-token]').content});
			
			return {data: res};
		}
	}
	ns.ServiceCustomers = ServiceCustomers;
})(SBFramework.Services);