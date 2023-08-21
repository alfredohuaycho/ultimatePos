(function(ns)
{
	let ComCompletion = {
		template: `<div class="com-sb-completion" style="position:relative;">
			<div v-bind:class="containerClass" style="position:relative;">
				<template v-if="!multiple">
					<input class="form-control form-control-solid rounded-pill" id="keyword" type="text" v-bind:placeholder="placeholder"
						 v-model="keyword" v-on:keydown.enter="$event.preventDefault()" v-on:keyup="Search($event)" autocomplete="off" />
					<div style="width:100%;clear:both;"></div>
					<div class="com-completion-results shadow" style="z-index:500;position:absolute;top:100%;width:100%;background:#fff;border:1px solid #ececec;max-height:250px;overflow:auto;" 
						v-bind:style="{display: items.length > 0 ? 'block' : 'none'}">
						<ul style="list-style:none;padding:0;margin:0;">
							<li v-for="(item, index) in items" v-on:click="selectItem(item, index)" style="cursor:pointer;:hover:background:#ececec;padding:6px;border-bottom:1px solid #ececec;">
								<div class="container-fluid p-0">
									<div class="row p-2 no-gutters">
										<div class="col-sm-10">
											<div class="search-item-title">{{ itemText(item) }}</div>
											<div class="search-item-excerpt">{{ itemExcerpt(item) }}</div>
										</div>
									</div>
								</div>
							</li>
						</ul>
					</div>
				</template>
				<template v-else>
					<ul style="min-height:20px;list-style:none;padding:4px;margin:0;border:1px solid #ececec;border-radius:3px;">
						<li v-for="(item, index) in selected" v-bind:key="index" 
							style="display:inline-block;background:cornflowerblue;color:#fff;border-radius:3px;padding:2px 8px;margin:0 5px 5px 0;">
							<span>{{ itemText(item) }}</span>
							<span style="cursor:pointer;" v-on:click="removeSelected(item, index)">X</span>
						</li>
						<li style="display:inline-block;position:relative;">
							<input type="text" v-model="keyword" v-bind:placeholder="placeholder"  v-on:keyup="Search($event)" />
							<div class="com-completion-results shadow" style="position:absolute;top:100%;width:250px;background:#fff;border:1px solid #ececec;max-height:250px;overflow:auto;" 
								v-bind:style="{display: items.length > 0 ? 'block' : 'none'}">
								<ul style="list-style:none;padding:0;margin:0;">
									<li v-for="(item, index) in items" v-on:click="selectItem(item, index)" style="cursor:pointer;:hover:background:#ececec;">
										<div class="container-fluid p-0" style="border-bottom:1px solid #ececec;">
											<div class="row p-2 no-gutters">
												<div class="col-sm-10">
													<div class="search-item-title">{{ itemText(item) }}</div>
													<div class="search-item-excerpt">{{ itemExcerpt(item) }}</div>
												</div>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</li>
					</ul>
				</template>
			</div>
		</div>`,
		props: {
			url: {type:[String, Function], required: true},
			multiple: {type: Boolean, required: false, default: false},
			objprop: {type: String, required: false, default: 'label'},
			descprop: {type: String, required: false, default: ''},
			preselected: {type: Array, required: false, default: this.defaultSelected },
			source: {type: Array, required: false, default: null},
			placeholder: {type: String, required: false, default: 'Enter your email'},
			containerClass: {type: String, required: false, default: 'form-group mb-3'}
		},
		
		data: function()
		{
			return {
				styles: `.com-sb-completion .com-completion-results ul li:hover{background:#ececec;}
				.com-sb-completion .com-completion-results ul li .search-item-excerpt{color:brown;font-size:13px;}
				`,
				showResults: false,
				keyword: '',
				timeout: null,
				items: [],
				selected: (typeof this.preselected != 'undefined' && Array.isArray(this.preselected)) ? this.preselected : [],
				//itemsSelected: preselected,
			};
		},
		watch: 
		{
			preselected: function(nv, ov)
			{
				this.selected = nv;
			}
		},
		methods: 
		{
			defaultSelected()
			{
				return [];	
			},
			itemText: function(item)
			{
				let txt = this._getObjectText(item);
				
				return txt;
			},
			itemExcerpt(item)
			{
				console.log(this.descprop);
				if( !this.descprop )
					return '';
				return item[this.descprop] || '';
			},
			Search: function()
			{
				this.items = [];
				if( this.source == null )
				{	
					if( this.timeout )
						clearTimeout(this.timeout);
					if( this.keyword.length <= 0 )
						return false;
					this.timeout = setTimeout(() => 
					{
						if( typeof this.url == 'function' )
						{
							this.url(this.keyword)
								.then( (res) => 
								{
									console.log('COMPLETION RES:', res);
									this.items = res || [];
								})
								.catch( (e) => 
								{
									console.log('COMPLETION ERROR:', e);
								})	
						}
						else
						{
							let headers = {};
							let token = localStorage.getItem('token');
							if( token )
							{
								headers['Authorization'] = 'Bearer ' + token;
							}
							let ops = {
								method: 'GET',
								body: null,
								mode: 'cors',
								cache: 'no-cache',
								headers: headers,
								//credentials: 'include', //'omit'
							};
							let url = this.url + '?keyword=' + this.keyword;
							fetch(url, ops)
								.then( (r) => 
								{
									//this.items = res.data;
									r.json().then( (res) => 
									{
										this.items = res.data;
									});
								})
								.catch( (e) => 
								{
									console.log(e);
								});
						}
					}, 400);
				}
				else
				{
					console.log(this.source);
					for(let s of this.source)
					{
						let txt = this._getObjectText(s);
						if( txt.toUpperCase().indexOf(this.keyword.toUpperCase()) != -1 )
							this.items.push(s);
					}
				}
			},
			selectItem: function(item, index)
			{
				this.selected.push(item);
				this.items = [];
				if( this.multiple )
					this.keyword = '';
				else
				{
					this.keyword = this._getObjectText(item);
				}
				this.$emit('item-selected', item, index);
			},
			removeSelected: function(item, index)
			{
				this.selected.splice(index, 1);
				this.$emit('item-deselected', item, index);
			},
			_getObjectText(obj)
			{
				let txt = '';
				if( !obj )
					return txt;
				for(let prop of this.objprop.split('|'))
				{
					txt += typeof obj[prop] != 'undefined' ? (obj[prop]) : '';
					txt += ' ';
				}
				
				return txt;	
			},
			_addCss()
			{
				let link = document.head.querySelector('vue-completion');
				if( link )
					return;
				link = document.createElement('style');
				link.rel = 'stylesheet';
				link.innerHTML = this.styles;
				document.head.appendChild(link);
			}
		},
		mounted: function()
		{
			
			document.addEventListener('click', (e) => 
			{
				if( !e.target.classList.contains('form-search-container') && !e.target.classList.contains('search-keyword') )
				{
					this.showResults = false;
				}
			});
			
			if( !this.multiple )
			{
				this.keyword = this._getObjectText(this.selected[0]);
			}
		},
		created: function()
		{
			this._addCss();
		}
	};
	if( typeof module != 'undefined' )
		module.exports = ComCompletion;
	else
		ns.ComCompletion = ComCompletion;
})(typeof SBFramework != 'undefined' ? SBFramework.Components : window);