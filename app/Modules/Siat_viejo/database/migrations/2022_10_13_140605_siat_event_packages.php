<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class SiatEventPackages extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mb_siat_event_packages', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->bigInteger('event_id');
            $table->bigInteger('invoice_type');
            $table->integer('sector_document');
            $table->string('reception_code');
            $table->string('reception_status');
            $table->dateTime('reception_date');
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
        Schema::dropIfExists('mb_siat_event_packages');
    }
}
