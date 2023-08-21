(function(ns)
{
	ns.DetalleHotel = {
		removeFields: ['numero_serie', 'imei'],
		template: `<div class="hotel-detalle">
			<div class="row">
				<div class="col-6 col-sm-2">
					<div class="mb-2">
						<label>Nro. Huespedes</label>
						<input type="number" min="1" class="form-control" value="1" v-model="invoice.data.custom_fields.cantidadHuespedes" />
					</div>
				</div>
				<div class="col-6 col-sm-2">
					<div class="mb-2">
						<label>Nro. Habitaciones</label>
						<input type="number" min="1" class="form-control" value="1" v-model="invoice.data.custom_fields.cantidadHabitaciones" />
					</div>
				</div>
				<div class="col-6 col-sm-2">
					<div class="mb-2">
						<label>Nro Adultos</label>
						<input type="number" min="1" value="1" class="form-control" v-model="invoice.data.custom_fields.cantidadMayores" />
					</div>
				</div>
				<div class="col-6 col-sm-2">
					<div class="mb-2">
						<label>Nro Menores</label>
						<input type="number" min="0" value="0" class="form-control" v-model="invoice.data.custom_fields.cantidadMenores" />
					</div>
				</div>
				<div class="col-12 col-sm-2">
					<div class="mb-2">
						<label>Fecha Ingreso</label>
						<input type="date" class="form-control" required v-model="fecha_ingreso" />
					</div>
				</div>
				<div class="col-12 col-sm-2">
					<div class="mb-2">
						<label>Hora Ingreso</label>
						<input type="time" class="form-control" v-model="hora_ingreso" />
					</div>
				</div>
			</div>
		</div>`,
		props: {
			invoice: {type: Object, required: true},
		},
		watch: {
			fecha_ingreso()
			{
				console.log('fecha_ingreso', this.fecha_ingreso);
			},
			hora_ingreso()
			{
				console.log('hora_ingreso', this.hora_ingreso);
			}
		},
		data()
		{
			return {
				fecha_ingreso: sb_formatdate(new Date(), 'Y-m-d'),
				hora_ingreso: sb_formatdate(new Date(), 'H:i') + ':00.00',
			};
		},
		methods:
		{
			getFechaHoraIngreso()
			{
				let date = new Date(this.fecha_ingreso + ' ' + this.hora_ingreso);
				console.log('fechaHoraIngreso', date);
				return date;
			}
		},
		mounted()
		{
			this.fecha_ingreso = sb_formatdate(new Date(), 'Y-m-d');
			this.hora_ingreso = sb_formatdate(new Date(), 'H:i') + ':00.00';
		},
		created()
		{
			
		}
	};
	ns.ItemHotel = {
		template: `<div>
			<div class="row">
				<div class="col-12 col-sm-4">
					<div class="mb-2">
						<label>Cod. Tipo Habitacion</label>
						<input type="number" min="1" max="16" class="form-control" v-model="item.data.custom_fields.codigoTipoHabitacion" />
					</div>
				</div>
				<div class="col-12 col-sm-4">
					<div class="mb-2">
						<label>Detalle Huespedes</label>
						<textarea cols="5" class="form-control" v-model="item.data.custom_fields.detalleHuespedes"></textarea>
					</div>
				</div>
			</div>
		</div>`,
		props: {
			invoice: {type: Object, required: true},
			item: {type: Object, required: true},
		},
		mounted()
		{
			this.item.data.custom_fields.codigoTipoHabitacion = 0;
		},
		created()
		{
			
		}
	};
})(SBFramework.Components.Siat);