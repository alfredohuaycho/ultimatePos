(function(ns)
{
	ns.ComSyncCodigos = {
		template: `<div id="com-sync-codigos">
			<div class="mb-3"><button type="button" class="btn btn-primary">Sincronizar</button></div>
			<div class="row">
				<div class="col-12 col-sm-6">
					<h3>CUIS</h3>
					<div class="mb-3">
						<button type="button" class="btn btn-primary w-100" v-on:click="obtenerCuis(true)">Obtener codigo</button>
					</div>
					<div class="mb-3">
						<input type="text" name="" v-bind:value="cuis.codigo" class="form-control" />
					</div>
				</div>
				<div class="col-12 col-sm-6">
					<h3>CUFD</h3>
					<div class="mb-3">
						<button type="button" class="btn btn-primary w-100"  v-on:click="obtenerCufd(true)">Obtener codigo (Renovar)</button>
					</div>
					<div class="mb-3">
						<label>Cufd</label>
						<input type="text" name="" v-bind:value="cufd.codigo" class="form-control" />
					</div>
					<div class="mb-3">
						<label>Codigo Control</label>
						<input type="text" name="" v-bind:value="cufd.codigo_control" class="form-control" />
					</div>
					<div class="mb-3">
						<label>Fecha Expiracion</label>
						<input type="text" name="" v-bind:value="cufd.fecha_vigencia" class="form-control" />
					</div>
					<div class="mb-3">
						<label>Direccion</label>
						<input type="text" name="" v-bind:value="cufd.direccion" class="form-control" />
					</div>
				</div>
			</div>
		</div>`,
		props: {
			sucursal: {type: Number, required: false, default: 0},
			puntoventa: {type: Number, required: false, default: 0},
		},
		data()
		{
			return {
				cuis: {},
				cufd: {},
			};	
		},
		methods: 
		{
			setSucursal(s)
			{
				this.sucursal = s;
			},
			setPuntoVenta(pv)
			{
				this.puntoventa = pv;
			},
			async obtenerCuis(renew)
			{
				try
				{
					this.$root.$processing.show('Obtenido datos...');
					const res = await this.$parent.service.obtenerCuis(renew);
					this.$root.$processing.hide();
					this.cuis = res.data;
				}
				catch(e)
				{
					this.$root.$processing.hide();
					alert(e.error || e.message || 'Error desconocido');
				}
				
			},
			async obtenerCufd(renew)
			{
				try
				{
					this.$root.$processing.show('Obtenido datos...');
					const res = await this.$parent.service.obtenerCufd(this.sucursal, this.puntoventa, renew);
					this.$root.$processing.hide();
					this.cufd = res.data;
				}
				catch(e)
				{
					this.$root.$processing.hide();
					alert(e.error || e.message || 'Error desconocido');
				}
			},
			async sync()
			{
				
			}
		},
		mounted()
		{
			
		},
		created()
		{
			this.obtenerCuis();
			this.obtenerCufd();
		}
	};
})(SBFramework.Components.Siat);