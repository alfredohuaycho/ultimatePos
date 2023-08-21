(function(ns)
{
	ns.DetalleTasaCero = {};
	ns.ItemTasaCero = {
		removeFields: ['numero_serie', 'imei'],
		template: `<div class="tasa-cero-item">
			<!--
			<div class="row">
				
			</div>
			<div class="row">
				<div class="col-12 col-sm-4">
					<div class="mb-2">
						<label>Especialidad Medico</label>
						<input type="text" class="form-control" v-model="obj.especialidadMedico" />
					</div>
				</div>
				<div class="col-12 col-sm-4">
					<div class="mb-2">
						<label>Nombre Medico</label>
						<input type="text" class="form-control" v-model="item.data.custom_fields.nombreApellidoMedico" />
					</div>
				</div>
				<div class="col-12 col-sm-4">
					<div class="mb-2">
						<label>NIT Medico</label>
						<input type="text" class="form-control" v-model="item.data.custom_fields.nitDocumentoMedico" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-12 col-sm-4">
					<div class="mb-2">
						<label>Nro Matricula Medico</label>
						<input type="text" class="form-control" v-model="item.data.custom_fields.nroMatriculaMedico" />
					</div>
				</div>
				<div class="col-12 col-sm-4">
					<div class="mb-2">
						<label>Nro. Factura Medico</label>
						<input type="text" class="form-control" v-model="item.data.custom_fields.nroFacturaMedico" />
					</div>
				</div>
			</div>
			-->
		</div>`,
		props: {
			invoice: {type: Object, required: true},
			item: {type: Object, required: true},
		},
		data()
		{
			return {};
		},
		mounted()
		{
			
		},
		created()
		{
			
		}
	};
})(SBFramework.Components.Siat);