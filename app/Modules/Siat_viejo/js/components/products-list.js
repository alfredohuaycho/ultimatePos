(function(ns)
{
	ns.InvoiceProducts = {
		template: `<div id="invoice-products-com" class="">
			<div class="row mb-2">
				<div class="col-6 col-sm-9"><h2>Lista de Productos</h2></div>
				<div class="col-6 col-sm-3"><button type="button" class="btn btn-primary w-100" v-on:click="newProd()">Nuevo Producto</button></div>
			</div>
			<div class="card shadow" v-for="(prod, pi) in products">
				<div class="card-body">
					<div class="row" >
						<div class="col-12 col-sm-9">
							<div class="">
								<span class="border rounded p-2 bg-secondary text-white">ID: {{ prod.id }}</span> 
								<span class="border rounded p-2 bg-secondary text-white">Codigo: {{ prod.code }}</span>
								<span class="border rounded p-2 bg-success text-white">Codigo SIN: {{ prod.codigo_sin }}</span>
							</div>
							<div class="list-group-item">{{ prod.code }} {{ prod.name }}</div>
							<div class="list-group-item"><b>Precio:</b> {{ prod.price }}</div>
						</div>
						<div class="col-12 col-sm-3">
							<button type="button" class="btn btn-primary w-100 mb-1 btn-sm" v-on:click="edit(prod, pi)">Editar</button>
							<button type="button" class="btn btn-danger w-100 mb-1 btn-sm" v-on:click="remove(prod, pi)">Borrar</button>
						</div>
					</div>
				</div>
			</div>
			<pager v-if="total_pages > 1" 
				v-bind:currentPage="current_page" 
				v-bind:totalPages="total_pages" 
				v-on:pager-change-page="changePage" 
				v-on:pager-previous-page="prevPage"
				v-on:pager-next-page="nextPage" />
			<div ref="modalprod" class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header"><h5>Información del Producto</h5></div>
						<div class="modal-body">
							<template v-if="product">
								<invoice-product-form v-bind:product="product" 
									v-bind:productosSin="productosSin" 
									v-bind:unidadesMedida="unidadesMedida"
									v-bind:actividades="lista_actividades"
									v-on:product-saved="productSaved" />
							</template>
						</div>
					</div>
				</div>
			</div>
		</div>`,
		components: {
			'pager': SBFramework.Components.ComPager,
			'invoice-product-form': ns.ProductForm,
		},
		data()
		{
			return {
				total_pages: 0,
				current_page: 0,
				lista_actividades: [],
				unidadesMedida: [],
				productosSin: [],
				products: [],
				product: null,
				modalForm: null,
			};
		},
		methods: 
		{
			changePage(page)
			{
				this.getProducts(page);
			},
			prevPage(page)
			{
				this.getProducts(page);
			},
			nextPage(page)
			{
				this.getProducts(page);
			},
			async getUnidadesMedida()
			{
				const res = await this.$root.api.Get('/invoices/siat/v2/sync-unidades-medida');
				this.unidadesMedida = res.data.RespuestaListaParametricas.listaCodigos;	
			},
			async getProductosSin()
			{
				const res = await this.$root.api.Get('/invoices/siat/v2/lista-productos-servicios');
				this.productosSin = res.data.RespuestaListaProductos.listaCodigos;
			},
			async getListaActividades()
			{
				const res = await this.$root.api.Get('/invoices/siat/v2/actividades');
				this.lista_actividades = Array.isArray(res.data.RespuestaListaActividades.listaActividades) ?
					res.data.RespuestaListaActividades.listaActividades : [res.data.RespuestaListaActividades.listaActividades];
			},
			async getProducts(page)
			{
				page = page || 1;
				const res = await this.$root.api.Get(`/invoices/products?page=${page}`);
				this.products = res.data;
				this.current_page = page;
				this.total_pages = parseInt(res.headers.get("total-pages"));
			},
			newProd()
			{
				this.product = {codigo_sin: '', unidad_medida: ''};
				this.modalForm.show();
			},
			productSaved()
			{
				this.product = null;
				this.modalForm.hide();
				this.getProducts();
			},
			edit(prod, index)
			{
				this.product = prod;
				this.modalForm.show();	
			},
			async remove(prod, index)
			{
				if( !confirm('Esta seguro de borrar el producto?\nLa accion no se puede deshacer.') )
					return false;
				try
				{
					this.$root.$processing.show('Guardando producto...');
					const res = await this.$root.api.Delete(`/invoices/products/${prod.id}`);
					//this.products.splice(index, 1);
					this.getProducts(this.current_page);
					this.$root.$processing.hide();
					this.$root.$toast.ShowSuccess('Producto borrado!!!');
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
			const frame = (window.bootstrap || window.coreui);
			this.modalForm = new frame.Modal(this.$refs.modalprod);
			this.$refs.modalprod.addEventListener('hidden.coreui.modal', (event) => {
				this.product = null;
			});

		},
		created()
		{
			this.getListaActividades();
			this.getUnidadesMedida();
			this.getProductosSin();
			this.getProducts();
		}
	};
	SBFramework.AppComponents = {
		'siat-products-list': ns.InvoiceProducts, 
	};
})(SBFramework.Components);