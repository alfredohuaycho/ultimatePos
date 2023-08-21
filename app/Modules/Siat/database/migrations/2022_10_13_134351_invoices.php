<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Invoices extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mb_invoices', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->bigInteger('user_id');
            $table->bigInteger('customer_id');
            $table->bigInteger('event_id')->nullable(true);
            $table->bigInteger('package_id')->nullable(true);
            $table->integer('codigo_sucursal');
            $table->integer('codigo_puntoventa');
            $table->integer('codigo_documento_sector');
            $table->integer('tipo_emision');
            $table->integer('tipo_factura_documento');
            $table->integer('tipo_documento_identidad');
            $table->integer('codigo_metodo_pago');
            $table->integer('codigo_moneda');
            $table->bigInteger('nit_emisor');
            $table->string('customer');
            $table->string('nit_ruc_nif');
            $table->string('complemento')->nullable(true);
            $table->double('subtotal');
            $table->double('discount');
            $table->double('tax');
            $table->double('total');
            $table->double('giftcard_amount')->default(0);
            $table->bigInteger('invoice_number');
            $table->bigInteger('invoice_number_cafc')->nullable(true);
            $table->string('control_code');
            $table->string('cuf');
            $table->string('cufd');
            $table->string('cafc')->nullable(true);
            $table->string('numero_tarjeta')->nullable(true);
            $table->dateTime('invoice_datetime');
            $table->double('tipo_cambio');
            $table->string('siat_id')->nullable(true);
            $table->string('leyenda');
            $table->tinyInteger('excepcion');
            $table->text('data');
            $table->string('status');
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
        Schema::dropIfExists('mb_invoices');
    }
}
