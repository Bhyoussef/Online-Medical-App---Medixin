<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('appointments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('patient_id')->constrained('users');
            $table->foreignId('doctor_id')->constrained('doctors');
            $table->string('appointment_no')->unique();
            $table->enum('type', ['hospital', 'online'])->index();
            $table->enum('consult_mode', ['messaging', 'voice', 'video'])->index();
            $table->date('schedule_date')->index();
            $table->time('schedule_start');
            $table->time('schedule_end');
            $table->string('patient_name');
            $table->string('patient_email');
            $table->string('patient_phone', 30);
            $table->string('patient_gender', 20);
            $table->string('patient_age', 40);
            $table->text('visiting_purpose')->nullable();
            $table->enum('status', ['pending', 'confirmed', 'completed', 'cancelled', 'rescheduled'])->default('pending')->index();
            $table->enum('payment_status', ['unpaid', 'paid', 'refunded'])->default('unpaid')->index();
            $table->decimal('total_amount', 10, 2)->default(0);
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('appointments');
    }
};
