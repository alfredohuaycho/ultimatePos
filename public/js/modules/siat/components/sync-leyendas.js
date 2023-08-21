(function(ns)
{
	ns.ComSyncLeyendas = {
		template: `<div id="com-sync-leyendas">
			<div class="mb-3"><button type="button" class="btn btn-primary" v-on:click="getData()">Sincronizar</button></div>
			<div class="table-responsive">
				<table class="table table-sm table-striped">
				<thead>
				<tr>
					<th>Nro</th>
					<th>Codigo Actividad</th>
					<th>Descripcion</th>
				</tr>
				</thead>
				<tbody>
				<tr v-for="(item, index) in lista">
					<td>{{ index + 1 }}</td>
					<td>{{ item.codigoActividad }}</td>
					<td>{{ item.descripcionLeyenda }}</td>
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
				const res = await this.$parent.service.obtenerLeyendas();
				this.lista = res.data.RespuestaListaParametricasLeyendas.listaLeyendas;
			}
		},
		created()
		{
			this.getData();
		}
	};
})(SBFramework.Components.Siat);