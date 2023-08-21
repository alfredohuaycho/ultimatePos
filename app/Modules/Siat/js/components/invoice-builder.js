(function(ns)
{
	const SiatInvoiceBuilder = {
		template: `<div id="com-siat-invoice-builder">
			<div v-if="!cuis || !cufd">
				Debe obtener el codigo CUIS y CUFD desde las pruebas generales para poder construir una factura
			</div>
			<form v-else>
				<div class="container-fluid">
					<div class="row">
						<template v-for="(val, key) in invoice">
							<div class="col-12 col-sm-6" v-if="exclude.indexOf(key) == -1">
								<div class="mb-2">
									<label>{{ key }}</label>
									<input type="text" v-model="invoice[key]" class="form-control" required />
								</div>
							</div>
						</template>
					</div>
				</div>
			</form>
		</div>`,
		props: {
			cuis: {type: String, required: true},
			cufd: {type: String, required: true},
			nit: {type: String, required: true},
		},
		data()
		{
			return {
				exclude: [
					'municipio', 'telefono', 'cuf', 'cufd', 'codigoSucursal', 'direccion', 'codigoPuntoVenta', 'fechaEmision', 'complemento', 'numeroTarjeta',
					'montoGiftCard', 'descuentoAdicional', 'codigoExcepcion', 'cafc', 'tipoCambio', 'montoTotalMoneda', 'leyenda', 'usuario',
					'descripcion', 'unidadMedida', 'montoDescuento', 'numeroSerie', 'numeroImei'
				],
				invoice: {
					nitEmisor: this.nit,
					razonSocialEmisor: '',
					municipio: '',
					telefono: '',
					numeroFactura: Math.floor(Math.random(1, 100) * 10),
					cuf: '',
					cufd: '',
					codigoSucursal: 0,
					direccion: '',
					codigoPuntoVenta: 0,
					fechaEmision: '',
					nombreRazonSocial: '',
					codigoTipoDocumentoidentidad: '',
					numeroDocumento: '',
					complemento: '',
					codigoCliente: '',
					codigoMetodoPago: '',
					numeroTarjeta: '',
					montoTotal: 1,
					montoTotalSujetoIva: '',
					montoGiftCard: 0,
					descuentoAdicional: '',
					codigoExcepcion: '',
					cafc: '',
					codigoMoneda: '',
					tipoCambio: 1,
					montoTotalMoneda: 1,
					leyenda: 'Ley Nro 453: Tienes derecho a recibir información sobre las características y contenidos de los servicios que utilices.',
					usuario: '',
					codigoDocumentoSector: '',
					//##DETALLE
					actividadEconomica: '',
					codigoProductoSin: '',
					codigoProducto: '',
					descripcion: '',
					cantidad: 1,
					unidadMedida: '',
					precioUnitario: 1,
					montoDescuento: 0,
					subTotal: 1,
					numeroSerie: '',
					numeroImei: '',
				}
			};
		},
		methods:
		{
			
		},
		mounted()
		{
			
		},
		created()
		{
			
		}
	};
	ns.SiatInvoiceBuilder = SiatInvoiceBuilder;
})(SBFramework.Components.Invoices.Siat);