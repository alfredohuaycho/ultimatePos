(function(ns)
{
	ns.InvoiceProducts = {
		template: `<div id="invoice-products-com" class="">
			<div class="row mb-2">
				<div class="col-6 col-sm-9"><h2>Lista de Productos</h2></div>
				<div class="col-6 col-sm-3"><button type="button" class="btn btn-primary w-100" v-on:click="newProd()">Nuevo Producto</button></div>
			</div>
			<div class="form-group mb-2">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="Buscar producto..." v-model="keyword" v-on:keyup.enter="search()" />
					<div class="input-group-btn">
						<button type="button" class="btn btn-primary" v-on:click="search()"><i class="fa fa-search"></i></button>
					</div>
				</div>
			</div>
			<div class="mb-1">Total productos: {{ total_productos }}</div>
			<div class="card shadow" v-for="(prod, pi) in products">
				<div class="card-body">
					<div class="row" >
						<div class="col-12 col-sm-9">
							<div class="mb-1">
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
				keyword: '',
				total_productos: 0,
				total_pages: 0,
				current_page: 0,
				lista_actividades: [],
				unidadesMedida: [],
				productosSin: [],
				products: [],
				product: null,
				modalForm: null,
				serviceInvoices: new SBFramework.Services.ServiceInvoices(),
				service: new SBFramework.Services.ServiceProducts()
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
				const res = await this.serviceInvoices.obtenerUnidadesMedida();
				this.unidadesMedida = res.data.RespuestaListaParametricas.listaCodigos;	
			},
			async getProductosSin()
			{
				const res = await this.serviceInvoices.obtenerProductosServicios();
				this.productosSin = res.data.RespuestaListaProductos.listaCodigos;
			},
			async getListaActividades()
			{
				const res = await this.serviceInvoices.obtenerActividades();
				this.lista_actividades = Array.isArray(res.data.RespuestaListaActividades.listaActividades) ?
					res.data.RespuestaListaActividades.listaActividades : [res.data.RespuestaListaActividades.listaActividades];
			},
			async getProducts(page)
			{
				page = page || 1;
				const res = await this.service.readAll(page);
				this.products = res.data;
				this.current_page = page;
				this.total_pages = parseInt(res.headers.get("total-pages"));
				this.total_productos = res.total_products;
			},
			openProductModal()
			{
				if( this.modalForm.modal )
				{
					this.modalForm.modal('show');
					return true;
				}
				this.modalForm.show();			
			},
			closeProductModal()
			{
				if( this.modalForm.hide )
				{
					this.modalForm.hide();
					return true;
				}
				this.modalForm.modal('hide');
			},
			newProd()
			{
				this.product = {codigo_sin: '', unidad_medida: ''};
				this.openProductModal();
			},
			productSaved()
			{
				this.product = null;
				//this.modalForm.hide();
				this.closeProductModal();
				this.getProducts();
			},
			edit(prod, index)
			{
				this.product = prod;
				//this.modalForm.show();
				this.openProductModal();
			},
			async remove(prod, index)
			{
				if( !confirm('Esta seguro de borrar el producto?\nLa accion no se puede deshacer.') )
					return false;
				try
				{
					this.$root.$processing.show('Guardando producto...');
					const res = await this.service.remove(prod.id);
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
			},
			async search()
			{
				try
				{
					this.products 		= [];
					const res 			= await this.service.search(this.keyword);
					this.products 		= res.data;
					//this.current_page 	= page;
					this.total_pages 	= parseInt(res.headers.get("total-pages"));
					this.total_productos = res.total_products;
				}	
				catch(e)
				{
					console.log('ERROR', e);
					this.$root.$toast.ShowError(e.error || e.message || 'Ocurrio un error al crear el producto');
				}
			}
		},
		mounted()
		{
			const frame = (window.bootstrap || window.coreui);
			if( frame )
			{
				this.modalForm = new frame.Modal(this.$refs.modalprod);
			}
			else
			{
				this.modalForm = jQuery(this.$refs.modalprod);
			}
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
