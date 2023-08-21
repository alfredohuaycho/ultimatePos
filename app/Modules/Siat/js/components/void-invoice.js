(function(ns)
{
	ns.VoidInvoice = {
		template: `<div id="com-siat-void-invoice">
			<form ref="form" class="" novalidate>
				<div class="row">
					<div class="col-12 col-sm-6">
						<div class="mb-3">
							<label>Cliente</label>
							<input type="text" readonly class="form-control" v-bind:value="invoice.customer" />
						</div>
					</div>
					<div class="col-12 col-sm-6">
						<div class="mb-3">
							<label>Nro Factura</label>
							<input type="text" readonly class="form-control" v-bind:value="invoice.invoice_number" />
						</div>
					</div>
					<div class="col-12 col-sm-6">
						<div class="mb-3">
							<label>Fecha emision</label>
							<input type="text" readonly class="form-control" v-bind:value="invoice.invoice_datetime" />
						</div>
					</div>
					<div class="col-12 col-sm-6">
						<div class="mb-3">
							<label>Punto de Venta</label>
							<input type="text" readonly class="form-control" v-bind:value="invoice.codigo_puntoventa" />
						</div>
					</div>
					<div class="col-12 col-sm-6">
						<div class="mb-3">
							<label>Monto</label>
							<input type="text" readonly class="form-control" v-bind:value="invoice.total" />
						</div>
					</div>
				</div>
				<div class="mb-3">
					<label>CUF</label>
					<input type="text" readonly class="form-control" v-bind:value="invoice.cuf" />
				</div>
				<div class="mb-3">
					<label>Motivo anulacion</label>
					<select class="form-control form-select" required v-model="obj.motivo_id" pattern="[1-9]+">
						<option value="0">-- motivo anulacion --</option>
						<template v-for="(m, index) in motivos">
							<option v-bind:value="m.codigoClasificador">{{ m.descripcion }}</option>
						</template>
					</select>
				</div>
			</form>
		</div>`,
		props: {
			invoice: {type: Object, required: true},
		},
		data()
		{
			return {
				obj: {
					invoice_id: 0,
					motivo_id: 0,
				},
				motivos: [],
			};
		},
		methods: 
		{
			async getMotivos()
			{
				
				const res = await this.$parent.service.obtenerMotivosAnulacion();
				this.motivos = res.data.RespuestaListaParametricas.listaCodigos;
			},
			async submit()
			{
				this.$refs.form.classList.remove('was-validated');
				try
				{
					if( !this.$refs.form.checkValidity() )
					{
						this.$refs.form.classList.add('was-validated');
						return;
					}
					if( this.obj.motivo_id <= 0)
						throw {error: 'Debe seleccionar un motivo para la anulacion'};
					if( this.obj.invoice_id <= 0)
						throw {error: 'Identificador de factura invalido'};
					const res = await this.$parent.service.anular(this.invoice.id, this.obj);
					this.$emit('void-success', res);
					
				}
				catch(e)
				{
					alert(e.error || e.message || 'Ocurrio un error al anular la factura');
				}
			}
		},
		mounted()
		{
			
		},
		created()
		{
			//console.log('VoidInvoice', this.invoice);
			this.obj.invoice_id = this.invoice.id;
			this.getMotivos();
		}
	};
})(SBFramework.Components.Siat);