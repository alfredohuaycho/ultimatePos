if( !window.SBFramework )
{
	window.SBFramework = {
		Components: {
			Invoices: {
				Siat: {}
			}
		}	
	};
}
document.writeln('<script src="'+ lt.baseurl + '/modules/mod_invoices/js/siat/components/invoice-builder.js"></script>');
(function()
{
	let loaded = setInterval(function()
	{
		if( SBFramework.Components.Invoices.Siat.SiatInvoiceBuilder )
		{
			clearInterval(loaded);
			const app = new Vue({
				el: '#siat-test',
				template: `<div id="com-siat-tests">
					<ul class="nav nav-tabs">
						<li class="nav-item"><a href="#api" class="nav-link" data-toggle="tab">API</a></li>
						<li class="nav-item"><a href="#tests" class="nav-link active" data-toggle="tab">Pruebas</a></li>
					</ul>
					<div class="tab-content">
						<div id="api" class="tab-pane">
						</div>
						<div id="tests" class="tab-pane active">
							<ul class="nav nav-tabs">
								<li class="nav-item"><a href="#test-general" class="nav-link active" data-toggle="tab">General</a></li>
								<li class="nav-item"><a href="#test-invoice" class="nav-link" data-toggle="tab">Facturacion</a></li>
							</ul>
							<div class="tab-content">
								<div id="test-general" class="tab-pane active">
									<div class="container-fluid">
										<div class="row">
											<div class="col-12 col-sm-9">
												<div class="mb-3">
													<label>Llamada Servicio web</label>
													<select class="form-control form-select" v-model="call.endpoint">
														<option v-for="(call, index) in serviceCalls" v-bind:value="call.endpoint">
															{{ call.label }}
														</option>
													</select>
												</div>
												<div class="mb-3">
													<button type="button" class="btn btn-primary btn-sm w-100" v-on:click="send($event)">Enviar solicitud</button>
												</div>
												<template v-if="processing">
													<div class="mb-3">
														<div class="spinner-border text-primary" role="status">
														  <span class="sr-only">Enviando solicitud...</span>
														</div>
													</div>
												</template>
												<div class="mb-3">
													<label>Respuesta Servicio web</label>
													<div class="form-control" style="background:#000;color:green;height:400px;overflow:auto;" >
														<pre class="code" style="color:inherit;" v-html="response.text"></pre>
													</div>
												</div>
											</div>
											<div class="col-12 col-sm-3">
												<form>
													<div class="mb-3">
														<label>Token delegado</label>
														<input type="text" v-model="config.delegatedToken" class="form-control" required />
													</div>
													<div class="mb-3">
														<label>NIT</label>
														<input type="text" v-model="config.nit" class="form-control" required />
													</div>
													<div class="mb-3">
														<label>Codigo Sistema</label>
														<input type="text" v-model="config.codigoSistema" class="form-control" required />
													</div>
													<div class="mb-3">
														<label>Ambiente</label>
														<select class="form-control form-select" v-model="config.ambiente">
															<option value="2">Pruebas</option>
															<option value="1">Produccion</option>
														</select>
													</div>
													<div class="mb-3">
														<label>Modalidad</label>
														<select class="form-control form-select" v-model="config.modalidad">
															<option value="1">Electronica en linea</option>
															<option value="2">Computarizada en linea</option>
														</select>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div><!-- end test-general -->
								<div id="test-invoice" class="tab-pane">
									<div v-if="!cuis || !cufd">
										Debe obtener el codigo CUIS y CUFD desde las pruebas generales para poder construir una factura
									</div>
									<div v-else>
										<siat-invoice-builder v-bind:nit="config.nit" v-bind:cuis="cuis" v-bind:cufd="cufd" />
									</div>
								</div>
							</div>
						</div><!-- end tab-tests -->
					</div>
				</div>`,
				components: {
					'siat-invoice-builder': SBFramework.Components.Invoices.Siat.SiatInvoiceBuilder,
				},
				data:
				{
					serviceCalls: [
						{'label': 'Obtener CUIS', 'endpoint': '/api/invoices/siat/v2/cuis'},
						{'label': 'Obtener CUFD', 'endpoint': '/api/invoices/siat/v2/cufd'},
						{'label': 'Sincronizar Tipo Documentos Sector', 'endpoint': '/api/invoices/siat/v2/tipo-documentos-sector'},
						{'label': 'Sincronizar Tipos de Factura', 'endpoint': '/api/invoices/siat/v2/tipo-facturas'},
						{'label': 'Sincronizar Actividades', 'endpoint': '/api/invoices/siat/v2/actividades'},
						{'label': 'Sincronizar Lista Actividades Documento Sector', 'endpoint': '/api/invoices/siat/v2/lista-actividades'},
						{'label': 'Sincronizar Motivo Anulacion', 'endpoint': '/api/invoices/siat/v2/motivo-anulacion'},
						{'label': 'Sincronizar Eventos Significativos', 'endpoint': '/api/invoices/siat/v2/eventos'},
						{'label': 'Sincronizar Lista Productos y Servicios', 'endpoint': '/api/invoices/siat/v2/lista-productos-servicios'},
						{'label': 'Sincronizar Tipos de Moneda', 'endpoint': '/api/invoices/siat/v2/lista-tipos-moneda'},
						{'label': 'Sincronizar Tipos de Emision', 'endpoint': '/api/invoices/siat/v2/lista-tipos-emision'},
						{'label': 'Sincronizar Lista Mensajes Servicios', 'endpoint': '/api/invoices/siat/v2/lista-mensajes-servicios'},
					],
					config: {
						delegatedToken: '',
						nit: '',
						codigoSistema: '',
						ambiente: 2,
						modalidad: 2,
					},
					call: {
						endpoint: ''
					},
					response: {
						text: '',
						data: {}
					},
					processing: false,
					cuis: '',
					cufd: '',
				},
				methods: 
				{
					saveConfig()
					{
						sessionStorage.setItem('siat_config', JSON.stringify(this.config));
					},
					loadConfig()
					{
						const cfg = sessionStorage.getItem('siat_config');
						if( !cfg )
							return false;
						Object.assign(this.config, JSON.parse(cfg));
					},
					async send()
					{
						try
						{
							this.response.text = '';
							this.processing = true;
							this.saveConfig();
							if( this.call.endpoint.trim().length <= 0 )
								throw {error: 'Debe seleccionar una llamada para el servicio'}
							const ops = {
								method: 'POST',
								headers: {
									'Content-Type': 'application/json'
								},
								body: JSON.stringify({config: this.config})
							};
							const res = await fetch(lt.baseurl + this.call.endpoint, ops);
							this.processing = false;
							//console.log(await res.json());
							const data =  await res.json();
							console.log(data);
							this.response.data = data;
							this.response.text = this.syntaxHighlight(this.response.data);
							console.log(this.response);
							if( this.response.data.data.RespuestaCuis && this.response.data.data.RespuestaCuis.codigo )
								this.cuis = this.response.data.data.RespuestaCuis.codigo;
							if( this.response.data.data.RespuestaCufd && this.response.data.data.RespuestaCufd.codigo )
								this.cufd = this.response.data.data.RespuestaCufd.codigo;
							console.log(this.cuis, this.cufd);
						}
						catch(e)
						{
							this.processing = false;
							console.log(e);
							alert(e.error || e.message || 'Error inespedado');
						}
					},
					syntaxHighlight(json) 
					{
					    if (typeof json != 'string') {
					         json = JSON.stringify(json, undefined, 2);
					    }
					    json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
					    return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
					        var cls = 'number';
					        if (/^"/.test(match)) {
					            if (/:$/.test(match)) {
					                cls = 'key';
					            } else {
					                cls = 'string';
					            }
					        } else if (/true|false/.test(match)) {
					            cls = 'boolean';
					        } else if (/null/.test(match)) {
					            cls = 'null';
					        }
					        return '<span class="' + cls + '">' + match + '</span>';
					    });
					}
				},
				mounted()
				{
					
				},
				created()
				{
					this.loadConfig();
				}
			});
		}
	}, 1000);
	
})();