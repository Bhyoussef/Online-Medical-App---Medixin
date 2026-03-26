<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('specialties', function (Blueprint $table) {
            $table->id();
            $table->string('name')->unique();
            $table->string('icon')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('doctors', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('specialty_id')->constrained('specialties');
            $table->string('license_no')->unique();
            $table->text('bio')->nullable();
            $table->integer('experience_years')->default(0);
            $table->decimal('consultation_fee_chat', 10, 2)->default(0);
            $table->decimal('consultation_fee_voice', 10, 2)->default(0);
            $table->decimal('consultation_fee_video', 10, 2)->default(0);
            $table->string('city')->index();
            $table->string('country')->index();
            $table->decimal('rating_avg', 3, 2)->default(0);
            $table->integer('rating_count')->default(0);
            $table->boolean('is_active')->default(true)->index();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('doctors');
        Schema::dropIfExists('specialties');
    }
};
