<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class SiatCufd extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mb_siat_cufd', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('codigo');
            $table->string('codigo_control');
            $table->string('direccion');
            $table->integer('codigo_sucursal');
            $table->integer('codigo_puntoventa');
            $table->dateTime('fecha_vigencia');
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
        Schema::dropIfExists('mb_siat_cufd');
    }
}
