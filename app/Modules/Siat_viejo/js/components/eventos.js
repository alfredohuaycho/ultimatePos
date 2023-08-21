(function(ns)
{
	ns.ComEventos = {
		template: `<div id="com-siat-puntos-venta">
			<h2>
				Registro de Eventos 
				<button type="button" class="btn btn-primary" v-on:click="nuevo()">Nuevo</button>
			</h2>
			<div class="mb-3">
				<div class="row g-1">
					<div class="col-12 col-sm-2">
						<input type="date" class="form-control" v-model="sync_date" ref="syncdate" />
					</div>
					<div class="col-12 col-sm-3">
						<select class="form-control form-select" v-model="sync_sucursal_id">
							<option value="0">Sucursal Principal 0 (por defecto)</option>
							<option v-bind:value="s.code" v-for="(s, si) in sucursales">{{ s.name }}</option>
						</select>
					</div>
					<div class="col-12 col-sm-3">
						<select class="form-control form-select" v-model="sync_puntoventa_id">
							<option value="">-- punto de venta --</option>
							<option value="0">Punto de Venta 0 (por defecto)</option>
							<option v-for="(pv, ipv) in puntosventa" v-bind:value="pv.codigo">({{ pv.codigo }}) {{ pv.nombre }}</option>
						</select>
					</div>
					<div class="col-12 col-sm-2">
						<button type="button" class="btn btn-warning w-100" v-on:click="sync()">Sincronizar</button>
					</div>
					<div class="col-12 col-sm-2">
						<button type="button" class="btn btn-primary w-100" v-on:click="filter()">Filtrar</button>
					</div>
				</div>
			</div>
			<template v-if="items.length > 0">
			<div class="panel card border shadow mb-2" v-for="(item, index) in items">
				<div class="panel-body card-body">
					<div class="row">
						<div class="col-12 col-sm-4">
							<div>ID: {{ item.id }}</div>
							<div>Sucursal: {{ item.codigo_sucursal }}</div>
							<div>Punto de Venta: {{ item.codigo_puntoventa }}</div>
							<div>{{ item.evento_id }} {{ item.descripcion }}</div>
						</div>
						<div class="col-12 col-sm-4">
							<div><b>Codigo Recepcion:</b> {{ item.codigo_recepcion }}</div>
							<div><b>Fecha Inicio:</b> {{ item.fecha_inicio }}</div>
							<div><b>Fecha Fin:</b> {{ item.fecha_fin || 'Sin asignar'}}</div>
							<div><b>Estado Recepcion:</b> {{ item.estado_recepcion }}</div>
						</div>
						<div class="col-12 col-sm-2">
							<span class="badge" v-bind:class="{'bg-success': item.estado == 'OPEN', 'bg-danger': item.estado == 'CLOSED'}">
								{{ item.estado == 'OPEN' ? 'Abierto' : 'Cerrado' }}
							</span>
						</div>
						<div class="col-12 col-sm-2">
							<template v-if="item.estado_recepcion == 'OBSERVADA'">
								<button type="button" class="btn btn-warning w-100 mb-2 btn-block" v-on:click="validarCerrar(item, index)">Reenviar</button>
							</template>
							<template v-if="item.estado == 'OPEN'">
								<button type="button" class="btn btn-primary w-100 mb-2 btn-block" v-on:click="validarCerrar(item, index)">Cerrar Evento</button>
								<button type="button" class="btn btn-danger w-100 mb-2 btn-block" v-on:click="anular(item, index)">Anular Evento</button>
							</template>
							<template v-else>
								<button type="button" class="btn btn-primary w-100 mb-2 btn-block" v-on:click="validarRecepcion(item, index)">Validar Recepcion</button>
							</template>
							<template v-if="item.codigo_recepcion_paquete">
								<button type="button" class="btn btn-info w-100 mb-2 btn-block" v-on:click="detallesRecepcion(item, index)">Ver Detalles Recepcion</button>
							</template>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div><b>CUFD Evento:</b> {{ item.cufd_evento }}</div>
							<div class="form-text text-muted">{{ item.creation_date }}</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div v-bin:id="'accordion-' + item.id" class="accordion">
								<div class="accordion-item">
 									<h2 class="accordion-header">
	  									<button class="accordion-button" type="button" 
	  										data-bs-toggle="collapse collapsed" v-bind:data-bs-target="'#collapse-' + item.id"
	  										data-coreui-toggle="collapse" v-bind:data-coreui-target="'#collapse-' + item.id">
											Paquetes
										</button>
									</h2>
									<div v-bind:id="'collapse-' + item.id" class="accordion-collapse collapse" 
										v-bind:data-bs-parent="'accordion-' + item.id"
										v-bind:data-core-parent="'accordion-' + item.id">
										<div class="accordion-body">
											<div class="list-group">
												<div class="list-group" v-for="(pkg, pkgi) in item.packages">
													<div>{{ pkg.id }}.  {{ pkg.reception_status }}</div>
													<div>{{ pkg.data }}</div>
												</div>
											</div>
 										</div>
 									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</template>
			<div v-else>
				<b class="text-primary">No se encontraron registros de eventos</b>
			</div>
			<div ref="modal" class="modal fade">
				<div class="modal-dialog">
					<form ref="formnew" class="modal-content" novalidate>
						<div class="modal-header">
							<h5 class="modal-title">Registrar nuevo evento/contingencia</h5>
							<button class="close btn-close" type="button" data-coreui-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="mb-3">
								<label>Sucursal</label>
								<select class="form-control form-select" required v-model="evento.sucursal_id" required>
									<option value="">-- sucursal --</option>
									<option value="0">Sucursal Principal 0 (por defecto)</option>
									<option v-bind:value="s.code" v-for="(s, si) in sucursales">{{ s.name }}</option>
								</select>
								<div class="invalid-feedback">Debe seleccionar el tipo de moneda</div>
							</div>
							<div class="mb-3">
								<label>Punto de Venta</label>
								<select class="form-control form-select" required v-model="evento.puntoventa_id">
									<option value="">-- tipo --</option>
									<option value="0">Punto de venta 0</option>
									<template v-for="(pv, pvi) in puntosventa">
										<option v-bind:value="pv.codigo">({{ pv.codigo }}) {{ pv.nombre }} ({{ pv.tipo }})</option>
									</template>
								</select>
								<div class="invalid-feedback">Necesita seleccionar un punto de venta</div>
							</div>
							<div class="mb-3">
								<label>Tipo de Evento</label>
								<select class="form-control form-select" required v-model="evento.evento_id">
									<option value="">-- tipo evento --</option>
									<template v-for="(evt, ei) in eventos">
									<option v-bind:value="evt.codigoClasificador">({{ evt.codigoClasificador }}) {{ evt.descripcion }}</option>
									</template>
								</select>
								<div class="invalid-feedback">Necesita seleccionar el tipo de evento</div>
							</div>
							<div class="mb-3">
								<div class="row">
									<div class="col-sm-6">
										<label>Fecha Inicio</label>
										<input type="date" name="" value="" class="form-control" ref="eventofechainicio"
											 required />
										<div class="invalid-feedback">Necesita seleccionar una fecha de inicio del evento</div>
									</div>
									<div class="col-sm-6">
										<label>Hora Inicio</label>
										<input type="time" name="" value="" class="form-control" ref="eventohorainicio"
											 required />
										<div class="invalid-feedback">Necesita seleccionar una hora de inicio del evento</div>
									</div>
								</div>
							</div>
							<div v-show="esContingencia">
								<div class="mb-3">
									<div class="row">
										<div class="col-sm-6">
											<label>Fecha Fin</label>
											<input type="date" name="" value="" class="form-control" ref="eventofechafin" />
										</div>
										<div class="col-sm-6">
											<label>Hora Fin</label>
											<input type="time" name="" value="" class="form-control" ref="eventohorafin" />
										</div>
									</div>
								</div>
								<div class="mb-2">
									<label>CUFD</label>
									<select class="form-control form-select" v-model="evento.cufd_evento">
										<option value="">-- seleccionar un CUFD --</option>
										<option v-bind:value="cufd.codigo" v-for="(cufd, ci) in cufds">
											{{ cufd.created_at }} - {{ cufd.fecha_vigencia }}
										</option>
									</select>
									<div class="invalid-feedback">Necesita seleccionar CUFD para el evento</div>
								</div>
								<div class="mb-1">
									<div class="p-2 border circle">{{ evento.cufd_evento }}</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal" data-coreui-dismiss="modal">Cerrar</button>
							<button type="button" class="btn btn-primary" v-on:click="guardar()">Guardar</button>
						</div>
					</form>
				</div>
			</div>
			<div ref="modalcerrar" class="modal fade">
				<div class="modal-dialog">
					<form ref="formcerrar" action="" method="" class="modal-content" novalidate>
						<div class="modal-header">
							<h5 class="modal-title">Cerrar Evento</h5>
							<button class="btn-close" type="button" data-coreui-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<template v-if="eventoIndex > -1 && items[eventoIndex]">
								<siat-cerrar-evento ref="comcerrar" 
									v-bind:evento="items[eventoIndex]"
									v-on:evento-cerrado="eventoCerrado" />
							</template>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal" data-coreui-dismiss="modal">Cerrar</button>
							<button type="button" class="btn btn-primary" v-on:click="cerrarEvento()">Cerrar Evento</button>
						</div>
					</form>
				</div>
			</div>
			<div ref="modaldetalles" class="modal fade">
				<div class="modal-dialog">
					<div action="" method="" class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">Detalles de Recepcion</h5>
							<button class="btn-close" type="button" data-coreui-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<template v-if="dEvento && dEvento.data.RespuestaServicioFacturacion">
								<div class="list-group" style="height:300px;overflow:auto;">
									<div class="list-group-item" v-for="(ritem, rindex) in dEvento.data.RespuestaServicioFacturacion.mensajesList">
										<div class="container-fluid">
											<div class="row">
												<div class="col-6 col-sm-6"><b>Codigo:</b> {{ ritem.codigo }}</div>
												<div class="col-6 col-sm-6"><b>Nro. Archivo:</b> {{ ritem.numeroArchivo }}</div>
											</div>
											<div class="row">
												<div class="col">{{ ritem.descripcion }}</div>
											</div>
										</div>
									</div>
								</div>
							</template>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal" data-coreui-dismiss="modal" v-on:click="dEvento = null;">
								Cerrar
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>`,
		components: {
			'siat-cerrar-evento': ns.CerrarEvento,
		},
		data()
		{
			return {
				page: 0,
				total_items: 0,
				sucursales: [],
				items: [],
				puntosventa: [],
				eventos: [],
				cufds: [],
				evento: new SBFramework.Models.Evento(),
				dEvento: null,
				eventoIndex: -1,
				sync_sucursal_id: 0,
				sync_puntoventa_id: 0,
				sync_date: new Date(),
				modal: null,
				modalcerrar: null,
				service: new SBFramework.Services.ServiceEvents(),
				serviceInvoices: new SBFramework.Services.ServiceInvoices(),
			};	
		},
		computed:
		{
			esContingencia()
			{
				return [5, 6, 7].indexOf(this.evento.evento_id) > -1;
			}
		},
		watch: 
		{
			'evento.puntoventa_id'()
			{
				this.getCufds();
			},
			'evento.evento_id'()
			{
				if( this.esContingencia )
				{
					this.$refs.eventofechafin.value = '';
					this.$refs.eventohorafin.value = '';
				}
				else
				{
					this.evento.cufd_evento = '';
				}
				
			}
		},
		methods: 
		{
			async getSucursales()
			{
				const res = await this.serviceInvoices.obtenerSucursales();
				this.sucursales = res.data
			},
			nuevo()
			{
				this.modal.modal('show');
				this.evento.fecha_inicio = new Date();
				this.evento.fecha_fin = null;
				this.$refs.eventofechainicio.value = sb_formatdate(new Date(), 'Y-m-d');
				this.$refs.eventohorainicio.value = sb_formatdate(new Date(), 'H:i') + ':00.00';
			},
			async sync()
			{
				this.items = [];
				try
				{
					this.$root.$processing.show('Obteniendo datos...');
					const res = await this.service.syncEventos(this.sync_sucursal_id, this.sync_puntoventa_id, this.sync_date);
					this.items = res.data;
					this.$root.$processing.hide();
				}
				catch(e)
				{
					this.$root.$processing.hide();
					this.$root.$toast.ShowError(e.error || e.message || 'Ocurrio un error al obtener los eventos');
				}
			},
			async filter()
			{
				this.items = [];
				this.getItems(1, this.sync_sucursal_id, this.sync_puntoventa_id);
			},
			async getPuntosVenta()
			{
				const res = await this.serviceInvoices.obtenerPuntosVenta();
				this.puntosventa = res.data;
			},
			async getEventos()
			{
				const res = await this.serviceInvoices.obtenerEventos();
				this.eventos = res.data.RespuestaListaParametricas.listaCodigos;	
			},
			async getCufds()
			{
				this.cufds = [];
				if( parseInt(this.evento.sucursal_id) < 0 )
					return;
				if( parseInt(this.evento.puntoventa_id) < 0 )
					return;
				const res = await this.serviceInvoices.obtenerCufds(this.evento.sucursal_id, this.evento.puntoventa_id);
				this.cufds = res.data;
			},
			async getItems(page, sucursal, puntoventa)
			{
				page 		= isNaN(page) ? 1 : page;
				sucursal 	= isNaN(parseInt(sucursal)) ? 0 : parseInt(sucursal);
				puntoventa 	= isNaN(parseInt(puntoventa)) ? 0 : parseInt(puntoventa);
				try
				{
					this.$root.$processing.show('Obteniendo datos...');
					const res = await this.service.obtenerEventos(sucursal, puntoventa, page);
					this.items = res.data;
					this.$root.$processing.hide();
				}
				catch(e)
				{
					this.$root.$processing.hide();
					this.$root.$toast.ShowError(e.error || e.message || 'Ocurrio un error al obtener los eventos');
				}
			},
			async guardar()
			{
				try
				{
					this.$refs.formnew.classList.remove('was-validated');
					if( !this.$refs.formnew.checkValidity() )
					{
						this.$refs.formnew.classList.add('was-validated');
						return;
					}
					//this.evento.fecha_inicio = this.$refs.eventofechainicio.valueAsDate || this.$refs.eventofechainicio.value;
					this.evento.fecha_inicio = new Date(`${this.$refs.eventofechainicio.value} ${ this.$refs.eventohorainicio.value}`);
					this.evento.fecha_inicio.setSeconds((new Date()).getSeconds());
					if( !this.evento.fecha_inicio )
						throw {error: 'Debe seleccionar una fecha inicio para el evento'};
					if( this.esContingencia && this.$refs.eventofechafin.value && this.$refs.eventohorafin.value )
					{
						this.evento.fecha_fin = new Date(`${this.$refs.eventofechafin.value} ${ this.$refs.eventohorafin.value}`);
						//this.evento.fecha_inicio.setSeconds((new Date()).getSeconds());
						if( !this.evento.fecha_fin )
							throw {error: 'Debe seleccionar una fecha inicio para el evento'};
					}
						
					this.$root.$processing.show('Procesando...');
					const res = await this.service.crear(this.evento);
					this.$root.$processing.hide();
					this.$root.$toast.ShowSuccess('Evento Registrado correctamente');
					console.log(res);
					this.modal.modal('hide');
					this.filter();
				}
				catch(e)
				{
					console.log(e);
					this.$root.$processing.hide();
					this.$root.$toast.ShowError(e.error || e.message || 'Ocurrio un error al registrar el evento');
				}
			},
			validarCerrar(item, index)
			{
				this.eventoIndex = index;
				this.modalcerrar.modal('show');
			},
			async cerrarEvento()
			{
				await this.$refs.comcerrar.send();
				this.filter();
			},
			eventoCerrado(xhr_res)
			{
				console.log('eventoCerrado', xhr_res);
				this.modalcerrar.modal('hide');
				this.$root.$toast.ShowSuccess('El evento fue cerrado correctamente');
				this.getItems(1, this.sync_sucursal_id, this.sync_puntoventa_id);
			},
			async validarRecepcion(item, index)
			{
				try
				{
					this.$root.$processing.show('Validando facturas del evento...');
					const res = await this.service.validateRecepcion(item.id);
					//console.log(res);
					this.$root.$processing.hide();
					this.filter();
				}
				catch(e)
				{
					console.log(e);
					this.$root.$processing.hide();
					this.$root.$toast.ShowError(e.error || e.message || 'Ocurrio un error al registrar el evento');
				}
			},
			async detallesRecepcion(item, index)
			{
				this.dEvento = item;
				if( !Array.isArray(this.dEvento.data.RespuestaServicioFacturacion.mensajesList) && this.dEvento.data.RespuestaServicioFacturacion.mensajesList )
				{
					this.dEvento.data.RespuestaServicioFacturacion.mensajesList = [this.dEvento.data.RespuestaServicioFacturacion.mensajesList];
				}
				console.log(this.dEvento.data.RespuestaServicioFacturacion);
				this.modaldetalles.show();
			},
			async anular(item, index)
			{
				try
				{
					this.$root.$processing.show('Anulando evento...');
					const res = await this.service.anular(item.id);
					this.$root.$processing.hide();
					this.filter();
				}
				catch(e)
				{
					this.$root.$processing.hide();
					this.$root.$toast.ShowError(e.error || e.message || 'Ocurrio un error al registrar el evento');
				}
			}
		},
		mounted()
		{
			this.$refs.syncdate.value = new Date();
			const frame = (window.bootstrap || window.coreui);
			if( frame )
			{
				this.modal = frame.Modal.getInstance(this.$refs.modal);
				this.modalcerrar = frame.Modal.getInstance(this.$refs.modalcerrar);
				this.modaldetalles = frame.Modal.getInstance(this.$refs.modaldetalles);
				
				if( !this.modal )
					this.modal = new frame.Modal(this.$refs.modal, {});
				if( !this.modalcerrar )
					this.modalcerrar = new frame.Modal(this.$refs.modalcerrar, {});
				if( !this.modaldetalles )
					this.modaldetalles = new frame.Modal(this.$refs.modaldetalles, {});
			}
			else
			{
				this.modal 			= jQuery(this.$refs.modal);
				this.modalcerrar 	= jQuery(this.$refs.modalcerrar);
				this.modaldetalles 	= jQuery(this.$refs.modaldetalles);
			}
		},
		created()
		{
			this.getSucursales();
			this.getItems();
			this.getPuntosVenta();
			this.getEventos();
		}
	};
	SBFramework.AppComponents = {
		'siat-eventos': ns.ComEventos, 
	};
})(SBFramework.Components.Siat);