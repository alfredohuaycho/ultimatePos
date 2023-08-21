(function(ns)
{
	ns.CufdListing = {
		template: `<div id="com-siat-cufd-listing" class="container-fluid">
			<h2>Listado de CUFDs</h2>
			<div class="row">
				<div class="col-12 col-sm-4">
					<div class="mb-2">
						<select class="form-control form-select" v-model="filter.sucursal">
							<option value="">-- sucursal ---</option>
							<option value="0">Sucursal Principal 0 (por defecto)</option>
							<option v-bind:value="s.code" v-for="(s, si) in sucursales">{{ s.name }}</option>
						</select>
					</div>
				</div>
				<div class="col-12 col-sm-3">
					<div class="mb-2">
						<select class="form-control form-select" v-model="filter.puntoventa">
							<option value="">-- punto de venta --</option>
							<option value="0">Punto de Venta 0 (por defecto)</option>
							<option v-for="(pv, ipv) in puntosventa" v-bind:value="pv.codigo">({{ pv.codigo }}) {{ pv.nombre }}</option>
						</select>
					</div>
				</div>
				<div class="col-12 col-sm-3">
					<div class="mb-2">
						<button type="button" class="btn btn-primary" v-on:click="dofilter()">Filtrar</button>
					</div>
				</div>
			</div>
			<div class="panel card border shadow" v-for="(item, index) in items">
				<div class="panel-body card-body">
					<div class="container-fluid">
						<div class="row">
							<div class="col-12 col-sm-7">
								<div><b>ID:</b> {{ item.id }}</div>
								<div><b>Codigo:</b> {{ item.codigo }}</div>
								<div><b>Codigo Control:</b> {{ item.codigo_control }}</div>
								<div><b>Direccion:</b> {{ item.direccion }}</div>
							</div>
							<div class="col-12 col-sm-3">
								<div><b>Sucursal:</b> {{ item.codigo_sucursal }}</div>
								<div><b>Punto de Venta:</b> {{ item.codigo_puntoventa }}</div>
							</div>
							<div class="col-12 col-sm-2">
								<div><b>Fecha creacion:</b> {{ item.created_at }}</div>
								<div><b>Fecha vigencia:</b> {{ item.fecha_vigencia }}</div>
								<!--
								<div>
									<span class="badge" 
										v-bind:class="{'bg-success': item.status == 'active', 'bg-danger': invoice.status != 'active'}">
										{{ getStatus(invoice.status) }}
									</span>
								</div>
								-->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>`,
		components: {
		},
		data()
		{
			return {
				service: new SBFramework.Services.ServiceInvoices(),
				statuses: {
					'issued': 'Emitida',
					'error': 'Error',
					'void': 'Anulada',
				},
				sucursales: [],
				puntosventa: [],
				items: [],
				filter: {
					sucursal: 0,
					puntoventa: 0,
				}
			};	
		},
		methods:
		{
			async getSucursales()
			{
				const res = await this.service.obtenerSucursales();
				this.sucursales = res.data
			},
			async dofilter()
			{
				try
				{
					const res = await this.service.obtenerCufds(this.filter.sucursal, this.filter.puntoventa);
					this.items = res.data;
				}
				catch(e)
				{
					alert(e);
				}
			},
			async getPuntosVenta()
			{
				const res = await this.service.obtenerPuntosVenta();
				this.puntosventa = res.data;
			},
		},
		async mounted()
		{
			const frame = (window.bootstrap || window.coreui);
		},
		async created()
		{
			this.getSucursales();
			this.getPuntosVenta();
			this.dofilter();
		}
	};
	SBFramework.AppComponents = {
		'siat-cufd-listing': ns.CufdListing, 
	};
})(SBFramework.Components.Siat);