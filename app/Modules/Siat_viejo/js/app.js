(async function(appEl, langs, lang)
{
	let app = null;
	let $api = new SBFramework.Classes.Api();
	$api.apiBase = SBFramework.APIBASE;
	function loadApp(selector, _user)
	{
		const appcoms = Object.assign({
			'com-processing': SBFramework.Components.ComProcessing,
			'com-menu': SBFramework.Components.ComMenu,
		}, SBFramework.AppComponents || {});
		let vue_app = new Vue({
			el: selector,
			components: appcoms,
			data: Object.assign({
				ready: false,
		    	api: $api,
				/*
				user: new SBFramework.Models.User(),
				currentRoute: SBFramework.Components.Router.GetCurrentRoute(),
				currentCom: (function()
				{
					let component = SBFramework.Components.Router.GetCom(SBFramework.Components.Router.GetCurrentRoute());
					
					return (component != null && typeof component == 'object') ? component.com : component;
				})(),
				comData: SBFramework.Components.Router.GetData(),
				routeData: SBFramework.Components.Router.routeData,
				*/
				user: Object.assign(new SBFramework.Models.User(), _user),
				currentRoute: null,
				currentCom: null,
				comData: null,
				routeData: null,
				com_title: '',
				com_subtitle: '',
				com_icon: '',
				company: {},
				supabase: null,
			}, SBFramework.AppData || {}),
			computed: 
			{
				com_current: function()
				{
					//this.CheckSession();
					return this.currentCom;
				},
				com_args: function()
				{
					//let data = Router.ParseURL(this.currentRoute);
					return this.routeData;
				},
				com_key: function()
				{
					return this.currentCom + Date.now();
				},
				top_menu_coms: function()
				{
					return SBFramework.Hooks.top_menu;
				}
			},
			methods:
			{
				CheckSession: function()
				{
					
				},
				toggleSidebar(e)
				{
					e.preventDefault();
					document.body.classList.toggle("sidenav-toggled");
				},
				
			},
			mounted()
			{
				//##check if router component is loaded
				if( SBFramework.Components.Router )
				{
					this.currentRoute 	= SBFramework.Components.Router.GetCurrentRoute();
					let component 		= SBFramework.Components.Router.GetCom(this.currentRoute);
					this.currentCom 	= (component != null && typeof component == 'object') ? component.com : component;
					this.comData = SBFramework.Components.Router.GetData();
					this.routeData = SBFramework.Components.Router.routeData;
				}
				
				this.ready = true;
				this.$emit('app-ready');
				if( this.$refs.com_container )
					this.$refs.com_container.classList.add('show')
			},
			created: async function()
			{
				if( SBFramework.Components.Router )
					SBFramework.Components.Router.app = this;
				
				//Object.assign(this.user, pres.data);
				window.onload = function()
				{
					for(let i = 0; i < SBFramework.Hooks.menu.length; i++)
					{
						if( SBFramework.Hooks.menu[i].childs.length <= 0 )
							SBFramework.Hooks.menu.splice(i, 1);
					}
				}
			}
		});
		return vue_app;
	}
	async function loadLanguage(urls, lang)
	{
		let promises = [];
		for(let url of urls)
		{
			promises.push(
				new Promise( (resolve, reject) => 
				{
					let ls = document.createElement('script');
					ls.src = url;
					ls.onload = function()
					{
						resolve(url);
					};
					document.head.appendChild(ls);
				})
			);
		}
		let res = await Promise.all(promises);
		return res;
	}
	function setMenus()
	{
		SBFramework.Hooks.menu = [
			{
				type: 'main',
				name: __('Home'),
				key: 'home',
				childs: [],
			},
			{
				type: 'main',
				name: __('Management'),
				key: 'management',
				permission: ['manage_backend'],
				childs: []
			},
			{
				type: 'main',
				name: __('Settings'),
				key: 'settings',
				childs: []
			}
		];
	}
	try
	{
		await loadLanguage(langs, lang);
		setMenus();
		//console.log('isAdmin', window.location.href.indexOf('/admin/'));
		/*
		let tokenUrl = SBFramework.BASEURL +  '/index.php?mod=users&task=token';
		if( window.location.href.indexOf('/admin/') != -1 )
			tokenUrl = SBFramework.BASEURL +  '/admin/index.php?mod=users&task=token';
			
		let res = await fetch(tokenUrl);
		let data = await res.json();
		let pres = null;
		if( res.ok )
		{
			localStorage.setItem('token', data.data);
			sessionStorage.setItem('jwt', data.data);
			pres = await $api.Request(SBFramework.BASEURL + '/api/users/profile', 'GET');
		}
		*/
		app = loadApp(appEl, {});
	}
	catch(e)
	{
		console.log('VUE APP ERROR', e);
		console.trace();
	}
})(window.vueapp || '#sb-app', SBFramework.Translations || window.langs || [], lt.lang);