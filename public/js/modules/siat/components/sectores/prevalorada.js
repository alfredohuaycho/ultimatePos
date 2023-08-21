(function(ns)
{
	ns.DetallePrevalorada = {
		removeFields: ['numero_serie', 'imei'],
		template: `<div class="hotel-detalle">
			<div class="row">
				<div class="col-12 col-sm-6">
					<div class="form-group mb-2">
						<label>Cantidad Facturas</label>
						<input type="number" min="1" max="100" class="form-control" required v-model="invoice.data.cantidad" />
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
		mounted()
		{
			
		},
		created()
		{
			this.invoice.data.cantidad = 1;
		}
	};
	ns.ItemPrevalorada = {
		
	};
})(SBFramework.Components.Siat);