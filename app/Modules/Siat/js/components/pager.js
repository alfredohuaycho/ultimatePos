(function(ns)
{
	ns.ComPager = {
		template: `
		<nav id="pagination">
			<ul class="pagination">
				<li class="page-item">
					<a href="javascript:;" class="page-link" v-if="currentPage > 1" v-on:click="previous($event)">
						<span aria-hidden="true">&laquo;</span>
					</a>
				</li>
				<li class="page-item" v-for="index in pagesToShow" v-bind:class="{active: currentPage == index}">
					<a href="javascript:;" class="page-link" v-on:click="openPage(index, $event)">
						{{ index }}
					</a>
				</li>
				<li class="page-item">
					<a href="javascript:;" class="page-link" v-if="currentPage < totalPages" v-on:click="next($event)">
					<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</ul>
		</nav>
		`,
		props: 
		{
			currentPage: {type: Number, required: true, default: 1}, 
			totalPages: {type: Number, required: true}, 
		},
		computed: 
		{
			start: function()
			{
				return ( ( this.currentPage - this.pagesToShow ) > 0 ) ? this.currentPage - this.pagesToShow : 1;
			},
			end: function()
			{
				return ( ( this.currentPage + this.pagesToShow ) < this.totalPages ) ? this.currentPage + this.pagesToShow : this.totalPages;
			}
		},
		data: function()
		{
			return {
				//currentPage: 1,
				pagesToShow: 5,
			};
		},
		methods: 
		{
			openPage: function(page, e)
			{
				this.$emit('pager-change-page', page, this.currentPage);
			},
			previous: function()
			{
				this.$emit('pager-previous-page', this.currentPage - 1, this.currentPage);
			},
			next: function()
			{
				this.$emit('pager-next-page', this.currentPage + 1, this.currentPage);
			}
		},
		mounted: function()
		{
			/*
			if( !this.totalPages )
			{
				this.totalPages = 1;
			}
			else if( parseInt(this.totalPages) < this.pagesToShow )
			{
				this.pagesToShow = parseInt(this.totalPages);
			}
			*/
			this.pagesToShow = this.totalPages;
		},
		created: function()
		{
			
		}
	};
})(SBFramework.Components);