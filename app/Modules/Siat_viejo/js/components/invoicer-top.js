(function(ns)
{
	ns.ComInvoicerTop = {
		template: `<div class="mb-1 shadow bg-white" style="padding:5px;border:1px solid #ececec;">
			<div class="row p-1">
				<div class="col-6 col-sm-3">
					<template v-if="!activeEvent">
						<div class="dropdown">
							<button class="btn dropdown-toggle w-100 btn-block" type="button" 
								data-toggle="dropdown" data-bs-toggle="dropdown" data-coreui-toggle="dropdown" aria-expanded="false"
								v-bind:class="{'btn-success': !activeEvent, 'btn-danger': activeEvent}">
								{{ activeEvent ? 'Fuera de linea' : 'En Linea' }}
							</button>
							<ul class="dropdown-menu" style="z-index:800;">
								<li><a class="dropdown-item" href="javascript:;" v-on:click="openEvent(1)">1. CORTE DEL SERVICIO DE INTERNET</a></li>
								<li><a class="dropdown-item" href="javascript:;" v-on:click="openEvent(2)">2. INACCESIBILIDAD AL SERVICIO WEB DE LA ADMINISTRACIÓN TRIBUTARIA</a></li>
								<li><a class="dropdown-item" href="javascript:;" v-on:click="openEvent(3)">3. INGRESO A ZONAS SIN INTERNET POR DESPLIEGUE DE PUNTO DE VENTA EN VEHICULOS AUTOMOTORES</a></li>
								<li><a class="dropdown-item" href="javascript:;" v-on:click="openEvent(4)">4. VENTA EN LUGARES SIN INTERNET</a></li>
							</ul>
						</div>
					</template>
					<a v-else class="btn btn-danger w-100" href="javascript:;" v-on:click="abriCerrarEvento">
						{{ this.activeEvent.evento_id < 5 ? 'FUERA DE LINEA' : 'CERRAR CONTINGENCIA' }}
					</a>
				</div>
				<div class="col-12 col-sm-4">
					<div class="">
						<select class="form-control form-select" v-model="invoice.punto_venta" required>
							<option value="">-- punto de venta --</option>
							<option value="0">Punto de Venta 0 (por defecto)</option>
							<option v-bind:value="pv.codigo" v-for="(pv, ipv) in puntosventa">
								({{ pv.codigo }}) {{ pv.nombre }}
							</option>
						</select>
						<!--
						<div class="invalid-feedback">Debe debe seleccionar un punto de venta</div>
						-->
					</div>
				</div>
				<div class="col-6 col-sm-4">
					<div class="">
						<div class="col-12 col-sm-6">
							<select class="form-control form-select" required v-model="invoice.codigo_moneda">
								<option value="">-- moneda --</option>
								<option v-bind:value="m.codigoClasificador" v-for="(m, mi) in monedas">
									{{ m.descripcion }}
								</option>
							</select>
						</div>
						<div class="col-12 col-sm-6">
							<input type="text" class="form-control" v-model="invoice.tipoDeCambio"" />
						</div>
					</div>
				</div>
				<div class="col-1">
					<a class="btn btn-primary float-end" data-coreui-toggle="offcanvas" data-bs-toggle="offcanvas" v-on:click="$emit('ops-clicked')" 
						role="button" aria-controls="offcanvasExample">
						<i class="fa fa-bars"></i>
					</a>
				</div>
			</div>
			<div class="alert alert-warning" v-if="activeEvent">
				<div>
					<b>Evento/Contingencia activa!!!</b>
				</div> 
				<div><b>{{ activeEvent.descripcion }}, {{ activeEvent.fecha_inicio}} - {{ activeEvent.fecha_fin }}</b></div>
				<div>Todas las facturas generadas se almacenaran localmente y no se enviaran a SIAT hasta cerrar el evento/contingencia.</div>
			</div>
			
			<div ref="modalcerrarevento" class="modal fade">
				<form ref="formcerrar" action="" method="" novalidate>
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">Cerrar Evento</h5>
								<button class="btn-close" type="button" data-coreui-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<template v-if="activeEvent">
									<siat-cerrar-evento 
										ref="comcerrar" 
										v-bind:evento="activeEvent"
										v-on:evento-cerrado="eventoCerrado" />
								</template>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" data-dismiss="modal" data-coreui-dismiss="modal">Cerrar</button>
								<button type="button" class="btn btn-primary" v-on:click="cerrarEvento()">Cerrar Evento</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>`,
		components: {
			'siat-cerrar-evento': ns.CerrarEvento,
		},
		props: {
			puntosventa: {type: Array, required: true},
			monedas: {type: Array, required: true},
			invoice: {type: Object, required: true},
		},
		data()
		{
			return {
				activeEvent: null,
				service: new SBFramework.Services.ServiceEvents(),
			};	
		},
		methods: 
		{
			setActiveEvent(event)
			{
				this.setActiveEvent = event;
			},
			async openEvent(eventoId, system)
			{
				try
				{
					system = system === true ? 1 : 0;
					await this.checkActiveEvent();
					if( this.activeEvent )
						return;
					this.$root.$processing.show('Generando evento significativo...');
					const event 		= new SBFramework.Models.Evento();
					event.sucursal_id 	= 0;
					event.puntoventa_id = this.invoice.punto_venta;
					event.evento_id 	= eventoId;
					event.fecha_inicio 	= new Date();
					const res = await this.service.crear(event, system);
					console.log(res);
					if( res.data )
						this.activeEvent = res.data;
					this.$root.$processing.hide();
				}	
				catch(e)
				{
					this.$root.$processing.hide();
					alert(e.error || e.message || 'Error desconocido al verificar eventos activos');
				}
			},
			async checkActiveEvent()
			{
				try
				{
					this.$root.$processing.show('Verificando...');
					const res = await this.service.obtenerActivo(this.invoice.codigo_sucursal, this.invoice.punto_venta);
					this.activeEvent = res.data;
					this.$root.$processing.hide();
					if( this.activeEvent )
					{
						this.$emit('evento-activo', this.activeEvent);
					}
				}	
				catch(e)
				{
					this.$root.$processing.hide();
					alert(e.error || e.message || 'Error desconocido al verificar eventos activos');
				}
			},
			abriCerrarEvento()
			{
				//this.modalCerrarEvento.show();
				this.cerrarEvento();	
			},
			async cerrarEvento()
			{
				try
				{
					this.$root.$processing.show('Cerrando evento/contingencia');
					await this.$refs.comcerrar.send();
					//this.reset();
					await this.checkActiveEvent();
					this.$root.$processing.hide();
				}
				catch(e)
				{
					this.$root.$processing.hide();
					alert(e.error || e.message || 'Ocurrio un error al cerrar el evento');
				}
				
			},
			eventoCerrado(xhr_res)
			{
				console.log('eventoCerrado', xhr_res);
				//this.modalCerrarEvento.modal('hide');
				this.$root.$toast.ShowSuccess('El evento fue cerrado correctamente');
				this.checkActiveEvent(this.invoice.codigo_sucursal, this.invoice.punto_venta);	
			},
		},
		mounted()
		{
			
		},
		created()
		{
			this.checkActiveEvent();
		}
	};
})(SBFramework.Components.Siat);