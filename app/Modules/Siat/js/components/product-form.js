(function(ns)
{
	ns.ProductForm = {
		template: `<div class="form-invoices">
			<form ref="form" novalidate>
				<div class="mb-3">
					<label>Codigo</label>
					<input type="text" name="" class="form-control" v-model="product.code" required />
				</div>
				<div class="mb-3">
					<label>Nombre</label>
					<input type="text" name="" class="form-control" v-model="product.name" required />
				</div>
				<div class="row">
					<div class="col-12 col-sm-6">
						<div class="mb-3">
							<label>Precio</label>
							<input type="text" name="" class="form-control" v-model="product.price" required />
						</div>
					</div>
					<div class="col-12 col-sm-6">
						<div class="mb-3">
							<label>Uniaded Medida</label>
							<select class="form-control form-select" required v-model="product.unidad_medida">
								<option value="">-- codigo medida --</option>
								<option v-for="(u, ui) in unidadesMedida" v-bind:value="u.codigoClasificador">
									{{ u.descripcion }}
								</option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="mb-3">
					<label>Descripcion</label>
					<textarea class="form-control" v-model="product.description"></textarea>
				</div>
				<div class="row">
					<div class="col-12 col-sm-4">
						<div class="mb-3">
							<label>Codigo de Barras</label>
							<input type="text" name="" class="form-control" v-model="product.barcode" />
						</div>
					</div>
					<div class="col-12 col-sm-4">
						<div class="mb-3">
							<label>Num. Serie</label>
							<input type="text" name="" class="form-control" v-model="product.numserie" />
						</div>
					</div>
					<div class="col-12 col-sm-4">
						<div class="mb-3">
							<label>Imei</label>
							<input type="text" name="" class="form-control" v-model="product.imei" />
						</div>
					</div>
				</div>
				<div class="mb-3">
					<label class="">Actividad Economica</label>
					<select class="form-control form-select" required v-model="codigo_actividad">
						<option value="">-- actividad economica --</option>
						<option v-for="(ae, spi) in actividades" v-bind:value="ae.codigoCaeb">
							{{ ae.descripcion }}
						</option>
					</select>
				</div>
				<div class="mb-3">
					<label class="">Producto SIN</label>
					<select class="form-control form-select" required v-model="codigo_sin">
						<option value="">-- producto SIN --</option>
						<template v-for="(sp, spi) in productos">
							<option v-bind:value="sp.codigoProducto">
								{{ sp.descripcionProducto }}
							</option>
						</template>
					</select>
				</div>
				<div class="mb-3">
					<button type="button" class="btn btn-danger" 
						data-dismiss="modal" data-bs-dismiss="modal" data-coreui-dismiss="modal">Cancelar</button>
					<button type="button" class="btn btn-primary" v-on:click="save()">Guardar</button>
				</div>
			</form>
		</div>`,
		props: {
			unidadesMedida: {type: Array, required: true},
			actividades: {type: Array, required: true},
			productosSin: {type: Array, required: true},
			product: {type: Object, required: false},
			
		},
		data()
		{
			return {
				productos: [],
				codigo_actividad: '',
				codigo_sin: '',
			};	
		},
		watch: 
		{
			codigo_actividad()
			{
				this.codigo_sin = '';
				this.filterProducts();
			},
		},
		methods: 
		{
			filterProducts()
			{
				this.productos = [];
				if( !this.codigo_actividad )
				{
					return;
				}	
				this.productos = [];
				for(let p of this.productosSin)
				{
					if( p.codigoActividad == this.codigo_actividad )
						this.productos.push(p);
				}
			},
			async save()
			{
				try
				{
					this.$refs.form.classList.remove('was-validated');
					if( !this.$refs.form.checkValidity() )
					{
						this.$refs.form.classList.add('was-validated');
						return;
					}
					this.product.codigo_actividad = this.codigo_actividad;
					this.product.codigo_sin = this.codigo_sin;
					this.$root.$processing.show('Guardando producto...');
					const res = this.product.id > 0 ? 
						await this.$parent.service.update(this.product) : 
						await this.$parent.service.create(this.product);
					Object.assign(this.product, res.data);
					this.$root.$processing.hide();
					this.$root.$toast.ShowSuccess('Product guardado correctamente!!!');
					this.$emit('product-saved', this.product);
				}
				catch(e)
				{
					this.$root.$processing.hide();
					console.log(e);
					this.$root.$toast.ShowError(e.error || e.message || 'Ocurrio un error al crear el producto');
				}
			}
		},
		mounted()
		{
			
			
			
		},
		created()
		{
			this.codigo_actividad 	= this.product.codigo_actividad ? this.product.codigo_actividad.toString() : '';
			this.filterProducts();
			setTimeout(() => 
			{
				this.codigo_sin = this.product.codigo_sin ? this.product.codigo_sin.toString() : '';
				console.log(this.codigo_actividad, this.codigo_sin);
			}, 600);
		}
	};
})(SBFramework.Components);
