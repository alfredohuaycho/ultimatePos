<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class SiatPuntosVenta extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mb_siat_puntos_venta', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('codigo');
            $table->integer('codigo_sucursal');
            $table->string('nombre');
            $table->integer('tipo_id');
            $table->string('tipo');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('mb_siat_puntos_venta');
    }
}
