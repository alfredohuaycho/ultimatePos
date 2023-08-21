(function(ns)
{
	class Model
	{
		constructor()
		{
			this.meta_col_id = '';
			this.meta = [];
		}
		getMeta(meta_key)
		{
			if( this.meta == null )
			{
				this.meta = [];
				return null;
			}	
				
			let $meta = null;
			if( Array.isArray(this.meta) )
			{
				for( let m of this.meta)
				{
					if( m.meta_key == meta_key )
					{
						$meta = m;
						break;
					}
				}
			}
			else
			{
				/*
				$meta = {
					meta_key: meta_key,
					meta_value: this.meta[meta_key] || null,
				};
				$meta[this.meta_col_id] = null;
				*/
			}
			return $meta;
		}
		setMeta(key, val)
		{
			if( !Array.isArray(this.meta) )
				this.meta = [];
			let meta = this.getMeta(key);
			if( !meta )
			{
				meta = {
					id:	 		null,
					meta_key: 	key,
					meta_value: val
				};
				meta[this.meta_col_id] = this.id || this[this.meta_col_id];
				console.log(meta);
				this.meta.push(meta);
				return true;
			}	
			meta.meta_value = val;
			return true;
		}
	}
	ns.Model = Model;
})(SBFramework.Models);