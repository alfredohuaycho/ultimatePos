<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Products extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mb_invoice_products', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->bigInteger('user_id');
            $table->string('code');
            $table->string('name');
            $table->string('billing_name')->nullable(true);
            $table->string('description', 512)->nullable(true);
            $table->decimal('price', 10, 2);
            $table->string('barcode')->nullable(true);
            $table->string('serialnumber')->nullable(true);
            $table->string('imei')->nullable(true);
            $table->string('codigo_sin');
            $table->string('codigo_actividad');
            $table->bigInteger('unidad_medida');
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
        Schema::dropIfExists('mb_invoice_products');
    }
}
