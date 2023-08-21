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
            $table->string('reception_code')->nullable(true);
            $table->string('reception_status')->nullable(true);
            $table->dateTime('reception_date')->nullable(true);
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
        Schema::dropIfExists('mb_siat_event_packages');
    }
}
