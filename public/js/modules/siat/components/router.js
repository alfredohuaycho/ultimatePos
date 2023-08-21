(function(ns, frame)
{
	ns.Router =  
	{
		app: null,
		routeData: [],
		basePath: frame.BASEPATH,
		routes: frame.Routes || {},
		ParseURL: function(url) 
		{
		    var a = document.createElement('a');
		    a.href = url;
		    return {
		        source: url,
		        protocol: a.protocol.replace(':', ''),
		        host: a.hostname,
		        port: a.port,
		        query: a.search,
		        params: (function () {
		            var ret = {},
		                seg = a.search.replace(/^\?/, '').split('&'),
		                len = seg.length,
		                i = 0,
		                s;
		            for (; i < len; i++) {
		                if (!seg[i]) {
		                    continue;
		                }
		                s = seg[i].split('=');
		                ret[s[0]] = s[1];
		            }
		            return ret;
		        })(),
		        file: (a.pathname.match(/\/([^\/?#]+)$/i) || [, ''])[1],
		        hash: a.hash.replace('#', ''),
		        path: a.pathname.replace(/^([^\/])/, '/$1'),
		        relative: (a.href.match(/tps?:\/\/[^\/]+(.+)/) || [, ''])[1],
		        segments: a.pathname.replace(/^\//, '').split('/')
		    };
		},
		GetCurrentRoute: function()
		{
			if( !this.basePath )
			{
				this.basePath = lt.baseurl.replace(window.location.protocol + '//' + window.location.hostname, '');
			}	
			let route = window.location.pathname.replace(this.basePath, '');
			//console.log('CurrentRoute', route, this.basePath);
			return route;
		},
		GetCom: function(route)
		{
			//##check for query string
			let $url = new URL(route, window.location.origin);
			
			let component = null;
			let current_route = $url.pathname;
			for(let $route of Object.keys(this.routes))
			{
				let $pattern 	= $route.replace('.*', '[a-zA-Z0-9\-.]+');
				let regex 		= new RegExp($pattern, 'g');
				let res 		= regex.exec(current_route);
				if( res )
				{
					component = this.routes[$route];
					res.splice(0, 1);
					ns.Router.routeData = res;
					break;
				}
			}
			if(  !ns.Router.ValidateAccess(component) )
			{
				route 		= ns.Router.Link('/login');
				component	= 'com-login';
			}
			console.log('component', component);
			//console.log(Router.ParseURL(window.location));
			return component;// || 'app-content';
		},
		GetData: function(url)
		{
			let data = ns.Router.ParseURL(url || ns.Router.GetCurrentRoute());
			
			return data;
		},
		Open: function(path)
		{
			let route			= this.basePath + path;
			let component		= ns.Router.GetCom(path);
			if(  !ns.Router.ValidateAccess(component) )
			{
				route = ns.Router.Link('/login');
				component = 'com-login';
			}
			console.log('Open', component, path, ns.Router.routeData);
			this.app.currentRoute 	= path;
			this.app.currentCom		= null; //to avoid state with same component
			this.app.currentCom		= typeof component == 'object' ? component.com : component;
			this.app.comData		= ns.Router.GetData();
			this.app.routeData		= ns.Router.routeData;
			window.history.pushState(null, this.app.currentCom, route);
		},
		Link: function(url)
		{
			//return basePath + url;
			return this.basePath + url;
		},
		ValidateAccess: function(component)
		{
			let res = true;
			if( component && typeof component == 'object' && typeof component.public != 'undefined' )
			{
				if( !component.public )
				{
					let jwt = sessionStorage.getItem('jwt');
					if( !jwt )
					{
						res = false;
					}
				}
			}
			return res;
		}
	};
	window.addEventListener('popstate', () => 
	{
		ns.Router.Open(ns.Router.GetCurrentRoute());
		//app.currentRoute = Router.GetCurrentRoute();
	});
})(SBFramework.Components, SBFramework);