<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class SiatEvents extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mb_siat_events', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->bigInteger('user_id');
            $table->bigInteger('evento_id');
            $table->integer('codigo_sucursal');
            $table->integer('codigo_puntoventa');
            $table->string('codigo_recepcion')->nullable(true);
            $table->string('descripcion')->nullable(true);
            $table->dateTime('fecha_inicio');
            $table->dateTime('fecha_fin')->nullable(true);
            $table->string('cufd', 512)->nullable(true);
            $table->string('cufd_evento', 512);
            $table->string('codigo_recepcion_paquete')->nullable(true);
            $table->string('estado_recepcion')->nullable(true);
            $table->string('estado');
            $table->text('data')->nullable(true);
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
        Schema::dropIfExists('mb_siat_events');
    }
}
