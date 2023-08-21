(function(ns)
{
	ns.DetalleExportacionServicio = {
		removeFields: ['numero_serie', 'imei'],
		template: `<div class="exportacion-servicio-detalle">
			<div class="row">
				<div class="col-12 col-sm-6">
					<div class="mb-2">
						<label>Direccion Comprador</label>
						<input type="text" class="form-control" required v-model="invoice.data.custom_fields.direccionComprador" />
					</div>
				</div>
				<div class="col-13 col-sm-6">
					<div class="mb-2">
						<label>Lugar Destino</label>
						<input type="text" class="form-control" required v-model="invoice.data.custom_fields.lugarDestino" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-12 col-sm-6">
					<div class="mb-2">
						<label>Codigo Pais</label>
						<input type="text" class="form-control" required v-model="invoice.data.custom_fields.codigoPais" />
					</div>
				</div>
				<div class="col-13 col-sm-6">
					<div class="mb-2">
						<label>Informacion adicional</label>
						<textarea class="form-control" v-model="invoice.data.custom_fields.informacionAdicional"></textarea>
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
	ns.ItemExportacionServicio = {
		
	};
})(SBFramework.Components.Siat);