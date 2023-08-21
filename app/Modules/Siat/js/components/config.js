(function(ns)
{
	ns.ComConfig = {
		template: `<div id="com-siat-config">
			<ul class="nav nav-tabs">
				<li class="nav-item active">
					<a href="#general" class="nav-link active" data-toggle="tab" data-bs-toggle="tab" data-coreui-toggle="tab">General</a>
				</li>
				<li class="nav-item">
					<a href="#cafc" class="nav-link" data-toggle="tab" data-bs-toggle="tab" data-coreui-toggle="tab">CAFC</a>
				</li>
			</ul>
			<div class="tab-content">
				<div id="general" class="tab-pane active">
					<div class="row">
						<div class="col-12 col-sm-6">
							<div class="form-group mb-3">
								<label>Nombre Sistema</label>
								<input type="text" class="form-control" v-model="config.nombreSistema" required />
							</div>
							<div class="form-group mb-3">
								<label>NIT</label>
								<input type="text" class="form-control" v-model="config.nit" required />
							</div>
							<div class="form-group mb-3">
								<label>Modalidad</label>
								<select class="form-control form-select" v-model="config.modalidad" required>
									<option value="">-- modalidad --</option>
									<option value="1">Electronica en Linea</option>
									<option value="2">Computarizada en Linea</option>
								</select>
							</div>
							<div class="form-group mb-3">
								<label>Token Delegado</label>
								<textarea class="form-control" rows="10" v-model="config.tokenDelegado"></textarea>
							</div>
							<div class="form-group mb-3">
								<label>Ciudad</label>
								<input type="text" class="form-control"  v-model="config.ciudad" />
							</div>
							<div class="form-group mb-3">
								<label>Telefono</label>
								<input type="text" class="form-control"  v-model="config.telefono" />
							</div>
						</div>
						<div class="col-12 col-sm-6">
							<div class="form-group mb-3">
								<label>Codigo Sistema</label>
								<input type="text" class="form-control" v-model="config.codigoSistema" required />
							</div>
							<div class="form-group mb-3">
								<label>Razon Social</label>
								<input type="text" class="form-control" v-model="config.razonSocial" required />
							</div>
							<div class="form-group mb-3">
								<label>Ambiente</label>
								<select class="form-control form-select" v-model="config.ambiente" required>
									<option value="">-- ambiente --</option>
									<option value="1">Produccion</option>
									<option value="2">Piloto/Pruebas</option>
								</select>
							</div>
							<div class="form-group mb-3" style="display:none;">
								<label>Logo</label>
								<input type="file" class="form-control" v-on:change="" ref="logo" />
								<div v-if="config.logo">
									<img src="" alt="" class="img-fluid" />
								</div>
							</div>
							<div class="form-group mb-3">
								<label>Llave privada</label>
								<input type="file" class="form-control" v-on:change="" ref="private_key" />
								<div v-if="config.privCert">
									<b>Archivo Actual:</b> {{ config.privCert.split('/').reverse()[0] }}
								</div>
							</div>
							<div class="form-group mb-3">
								<label>Certificado</label>
								<input type="file" class="form-control" v-on:change="" ref="cert" />
								<div v-if="config.pubCert">
									<b>Archivo Actual:</b> {{ config.pubCert.split('/').reverse()[0] }}
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="cafc" class="tab-pane">
					<div class="row">
						<div class="col-12 col-sm-3" v-for="(cafc, sector) in config.sectors">
							<div class="card">
								<div class="card">
									<div class="card-header"><h5 class="card-title">{{ cafc.title }}</h5></div>
									<div class="card-body">
										<div class="form-group mb-2">
											<label>CAFC</label>
											<input type="text" class="form-control" v-model="cafc.cafc" />
										</div>
										<div class="row">
											<div class="col-12 col-sm-6">
												<div class="form-group mb-2">
													<label>Inicio</label>
													<input type="text" class="form-control" v-model="cafc.inicio" />
												</div>
											</div>
											<div class="col-12 col-sm-6">
												<div class="form-group mb-2">
													<label>Fin</label>
													<input type="text" class="form-control" v-model="cafc.fin" />
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
			<div class="form-group mb-3">
				<button type="button" class="btn btn-primary" v-on:click="save()">Guardar</button>
			</div>
		</div>`,
		mixins: [],
		data()
		{
			return {
				config: {
					modalidad: '',
					ambiente: '',
					nombreSistema: '',
					codigoSistema: '',
					tokenDelegado: '',
					razonSocial: '',
					nit: '',
					ciudad: '',
					telefono: '',
					sectors: {
						'1': {cafc: '', inicio: '', fin: '', title: 'Compra Venta'},
						'2': {cafc: '', inicio: '', fin: '', title: 'Alquileres'},
						'3': {cafc: '', inicio: '', fin: '', title: 'Comercial Exportacion'},
					}
				},
				service: new SBFramework.Services.ServiceConfig(),
			};
		},
		methods: 
		{
			async save()
			{
				try
				{
					this.$root.$processing.show('Guardando datos...');
					await this.service.save(this.config);
					await this.uploadFiles();
					this.$root.$processing.hide();
					this.$root.$toast.ShowSuccess('Configuracion guardada');
					
				}
				catch(e)
				{
					this.$root.$toast.ShowError(e.error || e.message || 'Error desconocido');
				}
			},
			async load()
			{
				const res = await this.service.read();
				if( res.data )
				{
					const sectors = Object.assign({}, res.data.sectors);
					delete res.data.sectors;
					Object.assign(this.config, res.data);
					if( typeof sectors == 'object' && Object.keys(sectors).length > 0 )
					{
						this.config.sectors = sectors;
					}	
				}	
			},
			async uploadFiles()
			{
				var form = new FormData();
				if(this.$refs.logo.files > 0 );
					form.append('logo', this.$refs.logo.files[0]);
				if(this.$refs.private_key.files > 0 );
					form.append('private_key', this.$refs.private_key.files[0]);
				if(this.$refs.cert.files > 0 );
					form.append('certificate', this.$refs.cert.files[0]);
				
				const endpoint = '/siat/config/certs/upload';
				const res = await this.service.Upload(endpoint, form);
				console.log(res);
			}
		},
		mounted()
		{
			
		},
		created()
		{
			this.load();
		}
	};
	SBFramework.AppComponents = {
		'siat-config': ns.ComConfig, 
	};
})(SBFramework.Components.Siat);