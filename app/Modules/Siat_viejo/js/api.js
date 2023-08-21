(function(ns)
{
	class Api
	{
		constructor()
		{
			this.apiBase = SBFramework.BASEURL + '';
		}
		GetToken(username, pwd)
		{
			let endpoint = this.apiBase + '/v1.0.0/users/get-token/'; //Router.Link('/api/v1.0.0/users/get-token/');
			let data = JSON.stringify({username: username, password: pwd});
			//console.log(endpoint, data);
			let ops = {
				method: 'POST',
				body: data,
				mode: 'cors',
				cache: 'no-cache',
				credentials: 'omit',
				headers: {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*',}
			};
			return new Promise( (resolve, reject) => 
			{
				fetch(endpoint, ops)
					.then( (r) => 
					{
						//if( r.status != 200 )
						if( !r.ok )
						{
							throw r;
						}
						return r.json();
					})
					.then( (data) => 
					{
						resolve(data);
					})
					.catch( (e) => 
					{
						e.json().then( (data) => 
						{
							reject(data);
						});
					});
			});
		}
		Request(endpoint, method, data, $headers)
		{
			let headers = {
				'X-Requested-With': 'XMLHttpRequest',
				'Content-Type': 'application/json',
				//'Access-Control-Allow-Origin': '*',
				//'Origin': 'https://localhost'
			};
			let token = localStorage.getItem('token');
			if( token )
			{
				headers['Authorization'] = 'Bearer ' + token;
			}
			if( typeof $headers == 'object' )
			{
				for(let key in $headers)
				{
					headers[key] = $headers[key];
				}
			}
			let ops = {
				method: method,
				body: data ? JSON.stringify(data) : null,
				mode: 'cors',
				cache: 'no-cache',
				headers: headers,
				credentials: 'include', //'omit'
			};
			return new Promise( (resolve, reject) => 
			{
				let $res = null;
				
				fetch(endpoint, ops)
				.then( (r) => 
				{
					$res = r;
					//if( r.status != 200 )
					if( !r.ok )
					{
						throw r;
					}
					return r.json();
				})
				.then( (data) => 
				{
					data.response = $res;
					data.headers = $res.headers;
					resolve(data);
				})
				.catch( (e) => 
				{
					console.log('ERROR', e);
					if( !e || !e.json )
					{
						reject({error: 'Error desconocido'}, $res);
						return;
					}
					e.json().then( (data) => 
					{
						reject(data, $res);
					});
				});
			});
		}
		Get(endpoint, headers)
		{
			return this.Request(this.apiBase + endpoint, 'GET', null, headers);
		}
		Post(endpoint, data, headers)
		{
			return this.Request(this.apiBase + endpoint, 'POST', data, headers);
		}
		Put(endpoint, data, headers)
		{
			return this.Request(this.apiBase + endpoint, 'PUT', data, headers);
		}
		Delete(endpoint)
		{
			return this.Request(this.apiBase + endpoint, 'DELETE');
		}
		async Upload(endpoint, formData)
		{
			const headers = {
				//'Content-Type': 'multipart/form-data',
			};
			let token = localStorage.getItem('token');
			if( token )
			{
				headers['Authorization'] = 'Bearer ' + token;
			}
			const ops = {
				method: 'POST',
				body: formData,
				mode: 'cors',
				cache: 'no-cache',
				headers: headers,
			};
			const res = await fetch(this.apiBase + endpoint, ops);
			if( !res.ok )
				throw res;
			const json = await res.json();
			return json;
			
		}
	}
	ns.Api = Api;
})(SBFramework.Classes);