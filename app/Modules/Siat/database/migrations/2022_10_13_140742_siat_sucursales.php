<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class SiatSucursales extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mb_siat_sucursales', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('code');
            $table->string('name');
            $table->string('address', 512);
            $table->string('city', 128);
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
        Schema::dropIfExists('mb_siat_sucursales');
    }
}
