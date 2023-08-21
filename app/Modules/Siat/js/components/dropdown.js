(function(ns)
{
	ns.ComDropdown = {
		template: `<div class="sb-dropdown" style="position:relative;">
			<input type="hidden" v-bind:id="id" v-bind:name="id" v-bind:value="value" v-on:input="$emit('input', $event.target.value)" />
			<div ref="control" class="form-group mb-2 input-group">
				<input type="text" autocomplete="off" class="form-control" v-bind:placeholder="placeholder" v-model="keyword" 
					v-on:keyup="search"
					v-on:blur="onBlur"
					style="background:inherit;" />
				<span class="input-group-text" style="padding:0;">
					<button type="button" class="btn btn-sm dropdown-toggle" v-on:click="showOptions()"></button>
				</span>
			</div>
			<div v-bind:ref="'dropdown' + 1" class="sb-dropdown-options shadow border list-group"
				style="text-align:left;background:#fff;position:absolute;z-index:90;width:100%;overflow:auto;"
				v-bind:style="{top: ops_top, height: ops_height + 'px'}"
				v-if="items.length > 0 && is_open">
				<template v-for="(op, opi) in items" >
					<div v-on:click="onSelected(op, opi)" class="list-group-item list-group-item-action" style="cursor:pointer;">
						{{ op.text }}
					</div>
				</template>
			</div>
		</div>`,
		props: {
			value: {default: ''},
			id: {type: String, default: 'drodown_name'},
			placeholder: {type: String, default: 'Search...'},
			options: {type: Array, default: []},
			limit: {type: Number, default: 10},
		},
		data()
		{
			return {
				selected_value: '',
				keyword: '',
				items: [],
				is_open: false,
				ops_top: '100%',
				ops_height: 200,
			};
		},
		methods: 
		{
			onSelected(option, index)
			{
				console.log('onSelected', option, index);
				this.selected_value = option.value;
				//this.value = option.value;
				this.$emit('input', option.value);
				this.keyword = option.text;
				this.items = [];
				this.is_open = false;
			},
			onBlur($event)
			{
				setTimeout(() => {
					//console.log($event, $event.explicitOriginalTarget);
					this.items = [];
					this.is_open = false;
					this.setCurrentByValue(this.value);	
				}, 500);
				
			},
			showOptions()
			{
				this.items = [];
				if( this.is_open )
				{
					this.is_open = false;
					return;
				}
				for(let op of this.options)
					this.items.push(op);
				this.is_open = true;
			},
			search()
			{
				this.items = [];
				if( !this.keyword )
				{
					this.is_open = false;
					//this.setCurrentByValue(this.value);
					return false;
				}
				this.items = this.options.filter( (op) => op.text.toLowerCase().indexOf(this.keyword.toLowerCase()) != -1 );
				//console.log(this.items);
				this.is_open = true;
				this.checkSizes();
			},
			setCurrentByValue($value)
			{
				let current_option = this.options.find( op => op.value.toString() == $value.toString());
				if( typeof current_option != 'undefined' )
				{
					this.keyword = current_option.text;
				}
			},
			checkSizes()
			{
				//setTimeout(() => 
				//{
					const rect = this.$refs.control.getBoundingClientRect();
					//console.log(window.innerHeight, rect);
					if( (rect.y + rect.height + this.ops_height) >= window.innerHeight )
					{
						this.ops_top = '-' + (this.ops_height) + 'px';
					}
					else
					{
						this.ops_top = '100%';
					}
					//this.is_open = true;
				//}, 500);
				
			}
		},
		mounted()
		{
			if( this.value )
			{
				setTimeout(() => {
					this.setCurrentByValue(this.value)					
				}, 1000)
				this.checkSizes();
			}
		},
		created()
		{
		}
	};
	
})(SBFramework.Components);