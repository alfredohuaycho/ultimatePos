(function(ns)
{
	ns.ComUploader = {
		model: {
			prop: 'file',
			event: 'change'
		},
		props: {
			label: 		{type: String, required: false, default: ''},
			endpoint: 	{required: true},
			csrf_token: {type: String, required: false}, 
			object_id: 	{type: Number, required: false, default: 0}, 
			collection: {type: Array}, 
			jwt: 		{type: String, required: false}, 
			auto: 		{type: Boolean, default: true, required: false},
			start: 		{type: Boolean, default: false, required: false},
			file:		{type: Object},
			name:		{type: String, default: 'attachment', required: false},
		},
		template: `<div class="form-group">
					<label v-if="label">{{ label }}</label>
					<input type="file" v-bind:name="name ? name : 'attachment'" class="form-control" @change="fileSelected($event)"
						ref="fileselector" />
					<div v-bind:class="[displayProgress, 'progress']">
						<div class="progress-bar progress-bar-striped progress-bar-animated" v-bind:style="{width: progress + '%'}">
							<span v-if="message">{{ message }}</span>
						</div>
					</div>
				</div>`,
		watch:{
			start(v)
			{
				if( v )
					this.uploadFile();
			}	
		},
		data: function()
		{
			return {
				displayProgress: 'd-none hidden',
				progress: 0,
				message: '',
			};
		},
		methods:
		{
			progressHandler: function(e)
			{
				//console.log(e.loaded, e.total, ((e.loaded*100) / e.total), Math.round((e.loaded * 100) / e.total));
				this.progress = Math.round((e.loaded * 100) / e.total);
				if( this.progress >= 100 )
				{
					this.message = 'Procesando...';
				}
			},
			onCompleteHandler: function(res, x)
			{
				console.log(res, x);
				this.progress 			= 0;
				this.displayProgress 	= 'd-none hidden';
				this.message = null;
				const rdata = res.originalTarget || res.currentTarget;
				this.$emit('uploaded', JSON.parse(rdata.responseText));
			},
			onErrorHandler: function()
			{
				this.progress 			= 0;
				this.displayProgress 	= 'd-none hidden';
				console.log(arguments);
			},
			onAbortHandler: function()
			{
				this.percent = 0;
				this.displayProgress = 'd-none hidden';
				console.log(arguments);
			},
			fileSelected: function(e)
			{
				this.$emit('change', e.target.files[0]);
				//console.log(e.target);
				if( !this.auto )
					return false;
				this.uploadFile();
			},
			uploadFile()
			{
				let endpoint = this.endpoint || null;
				if( !endpoint )
				{
					alert('Invalid uploader endpoint');
					return false;
				}
				this.displayProgress = '';
				let fdata = new FormData();
				fdata.append(this.name ? this.name : 'attachment', this.$refs.fileselector.files[0]);
				fdata.append('_token', this.csrf_token);
				if( this.object_id )
					fdata.append('object_id', this.object_id);
	
				let xhr = new XMLHttpRequest();
				xhr.upload.addEventListener('progress', this.progressHandler, false);
				xhr.addEventListener('load', this.onCompleteHandler, false);
				xhr.addEventListener('error', this.onErrorHandler, false);
				xhr.addEventListener('abort', this.onAbortHandler, false);
				xhr.open('POST', this.endpoint);
				if( this.jwt )
					xhr.setRequestHeader('Authorization', 'Bearer ' + this.jwt);
				xhr.send(fdata);
			}
		}
	};
})(SBFramework.Components);