@inject('model', 'App\Modules\Siat\Models\SyncModel')
<?php
$unidades_medida = $model->getUnidadesMedidaS(0, 0);
$actividades = $model->getActividadesS(0, 0);
$productos_serv = $model->getProductosServiciosS(0, 0);
?>
<div class="box box-primary">
	<div class="box-header"><h5 class="box-title">Datos SIAT</h5></div>
	<div class="box-body">
		<div class="row">
			<div class="col-12 col-sm-4">
				<div class="form-group mb-3">
					<label>Unidad de Medida</label>
					<select name="unidad_medida" class="form-control" required>
						<option value="">-- unidad medida ---</option>
						@foreach($unidades_medida->RespuestaListaParametricas->listaCodigos as $um)
						<option value="{{ $um->codigoClasificador }}" {{ (isset($product) && $product->unidad_medida == $um->codigoClasificador) ? 'selected' : '' }}>
							{{ $um->descripcion }}
						</option>
						@endforeach
					</select>
				</div>
			</div>
			<div class="col-12 col-sm-4">
				<div class="form-group mb-3">
					<label>Actividad Economica</label>
					<select id="actividad_economica" name="actividad_economica" class="form-control" required>
						<option value="">-- actividad economica ---</option>
						@foreach($actividades->RespuestaListaActividades->listaActividades as $a)
						<option value="{{ $a->codigoCaeb }}" {{ (isset($product) && $product->actividad_economica == $a->codigoCaeb) ? 'selected' : '' }}>
							{{ $a->descripcion }}
						</option>
						@endforeach
					</select>
				</div>
			</div>
			<div class="col-12 col-sm-4">
				<div class="form-group mb-3">
					<label>Codigo Producto SIN</label>
					<select id="codigo_producto_sin" name="codigo_producto_sin" class="form-control" required>
						<option value="">-- codigo producto sin ---</option>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
(function()
{
	const productos_sin = <?php print json_encode($productos_serv->RespuestaListaProductos->listaCodigos); ?>;
	const dd_products = document.querySelector('#codigo_producto_sin');
	
	function filterProducts(actividad)
	{
		dd_products.innerHTML = '';
		for(let p of productos_sin)
		{
			if( p.codigoActividad != actividad )
				continue;
			let op = document.createElement('option');
			op.value = p.codigoProducto;
			op.innerHTML = p.descripcionProducto;
			dd_products.appendChild( op );
		}
	}
	document.querySelector('#actividad_economica').addEventListener('change', function()
	{
		const actividad = this.value;
		filterProducts(actividad);
	});
	@if( isset($product) && $product->actividad_economica )
	filterProducts({{ $product->actividad_economica }});
	dd_products.value = {{ $product->codigo_producto_sin }};
	@endif
})();
</script>