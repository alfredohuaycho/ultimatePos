<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class InvoiceItems extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mb_invoice_items', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->bigInteger('invoice_id');
            $table->bigInteger('product_id');
            $table->string('product_code');
            $table->string('product_name');
            $table->decimal('quantity');
            $table->decimal('price');
            $table->decimal('subtotal');
            $table->decimal('discount');
            $table->decimal('total');
            $table->string('codigo_actividad');
            $table->bigInteger('codigo_producto_sin');
            $table->bigInteger('unidad_medida');
            $table->string('imei')->nullable(true);
            $table->string('numero_serie')->nullable(true);
            $table->text('data');
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
        Schema::dropIfExists('mb_invoice_items');
    }
}
