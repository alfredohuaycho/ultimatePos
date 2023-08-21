Vue.component('datepicker', 
{
    template: `<div style="position:relative;">
		<input type="text" />
		<i class="fa fa-calendar" style="position:absolute;right:8px;top:8px;"></i>
	</div>`,
    props: ['value', 'class', 'placeholder', 'format'],
	data()
	{
		return {
			field: null,
		};	
	},
	watch: 
	{
        value: function (value) {
            this.$el.children[0].value = value;
        }
    },
    mounted: function () 
    {
		this.field = this.$el.children[0];
		this.field.classList.add(this.$el.className);
		this.$el.className = '';
		
        var self = this;
        $(self.$el.children[0])                    
            .datetimepicker({ minDate: this.min_date, value: this.value, format: this.format || 'yyyy-mm-dd', 
				startView: 2, minView: 2, autoclose: 1, 
			}) // init datepicker
            .trigger('change')                    
            .on('change', function () { // emit event on change.
                self.$emit('input', this.value);
				self.$emit('change', this.value);
            });
		if( this.value )
			this.$el.children[0].value = this.value;
    },
	created()
	{
		
	},
    destroyed: function () {
        $(this.$el).datepicker('destroy');
    }
});