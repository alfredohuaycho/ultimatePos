(function(ns)
{
	ns.UserPortal = {
		template: `<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="text-center mb-2">
						<img v-bind:src="logo" alt="" style="height:150px;" />
					</div>
					<h1 class="text-center">Bienvenido al portal Mis Facturas del sistema QUIBO</h1>
				</div>
				<div class="col-12">
					<p class="text-center">Aqui podrás obtener información de tus facturas las 24 horas del día.</p>
				</div>
			</div>
			<div class="row justify-content-center">
				<template v-if="!com_current">
					<div class="col-12 col-sm-4">
						<form>
							<div class="mb-3">
								<div class="input-group">
									<input type="text" class="form-control" v-model="keyword" placeholder="Ingrese su numero de NIT"
										v-on:keydown.enter="$event.preventDefault();search()"
										 />
									<button type="button" class="btn btn-primary" v-on:click="search()">Buscar</button>
								</div>
							</div>
						</form>
					</div>
				</template>
				<template v-else>
					<keep-alive>
						<component v-bind:is="com_current" v-bind="com_args" v-on:change-page="changePage"></component>
					</keep-alive>
				</tempalte>
			</div>
		</div>`,
		components: {
			'user-invoices': ns.UserInvoices
		},
		data()
		{
			return {
				com: null,
				com_key: '',
				com_args: {},
				keyword: '',
				logo: '',
			};
		},
		computed: 
		{
			com_current: function()
			{
				return this.com;
			},
		},
		methods: 
		{
			changePage(page)
			{
				this.search(page);
			},
			prevPage(page)
			{
				this.search(page);
			},
			nextPage(page)
			{
				this.search(page);
			},
			async search(page)
			{
				page = page || 1;
				try
				{
					this.$root.$processing.show('Por favor espere...');
					const res = await this.$root.api.Get('/invoices/siat/v2/user-search?keyword=' + this.keyword + `&page=${page}`);
					this.$root.$processing.hide();
					console.log('total pages', res.headers.get('total-pages'));
					if( !res.data || res.data.length <= 0 )
					{
						alert('Usted no tiene registro de facturas emitidas');
						return;
					}
					this.com_args = {
						current_page: page, 
						total_pages: parseInt(res.headers.get('total-pages')),
						items: res.data, 
					};
					this.com_key = Date.now();
					this.com = 'user-invoices';
				}
				catch(e)
				{
					this.$root.$processing.hide();
				}
			}
		},
		mounted()
		{
			
		},
		created()
		{
			this.logo = lt.baseurl + '/templates/fundamental/images/logo.png';
		}
	};
	SBFramework.AppComponents = {
		'user-portal': ns.UserPortal, 
	};
})(SBFramework.Components.Siat);