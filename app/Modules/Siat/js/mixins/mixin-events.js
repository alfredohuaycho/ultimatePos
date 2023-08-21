(function(ns)
{
	ns.Events = {
		data()
		{
			return {
				serviceEvents: new SBFramework.Services.ServiceEvents(),
			};
		},
		methods:
		{
			async checkActiveEvent(sucursal, puntoventa)
			{
				try
				{
					this.$root.$processing.show('Verificando...');
					const res = await this.serviceEvents.obtenerActivo(sucursal, puntoventa);
					console.log('mixin', res);
					this.$root.$processing.hide();
					return res.data;
					//this.activeEvent = res.data;
					//this.$root.$processing.hide();
				}	
				catch(e)
				{
					this.$root.$processing.hide();
					alert(e.error || e.message || 'Error desconocido al verificar eventos activos');
				}
			}
		}
	};
})(SBFramework.Mixins);