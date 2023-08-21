(function(ns)
{
	const ComProcessing = {
		template: `<div id="com-processing" v-if="shown">
			<div id="com-processing-overlay" style="position:fixed;z-index:99999;top:0;right:0;bottom:0;left:0;background: rgba(0,0,0,0.6);text-align:center;">
				<div style="margin-top:20%;display:inline-block;text-align:left;width:40%;padding:10px;background:#fff;border-radius:10px;" class="shadow">
					<div class="text-center">
						{{ message }}<br/>
						<img v-bind:src="image_url" alt="" />
					</div>
				</div>
			</div>
		</div>`,
		/*
		props: {
			message: {type: String, required: false, default: 'Processing'}
		},
		*/
		data()
		{
			return {
				shown: false,
				message: 'Processing...',
				image_url: SBFramework.BASEURL + '/images/loadingAnimation.gif',
			};
		},
		methods: 
		{
			show(msg)
			{
				if( msg )
					this.message = msg;
				this.shown = true;
			},
			hide()
			{
				this.shown = false;
			}
		},
		mounted()
		{
			
		},
		created()
		{
		}
		
	};
	ns.Processing = 
	{
		install(Vue, ops)
		{
			const root = new Vue({
				data: {},
				render: (createElement) => 
				{
					return createElement(ComProcessing);
				},
				mounted()
				{
					Vue.prototype.$processing = this.$children[0];
				}
			});
			let $container = ops.container ? document.getElementById(ops.container)  : document.body;
			root.$mount($container.appendChild(document.createElement('div')));
		}
	};
})(SBFramework.Plugins);