(function(ns)
{
	ns.DetalleAlquiler = {
		template: `<div class="hotel-detalle">
			<div class="row">
				<div class="col-12 col-sm-3">
					<div class="mb-2">
						<label>Periodo Facturado</label>
						<input type="text" class="form-control" required v-model="invoice.data.custom_fields.periodoFacturado" />
					</div>
				</div>
			</div>
		</div>`,
		props: {
			invoice: {type: Object, required: true},
		},
		data()
		{
			return {
				
			};
		},
		methods:
		{
			
		},
		mounted()
		{
		},
		created()
		{
			this.invoice.data.custom_fields.periodoFacturado = ''; //new Date(); //, 'Y-m-d';
		}
	};
	ns.ItemAlquiler = {
		template: ``,
		mounted()
		{
			
		},
		created()
		{
			
		}
	};
})(SBFramework.Components.Siat);