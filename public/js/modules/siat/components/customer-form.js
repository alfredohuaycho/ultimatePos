(function(ns)
{
	ns.ComCustomerForm = {
		template: `<div id="com-customer-form">
			<div ref="modalcustomer" class="modal fade">
				<form ref="formcustomer" novalidate>
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header"><h5 class="modal-title">Crear Cliente</h5></div>
							<div class="modal-body">
								<div class="mb-3">
									<label>Nombres</label>
									<input type="text" class="form-control" v-model="customer.firstname" />
									<div class="invalid-feedback">Ingrese el nombre del cliente</div>
								</div>
								<div class="mb-3">
									<label>Apellidos/Razon Social</label>
									<input type="text" class="form-control" v-model="customer.lastname" required />
									<div class="invalid-feedback">Ingrese el apellido del cliente</div>
								</div>
								<div class="mb-3">
									<label>NIT/CI</label>
									<input type="text" class="form-control" v-model="customer.nit_ruc_nif" required />
									<div class="invalid-feedback">Ingrese el NIT/CI del cliente</div>
								</div>
								<div class="mb-3">
									<label>Direccion</label>
									<input type="text" class="form-control" v-model="customer.address" />
									<div class="invalid-feedback">Ingrese la direccion del cliente</div>
								</div>
								<div class="mb-3">
									<label>Email</label>
									<input type="email" class="form-control" v-model="customer.email" />
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" data-dismiss="modal" data-bs-dismiss="modal" data-coreui-dismiss="modal">Cancelar</button>
								<button type="button" class="btn btn-primary" v-on:click="guardarCliente()">Guardar</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>`,
		props: 
		{
			//edit_customer: {type: Object, required: false}
		},
		data()
		{
			return {
				customer: {},
				modal: null,
				serviceCustomers: new SBFramework.Services.ServiceCustomers(),
			};
		},
		methods: 
		{
			resetCustomer()
			{
				this.customer = {
					id: 0,
					firstname: '',
					lastname: '',
					address: '',
					email: '',
					nit_ruc_nif: '',
				};	
			},
			showModal()
			{
				if( this.modalCustomer.modal )
				{
					this.modalCustomer.modal('show');
					return true;
				}
				this.modalCustomer.show();
			},
			closeModal()
			{
				if( this.modalCustomer.modal )
				{
					this.modalCustomer.modal('hide');
					return true;
				}
				this.modalCustomer.hide();
			},
			setCustomer(obj)
			{
				Object.assign(this.customer, obj);
			},
			async guardarCliente()
			{
				this.$refs.formcustomer.classList.remove('was-validated')
				try
				{
					if( !this.$refs.formcustomer.checkValidity() )
					{
						this.$refs.formcustomer.classList.add('was-validated')
						return false;
					}
					this.$root.$processing.show('Creando cliente...');
					if( !this.customer.company )
						this.customer.company = this.customer.last_name;
					const action = this.customer.id ? 'update' : 'create';
					const res = this.customer.id > 0 ?
						await this.serviceCustomers.update(this.customer) :
						await this.serviceCustomers.create(this.customer);
					
					this.$root.$processing.hide();
					this.closeModal();
					this.$emit('customer-saved', {
						action: action,
						customer: Object.assign({}, this.customer)
					});
					this.resetCustomer();
				}
				catch(e)
				{
					this.$root.$processing.hide();
					alert(e.error || e.message || 'Ocurrio un error al crear el cliente');
				}
			},
		},
		mounted()
		{
			const frame = (window.bootstrap || window.coreui);
			if( frame )
			{
				this.modalCustomer = frame.Modal.getOrCreateInstance(this.$refs.modalcustomer);
			}
			else
			{
				this.modalCustomer	= jQuery(this.$refs.modalcustomer);
			}
		},
		created()
		{
			this.resetCustomer();
			console.log(this.edit_customer);
		}
	};
})(SBFramework.Components.Siat);
