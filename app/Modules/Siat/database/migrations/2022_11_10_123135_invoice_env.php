<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class InvoiceEnv extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('mb_invoices', function (Blueprint $table) {
            //
        	$table->tinyInteger('cafc_numero')->nullable();
            $table->tinyInteger('ambiente');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('mb_invoices', function (Blueprint $table) {
            //
        });
    }
}
