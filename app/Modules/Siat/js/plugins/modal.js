(function(ns)
{
	const ComModal = {
		template: `<div>
			<div class="modal fade" ref="modal">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
	    					<h5 class="modal-title" v-html="title">Modal title</h5>
	    					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	  					</div>
	  					<div class="modal-body">
	    					<div v-html="message"></div>
	  					</div>
	  					<div class="modal-footer">
	    					<button type="button" class="btn btn-secondary" v-on:click="hide()">Cerrar</button>
	    					<button type="button" class="btn btn-primary" v-on:click="ok()">Aceptar</button>
	  					</div>
					</div>
				</div>
			</div>
		</div>`,
		data()
		{
			return {
				title: '',
				message: '',
				$instance: null,
				ops: {},
			};
		},
		methods: 
		{
			show(title, message, ops)
			{
				this.title 		= title;
				this.message 	= message;
				this.ops		= ops;
				this.$instance.show();
			},
			hide()
			{
				this.$instance.hide();
				if( this.ops && this.ops.onClose )
				{
					this.ops.onClose();
				}
				this.ops = {};
			},
			ok()
			{
				this.$instance.hide();
				if( this.ops && this.ops.onOk )
				{
					this.ops.onOk();
				}
				this.ops = {};
			}
		},
		mounted()
		{
			console.log('bsModal mounted');
			this.$instance = new bootstrap.Modal(this.$refs.modal, {});
		},
		created()
		{
			
		}
		
	};
	ns.BsModal = 
	{
		install(Vue, ops)
		{
			const root = new Vue({
				data: {},
				render: (createElement) => 
				{
					return createElement(ComModal);
				},
				mounted()
				{
					Vue.prototype.$bsmodal = this.$children[0];
				}
			});
			let $container = ops.container ? document.getElementById(ops.container)  : document.body;
			root.$mount($container.appendChild(document.createElement('div')));
		}
	};
})(SBFramework.Plugins);