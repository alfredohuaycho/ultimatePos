(function(ns)
{
	ns.InvoiceListing = {
		template: `<div id="com-siat-invoice-listing">
			<h2>Listado de Facturas</h2>
			<div class="form-group mb-2">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="Buscar factura..." v-model="keyword" />
					<div class="input-group-btn">
						<button type="button" class="btn btn-primary" v-on:click="search()"><i class="fa fa-search"></i></button>
					</div>
				</div>
			</div>
			<pager v-if="total_pages > 1" 
				v-bind:currentPage="current_page" 
				v-bind:totalPages="total_pages" 
				v-on:pager-change-page="changePage" 
				v-on:pager-previous-page="prevPage"
				v-on:pager-next-page="nextPage" />
			<div class="panel card border shadow" v-for="(invoice, index) in items">
				<div class="card-body">
					<div class="container-fluid">
						<div class="row">
							<div class="col-12 col-sm-7">
								<div>
									<span class="border rounded p-2 bg-primary text-white">ID: {{ invoice.id }}</span>
									<span class="border rounded p-2 bg-info text-white">Factura Nro: {{ invoice.invoice_number }}</span>
									<span class="border rounded p-2 bg-warning text-white" v-if="invoice.evento_id">
										<b>Evento:</b> {{ invoice.evento_id }}
									</span>
								</div>
								<div><b>Cliente:</b> {{ invoice.customer }}</div>
								<div><b>Punto Venta:</b> {{ invoice.punto_venta }}</div>
								<div><b>Fecha emision:</b> {{ invoice.invoice_datetime }}</div>
								<div><b>CUF:</b> {{ invoice.cuf }}</div>
								<div>
									<span class="badge" 
										v-bind:class="{'bg-success': invoice.status == 'issued', 'bg-danger': invoice.status == 'error', 'bg-warning': invoice.status == 'void'}">
										{{ getStatus(invoice.status) }}
									</span>
								</div>
							</div>
							<div class="col-12 col-sm-3">
								<div><b>Sector:</b> {{ invoice.codigo_documento_sector }}</div>
								<div><b>Impuesto:</b> {{ invoice.tax.toFixed(2) }}</div>
								<div><b>Total:</b> {{ invoice.total.toFixed(2) }}</div>
							</div>
							<div class="col-12 col-sm-2">
								<a v-bind:href="viewUrl(invoice)" target="_blank" class="btn btn-sm btn-warning w-100 mb-1 btn-block">Imprimir</a>
								<a v-bind:href="viewUrl(invoice) + '?tpl=rollo'" target="_blank" class="btn btn-sm btn-warning w-100 mb-1 btn-block">Imprimir Ticket</a>
								<template v-if="invoice.siat_id && invoice.siat_url">
									<a v-bind:href="invoice.siat_url" target="_blank" class="btn btn-sm btn-info w-100 mb-1 btn-block">Siat Url</a>
								</template>
								<!--
								<a href="javascript:;" class="btn btn-sm btn-primary w-100 mb-1">Editar</a>
								-->
								<template v-if="invoice.status == 'ISSUED'">
									<a href="javascript:;" class="btn btn-sm btn-danger w-100 mb-1 btn-block" v-on:click="anular(invoice, index)">Anular</a>
								</template>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="mt-2 mb-2">
				<pager v-if="total_pages > 1" 
					v-bind:currentPage="current_page" 
					v-bind:totalPages="total_pages" 
					v-on:pager-change-page="changePage" 
					v-on:pager-previous-page="prevPage"
					v-on:pager-next-page="nextPage" />
			</div>
			<div ref="modalvoid" class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">Anular Factura</h5>
						</div>
						<div class="modal-body">
							<template v-if="currentInvoice">
								<siat-void-invoice ref="comvoid" v-bind:invoice="currentInvoice"
									v-on:void-success="onVoidSuccess" />
							</template>
						</div>
						<div class="modal-footer">
							<template v-if="!processingVoid">
								<button type="button" class="btn btn-danger" data-dismiss="modal" data-bs-dismiss="modal" data-coreui-dismiss="modal">Cerrar</button>
								<button type="button" class="btn btn-primary" v-on:click="submit($event)">Anular Factura</button>
							</template>
							<template v-else>
								<span class="spinner-border text-primary" role="status">
								  <span class="visually-hidden">Loading...</span>
								</span>
								Procesando...
							</template>
						</div>
					</div>
				</div>
			</div>
		</div>`,
		components: {
			'pager': SBFramework.Components.ComPager,
			'siat-void-invoice': ns.VoidInvoice,
		},
		data()
		{
			return {
				keyword: '',
				total_pages: 0,
				current_page: 0,
				statuses: {
					'ISSUED': 'Emitida',
					'ERROR': 'Error',
					'VOID': 'Anulada',
				},
				currentInvoice: null,
				items: [],
				modalVoid: null,
				processingVoid: false,
				service: new SBFramework.Services.ServiceInvoices(),
			};	
		},
		methods:
		{
			viewUrl(invoice)
			{
				return lt.baseurl + '/siat/facturas/'+ invoice.id  +'/view';
			},
			changePage(page)
			{
				this.getInvoices(page);
			},
			prevPage(page)
			{
				this.getInvoices(page);
			},
			nextPage(page)
			{
				this.getInvoices(page);
			},
			async getInvoices(page)
			{
				const res = await this.service.obtenerFacturas(page);
				this.items = res.data;
				this.current_page = page;
				this.total_pages = parseInt(res.headers.get("total-pages"));
			},
			getStatus(status)
			{
				return this.statuses[status] || 'Desconocido';
			},
			anular(invoice, index)
			{
				this.currentInvoice = invoice;
				//setTimeout(() => {this.modalVoid.show();}, 1000)
				this.modalVoid.modal('show');
			},
			async submit($event)
			{
				try
				{
					this.processingVoid = true;
					await this.$refs.comvoid.submit();
					this.processingVoid = false;
				}
				catch(e)
				{
					this.processingVoid = false;
				}
			},
			onVoidSuccess(xhr_res)
			{
				this.modalVoid.modal('hide');
				this.currentInvoice = null;
				let invoice = this.items.find((inv) => inv.invoice_id == xhr_res.data.invoice_id );
				if( !invoice )
					return false;
				invoice = xhr_res.data;
				this.$root.$toast.ShowSuccess('La factura fue anulada correctamente');
				this.getInvoices();
			},
			async search()
			{
				try
				{
					const res = await this.service.buscar(this.keyword);
					this.items = res.data;
					this.current_page 	= 1;
					this.total_pages	= 1;
				}
				catch(e)
				{
					alert(e.error || e.message || 'Error desconocido');
				}
			}
		},
		async mounted()
		{
			const frame = (window.bootstrap || window.coreui);
			if( frame )
			{
				this.modalVoid = frame.Modal.getInstance(this.$refs.modalvoid);
				if( !this.modalVoid )
					this.modalVoid = new frame.Modal(this.$refs.modalvoid, {});
			}
			else
			{
				this.modalVoid = jQuery(this.$refs.modalvoid);
			}
			
				
			this.$root.$processing.show('Obteniendo datos...');
			await Promise.all([this.getInvoices(1)]);
			this.$root.$processing.hide();
		},
		async created()
		{
			
			
		}
	};
	SBFramework.AppComponents = {
		'siat-invoice-listing': ns.InvoiceListing, 
	};
})(SBFramework.Components.Siat);