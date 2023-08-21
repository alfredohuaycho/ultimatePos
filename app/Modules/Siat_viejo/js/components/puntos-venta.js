(function(ns)
{
	ns.ComPuntosVenta = {
		template: `<div id="com-siat-puntos-venta">
			<h2>
				Puntos de Venta 
				<button type="button" class="btn btn-primary" v-on:click="nuevo()">Nuevo</button>
				<button type="button" class="btn btn-warning" v-on:click="sync()">Sincronizar</button>
			</h2>
			<template v-if="items.length > 0">
			<div class="card border shadow mb-2" v-for="(item, index) in items">
				<div class="card-body">
					<div class="row">
						<div class="col-12 col-sm-10">
							<div>ID: {{ item.id }}, Codigo: {{ item.codigo }}</div>
							<div>Tipo: {{ item.tipo }}</div>
							<div>{{ item.nombre }}</div>
							<div class="form-text text-muted">{{ item.creation_date }}</div>
						</div>
						<div class="col-12 col-sm-2">
							<!-- 
							<button type="button" class="btn btn-primary w-100 mb-1"><i class="fa fa-edit"></i> Editar</button>
							-->
							<button type="button" class="btn btn-danger w-100" v-on:click="borrar(item, index)"><i class="fa fa-trash"></i> Borrar</button>
						</div>
					</div>
				</div>
			</div>
			</template>
			<div v-else>
				<b class="text-primary">No se encontraron registros</b>
			</div>
			<div ref="modal" class="modal fade">
				<div class="modal-dialog">
					<form action="" method="" class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">Nuevo Punto de Venta</h5>
							<button class="btn-close" type="button" data-coreui-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="mb-3">
								<label>Sucursal</label>
								<select class="form-control form-select" required v-model="pv.sucursal_id">
									<option value="">-- sucursal --</option>
									<option value="0">Sucursal Principal 0 (por defecto)</option>
									<option v-bind:value="s.code" v-for="(s, si) in sucursales">{{ s.name }}</option>
								</select>
							</div>
							<div class="mb-3">
								<label>Tipo Punto de Venta</label>
								<select class="form-control form-select" required v-model="pv.tipo_id">
									<option value="">-- tipo --</option>
									<template v-for="(tipo, ti) in tipos">
									<option v-bind:value="tipo.codigoClasificador">{{ tipo.descripcion }}</option>
									</template>
								</select>
							</div>
							<div class="mb-3">
								<label>Nombre Punto de Venta</label>
								<input type="text" name="" value="" class="form-control" required v-model="pv.nombre" />
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal" data-coreui-dismiss="modal">Cerrar</button>
							<button type="button" class="btn btn-primary" v-on:click="guardar()">Guardar</button>
						</div>
					</form>
				</div>
			</div>
		</div>`,
		data()
		{
			return {
				modal: null,
				sucursales: [],
				items: [],
				tipos: [],
				pv: {
					sucursal_id: 0,
					tipo_id: '',
					tipo: '',
					nombre: ''
				}
			};
		},
		methods: 
		{
			async getItems()
			{
				const res = await this.$root.api.Get('/invoices/siat/v2/puntos-venta');
				this.items = res.data;
			},
			async getSucursales()
			{
				const res = await this.$root.api.Get('/invoices/siat/v2/branches');
				this.sucursales = res.data
			},
			async getTipos()
			{
				const res = await this.$root.api.Get('/invoices/siat/v2/sync-tipos-punto-venta');
				this.tipos = res.data.RespuestaListaParametricas.listaCodigos;	
			},
			nuevo()
			{
				this.getTipos();
				this.modal.show();
			},
			async guardar()
			{
				try
				{
					this.$root.$processing.show('Guardando datos...');
					for(let t of this.tipos)
					{
						if( t.codigoClasificador == this.pv.tipo_id )
						{
							this.pv.tipo = t.descripcion;
							break;
						}
					}
					const res = await this.$root.api.Post('/invoices/siat/v2/puntos-venta', this.pv);
					this.$root.$processing.hide();
					this.modal.hide();
					this.getItems();
				}	
				catch(e)
				{
					this.$root.$processing.hide();
					console.log('ERROR', e);
					this.$root.$toast.ShowError(e.error || e.message || 'Error desconocido');
				}
			},
			async sync()
			{
				try
				{
					this.$root.$processing.show('Sincronizando datos...');
					await this.$root.api.Get('/invoices/siat/v2/sync-puntos-venta');
					this.$root.$processing.hide();
					this.getItems();
				}
				catch(e)
				{
					this.$root.$processing.hide();
					console.log('ERROR', e);
				}
			},
			async borrar(item, index)
			{
				try
				{
					this.$root.$processing.show('Borrando datos...');
					await this.$root.api.Delete('/invoices/siat/v2/puntos-venta/' + item.id );
					this.$root.$processing.hide();
					this.items.splice(index, 1);
					this.$root.$toast.ShowSuccess('Punto de Venta borrado');
				}
				catch(e)
				{
					this.$root.$processing.hide();
					console.log('ERROR', e);
					this.$root.$toast.ShowError('Ocurrio un error al borrar el Punto de Venta');
				}
			}
		},
		mounted()
		{
			const frame = (window.bootstrap || window.coreui);
			this.modal = frame.Modal.getInstance(this.$refs.modal);
			if( !this.modal )
				this.modal = new frame.Modal(this.$refs.modal, {});
		},
		created()
		{
			this.getSucursales();
			this.getItems();
		}
	};
	SBFramework.AppComponents = {
		'siat-puntos-venta': ns.ComPuntosVenta, 
	};
})(SBFramework.Components.Siat);