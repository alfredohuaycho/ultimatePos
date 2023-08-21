<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class MassiveBatches extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mb_massive_batches', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->bigInteger('codigo_sucursal');
            $table->bigInteger('codigo_puntoventa');
            $table->bigInteger('codigo_documento_sector');
            $table->bigInteger('tipo_factura_documento');
            $table->bigInteger('cantidad');
            $table->string('codigo_recepcion')->nullable(true);
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
        Schema::dropIfExists('mb_massive_batches');
    }
}
