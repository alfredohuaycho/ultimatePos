<!doctype html>
<html>
<head>
	<!-- CSRF Token -->
	<meta name="csrf-token" content="{{ csrf_token() }}" />
	<meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>SIAT Demo</title>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous" />
	<style>
	#siat-menu ul{list-style:none;padding:0;margin:0;}
	#siat-menu ul li{}
	#siat-menu ul li a{display:block;text-decoration:none;padding:4px 6px;}
	#siat-menu ul li a:hover{background:#ececec;}
	</style>
</head>
<body>
<div class="container-fluid">
	<div class="row">
		<div class="col-12 col-sm-2">
			<aside>
				<h2>Menu</h2>
				@includeIf('Siat::menu.siat')
			</aside>
		</div>
		<div class="col-12 col-sm-10">
			<div id="content">
				@yield('content')
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
@stack('javascript')
</body>
</html>
