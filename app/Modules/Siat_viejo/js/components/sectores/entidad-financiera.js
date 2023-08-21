(function(ns)
{
	ns.DetalleFinanciera = {
		removeFields: ['numero_serie', 'imei'],
		template: `<div class="financiera-detalle">
			<div class="row">
				<div class="col-12 col-sm-6">
					<div class="mb-2">
						<label>Monto Arrendamiento Financiero</label>
						<input type="text" class="form-control" required v-model="invoice.data.custom_fields.montoTotalArrendamientoFinanciero" />
					</div>
				</div>
				<div class="col-13 col-sm-6">
					<div class="mb-2">
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
			this.invoice.data.custom_fields.periodoFacturado = sb_formatdate(new Date(), 'Y-m-d');
		}
	};
	ns.ItemFinanciera = {
		
	};
})(SBFramework.Components.Siat);