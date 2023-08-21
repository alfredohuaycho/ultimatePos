(function(ns)
{
	ns.ComBranches = {
		template: `<div id="com-siat-branches">
			<h2>
				Sucursales 
				<button type="button" class="btn btn-primary" v-on:click="nuevo()">Nuevo</button>
			</h2>
			<template v-if="items.length > 0">
			<div class="panel panel-default card border shadow mb-2" v-for="(item, index) in items">
				<div class="panel-body card-body">
					<div class="row">
						<div class="col-12 col-sm-10">
							<div>ID: {{ item.id }}, Codigo: {{ item.code }}</div>
							<div>{{ item.name }}</div>
							<div>{{ item.address }}, {{ item.city }}</div>
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
								<label>Codigo</label>
								<input type="number" class="form-control" required v-model="s.code" />
							</div>
							<div class="mb-3">
								<label>Nombre Sucursal</label>
								<input type="text" class="form-control" required v-model="s.name">
							</div>
							<div class="mb-3">
								<label>Direccion</label>
								<input type="text" class="form-control" required v-model="s.address">
							</div>
							<div class="mb-3">
								<label>Ciudad</label>
								<input type="text" class="form-control" required v-model="s.city">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal" data-bs-dismiss="modal" data-coreui-dismiss="modal">Cerrar</button>
							<button type="button" class="btn btn-primary" v-on:click="guardar()">Guardar</button>
						</div>
					</form>
				</div>
			</div>
		</div>`,
		mixins: [SBFramework.Mixins.Common],
		data()
		{
			return {
				modal: null,
				items: [],
				s: {
					id: 0,
					code: '',
					name: '',
					address: '',
					city: '',
				},
				service: new SBFramework.Services.ServiceBranches(),
			};
		},
		methods: 
		{
			async getItems()
			{
				const res = await this.service.readAll();
				this.items = res.data;
			},
			nuevo()
			{
				this.openModal(this.modal);
			},
			async guardar()
			{
				try
				{
					if( isNaN(parseInt(this.s.code)) || parseInt(this.s.code) <= 0 )
						throw {error: 'El codigo de sucursal es invalido'};
					this.$root.$processing.show('Guardando datos...');
					const res = this.s.id > 0 ?
						await this.service.update(this.s) :
						await this.service.create(this.s);
					this.$root.$processing.hide();
					this.closeModal(this.modal);
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
					await this.service.remove( item.id );
					this.$root.$processing.hide();
					this.items.splice(index, 1);
					this.$root.$toast.ShowSuccess('Sucursal borrada');
				}
				catch(e)
				{
					console.log('ERROR', e);
					this.$root.$processing.hide();
					this.$root.$toast.ShowError('Ocurrio un error al borrar la sucursal');
				}
			}
		},
		mounted()
		{
			const frame = (window.bootstrap || window.coreui);
			if( frame )
			{
				this.modal = frame.Modal.getOrCreateInstance(this.$refs.modal);
			}
			else
			{
				this.modal = jQuery(this.$refs.modal);
			}
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