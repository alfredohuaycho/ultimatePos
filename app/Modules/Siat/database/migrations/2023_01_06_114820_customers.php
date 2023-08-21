<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Customers extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mb_customers', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('external_id')->nullable(true);
            $table->bigInteger('user_id');
            $table->string('code')->nullable(true);
            $table->string('firstname')->nullable(true);
            $table->string('lastname');
            $table->string('identity_document')->nullable(true);
            $table->string('nit_ruc_nif')->nullable(true);
            $table->string('phone')->nullable(true);
            $table->string('email')->nullable(true);
            $table->string('address')->nullable(true);
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
        Schema::dropIfExists('mb_customers');
    }
}
