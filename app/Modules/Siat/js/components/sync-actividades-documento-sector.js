(function(ns)
{
	ns.ComSyncActividadesDocumentoSector = {
		template: `<div id="com-sync-actividades">
			<div class="mb-3"><button type="button" class="btn btn-primary" v-on:click="getData()">Sincronizar</button></div>
			<div class="table-responsive">
				<table class="table table-sm">
				<thead>
				<tr>
					<th>Nro</th>
					<th>Codigo Actividad</th>
					<th>Cod. Doc. Sector</th>
					<th>Tipo Doc. Sector</th>
				</tr>
				</thead>
				<tbody>
				<tr v-for="(item, index) in lista">
					<td>{{ index + 1 }}</td>
					<td>{{ item.codigoActividad }}</td>
					<td>{{ item.codigoDocumentoSector }}</td>
					<td>{{ item.tipoDocumentoSector  }}</td>
				</tr>
				</tbody>
				</table>
			</div>
		</div>`,
		data()
		{
			return {
				lista: []
			};	
		},
		methods: 
		{
			async getData()
			{
				const res = await this.$parent.service.obtenerActividadesDocumentoSector();
				
				this.lista = res.data.RespuestaListaActividadesDocumentoSector.listaActividadesDocumentoSector; 
			}
		},
		mounted()
		{
			
		},
		created()
		{
			this.getData();
		}
	};
})(SBFramework.Components.Siat);