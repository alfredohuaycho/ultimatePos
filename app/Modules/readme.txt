1. Ejecutar las migraciones
============================

php artisan migrate --path=app/Modules/Siat/database/migrations

2. Adicionar el Provider en el archivo config/app.php
=========================================================

Adicionar la siguiente linea, al final del contenido del indice 'providers'

    	App\Modules\Siat\SiatProvider::class,
    	

3. Adicionar el Middle para el menu en el archivo app/Http/Kernel.php
=========================================================

Adicionar la siguiente linea a el arreglo $middlewareGroups

\App\Modules\Siat\Middleware\SiatSidebarMenu::class,


4. ContactController.php
	linea: 924
