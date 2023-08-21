<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class ProductFields extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
    	if( !Schema::hasTable('products') )
    		return false;
        Schema::table('products', function (Blueprint $table) {
            //
            $table->bigInteger('unidad_medida');
            $table->string('actividad_economica');
            $table->bigInteger('codigo_producto_sin');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('products', function (Blueprint $table) {
            //
        });
    }
}
