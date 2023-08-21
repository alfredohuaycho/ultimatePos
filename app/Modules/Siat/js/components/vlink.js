let VLink = {
	template: `<a v-bind:href="SBFramework.BASEURL + href" v-bind:class="{ active: isActive }" v-on:click="go($event)"><slot></slot></a>`,
	props: {
		href: {type: String, required: true},
		class: {type: String, required: false},
	},
	computed: 
	{
		isActive()
		{
			return this.href == this.$root.currentRoute;
		}
	},
	methods: 
	{
		go: function(e)
		{
			e.preventDefault();
			SBFramework.Components.Router.Open(this.href);
		}
	}
};
Vue.component('v-link', VLink);