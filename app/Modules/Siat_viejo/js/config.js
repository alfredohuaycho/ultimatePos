window.vueapp = '#sb-app';
window.langs = [];
window.SBFramework = {
	BASEURL:		lt.baseurl,
	BASEPATH:		'',
	TEMPLATE_URL:	lt.baseurl + '/admin/templates/uglys',
	APIBASE:		lt.baseurl + '/api',
	Mixins:			{},
	Models: 		{},
	Classes: 		{},
	Components: 	{},
	AppComponents:	{}, //vue app initial components
	AppData:		{}, //vue app initial data
	Plugins:		{},
	Data: 			{},
	Translations: 	[],
	tmessages:		{},
	Routes:			{},
	Hooks: 			{
		'menu': [],
		'top_menu': []
	},
	Services:		{},
	Functions:		{
		getQueryParameter(param, defVal)
		{
			let parts = window.location.href.split('?');
			if( typeof parts[1] == 'undefined' )
				return defVal;
			let $value = defVal;
			
			let valKey = parts[1].split('&');
			for(let pair of valKey)
			{
				let kv = pair.split('=');
				if( kv[0] == param )
				{
					$value = typeof kv[1] != 'undefined' ? kv[1] : '';
					break; 
				}
			}
			
			return $value;
		},
		async getAdminToken()
		{
			let res = await fetch(SBFramework.BASEURL +  '/admin/index.php?mod=users&task=token');
			let data = await res.json();
			if( !res.ok )
				throw data;
			localStorage.setItem('token', data.data);
		}
	}
};
function __(key)
{
	if( typeof SBFramework.tmessages == 'undefined' )
		return key;
	if( typeof SBFramework.tmessages[key] == 'undefined' )
		return key;
	
	return SBFramework.tmessages[key];
}