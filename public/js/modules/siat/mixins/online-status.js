(function(ns)
{
	ns.SiatOnlineStatus = {
		data()
		{
			return {
				interval: null,
			};	
		},
		methods: 
		{
			async checkOnlineStatus()
			{
				try
				{
					const res = await this.$root.api.Get('/invoices/siat/v2/check-online-status?system=1&puntoventa=' + this.invoice.punto_venta);
					let eventId = isNaN(parseInt(res.data.siat_event)) ? -1 : parseInt(res.data.siat_event);
					
					if( res.data.siat_online == 'FALSE' && res.data.siat_event && this.openEvent 
						&& !this.activeEvent && [1, 2].indexOf(eventId) != -1
					)
					{
						this.openEvent(eventId, true);
					}
					else if( res.data.siat_online == 'TRUE' && this.activeEvent && [1, 2].indexOf(this.activeEvent.evento_id) != -1 
						&& this.cerrarEvento 
					)
					{
						this.cerrarEvento();
					}
				}
				catch(e)
				{
					console.log('ERROR CHECKING ONLINE STATUS', e);
				}
			},
			startInterval()
			{
				//this.interval = setInterval(this.checkOnlineStatus, 15000);
			}
		},
		mounted()
		{
			
		},
		created()
		{
			
		}
	};
})(SBFramework.Mixins);