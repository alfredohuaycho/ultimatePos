(function(ns)
{
	ns.ComProcessing = {
		template: `<div id="com-processing">
			<div id="com-processing-overlay" style="position:fixed;z-index:99999;top:0;right:0;bottom:0;left:0;background: rgba(0,0,0,0.6);text-align:center;">
				<div style="margin-top:20%;display:inline-block;text-align:left;width:40%;padding:10px;background:#fff;border-radius:10px;" class="shadow">
					<div class="text-center">
						{{ __('Processing...') }}<br/>
						<img v-bind:src="image_url" alt="" />
					</div>
				</div>
			</div>
		</div>`,
		props: {
			message: {type: String, required: false, default: 'Processing'}
		},
		data()
		{
			return {
				image_url: SBFramework.BASEURL + '/images/loadingAnimation.gif',
			};
		},
		mounted()
		{
			
		},
		created()
		{
			console.log('ComProcessing');
		}
		
	};
})(SBFramework.Components);