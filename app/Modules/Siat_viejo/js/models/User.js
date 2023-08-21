(function(ns){
	class User extends SBFramework.Models.Model
	{
		constructor()
		{
			super();
			
			this.user_id = 0;
			this.avatar = '';
			this.creation_date = '';
			this.email			= '';
			this.first_name		= '';
			this.last_name		= '';
			this.meta			= {};
			this.username		= '';
			this.pwd			= '';
			this.role_id		= '';
			this.status			= '';
			this.store_id		= 0;
			this.permissions	= [];
		}
		isRoot()
		{
			if( this.username === 'root' && this.role_id === 0  )
				return true;
			return false;
		}
		can(permission)
		{
			if( this.isRoot() )
				return true;
			if( !Array.isArray(this.permissions) )
				return false;
			return this.permissions.indexOf(permission) == -1 ? false : true;
		}
		canArray($perms)
		{
			let res = true;
			if( !$perms )
				return res;
				
			for(let p of $perms)
			{
				res = this.can(p);
				if( !res )
					break;
			}
			return res;
		}
		get fullname()
		{
			return this.first_name + ' ' + this.last_name;
		}
		set fullname(v)
		{
			let parts = v.split(' ');
			console.log(parts);
			this.first_name = parts[0].trim();
			this.last_name	= typeof parts[1] != 'undefined' ? parts[1].trim() : '';
		}
		
	}
	ns.User = User;
})(SBFramework.Models);