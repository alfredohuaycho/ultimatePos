(function(ns)
{
	ns.Common = 
	{
		methods: 
		{
			openModal($modal)
			{
				if( $modal.show )
				{
					$modal.show();
					
					return true;
				}
				jQuery($modal).modal('show');
			},
			closeModal($modal)
			{
				if( $modal.modal )
				{
					jQuery($modal).modal('hide');
					return true;
				}
				$modal.hide();
			}
		}
	};
})(SBFramework.Mixins);