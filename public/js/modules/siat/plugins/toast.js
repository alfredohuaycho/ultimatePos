(function()
{
	let ComToast = 
	{
		template: `<div id="com-toast">
			<div id="app-toast" style="position:fixed;z-index:2000;top:-100%;right:0px;left:0px;transition:all 0.5s ease;" 
				v-bind:style="{top: message ? 0 : '-100%'}" class="alert" v-bind:class="{ 'alert-success green': success, 'alert-danger red': danger, 'toast panning': is_material}">
				{{ message }}
				<a href="javascript:;" class="btn btn-sm" style="position:absolute;right:5px;top:5px;" v-on:click="CloseToast()">X</a>
			</div>
		</div>`,
		data()
		{
			return {
				is_material: false,
				message: null,
				success: false,
				danger: false
			};	
		},
		methods: 
		{
			ShowToast: function(message, type)
			{
				this.is_material = typeof window.M == 'undefined' ? false : true;
				this.message = message;
				if( type == 'success' )
					this.success = true;
				if( type == 'danger' || type == 'error' )
					this.danger = true;
				if( type == 'info' )
					this.info = true;
				setTimeout(() => {
					this.CloseToast();
				}, 10000);
			},
			ShowSuccess(message)
			{
				console.log('success', message);
				this.ShowToast(message, 'success');
			},
			ShowError(message)
			{
				this.ShowToast(message, 'danger');
			},
			ShowInfo(message)
			{
				this.ShowToast(message, 'info');
			},
			ShowWarning(message)
			{
				this.ShowToast(message, 'warning');
			},
			CloseToast: function()
			{
				this.message 	= null;
				this.success 	= false;
				this.danger 	= false;
				this.info 		= false;
			}
		}
		
	};
	SBFramework.Plugins.PluginToast = 
	{
		install(Vue, ops)
		{
			const root = new Vue({
				data: {},
				render: (createElement) => 
				{
					return createElement(ComToast);
				},
				mounted()
				{
					//console.log('TOAST MOUNTED', this.$children[0]);
					Vue.prototype.$toast = this.$children[0];
				}
			});
			let $container = ops.container ? document.getElementById(ops.container)  : document.body;
			root.$mount($container.appendChild(document.createElement('div')));
		}
	};
})();