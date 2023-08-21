(function(ns)
{
	ns.ComBranches = {
		template: `<div id="com-siat-branches">
			<h2>
				Sucursales 
				<button type="button" class="btn btn-primary" v-on:click="nuevo()">Nuevo</button>
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
					<form action="" method="" class="modal-content" ref="form">
						<div class="modal-header">
							<h5 class="modal-title">Nueva Sucursal</h5>
							<button class="btn-close" type="button" data-coreui-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="mb-3">
								<label>Nombre Sucursal</label>
								<input type="text" class="form-control" required v-model="s.name">
							</div>
							<div class="mb-3">
								<label>Codigo</label>
								<input type="number" class="form-control" required v-model="s.code" />
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
				items: [],
				s: {
					id: 0,
					code: '',
					name: '',
					address: ''
				}
			};
		},
		methods: 
		{
			async getItems()
			{
				const res = await this.$root.api.Get('/invoices/siat/v2/branches');
				this.items = res.data;
			},
			nuevo()
			{
				this.modal.show();
			},
			async guardar()
			{
				try
				{
					if( isNaN(parseInt(this.s.code)) || parseInt(this.s.code) <= 0 )
						throw {error: 'El codigo de sucursal es invalido'};
					this.$root.$processing.show('Guardando datos...');
					const res = await this.$root.api.Post('/invoices/siat/v2/branches', this.s);
					this.$root.$processing.hide();
					this.modal.hide();
					this.getItems();
					this.$refs.form.reset();
				}	
				catch(e)
				{
					this.$root.$processing.hide();
					console.log('ERROR', e);
					this.$root.$toast.ShowError(e.error || e.message || 'Error desconocido');
				}
			},
			async borrar(item, index)
			{
				try
				{
					this.$root.$processing.show('Borrando datos...');
					await this.$root.api.Delete('/invoices/siat/v2/branches/' + item.id );
					this.$root.$processing.hide();
					this.items.splice(index, 1);
					this.$root.$toast.ShowSuccess('Sucursal borrada');
				}
				catch(e)
				{
					this.$root.$processing.hide();
					console.log('ERROR', e);
					this.$root.$toast.ShowError('Ocurrio un error al borrar la sucursal');
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
			this.getItems();
		}
	};
	SBFramework.AppComponents = {
		'siat-branches': ns.ComBranches, 
	};
})(SBFramework.Components.Siat);