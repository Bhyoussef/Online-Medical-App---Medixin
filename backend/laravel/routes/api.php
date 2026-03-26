<?php

use App\Http\Controllers\Api\V1\AppointmentController;
use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\DoctorController;
use App\Http\Controllers\Api\V1\InboxController;
use App\Http\Controllers\Api\V1\NotificationController;
use App\Http\Controllers\Api\V1\PaymentController;
use App\Http\Controllers\Api\V1\ProfileController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {
    Route::post('/auth/register', [AuthController::class, 'register']);
    Route::post('/auth/login', [AuthController::class, 'login']);
    Route::post('/auth/forgot-password', [AuthController::class, 'forgotPassword']);
    Route::post('/auth/reset-password', [AuthController::class, 'resetPassword']);

    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/auth/logout', [AuthController::class, 'logout']);

        Route::get('/profile', [ProfileController::class, 'show']);
        Route::put('/profile', [ProfileController::class, 'update']);

        Route::get('/doctors', [DoctorController::class, 'index']);
        Route::get('/doctors/{doctor}', [DoctorController::class, 'show']);

        Route::get('/appointments', [AppointmentController::class, 'index']);
        Route::post('/appointments', [AppointmentController::class, 'store']);
        Route::get('/appointments/{appointment}', [AppointmentController::class, 'show']);
        Route::patch('/appointments/{appointment}/cancel', [AppointmentController::class, 'cancel']);

        Route::get('/payments/methods', [PaymentController::class, 'methods']);
        Route::post('/payments/voucher/preview', [PaymentController::class, 'previewVoucher']);
        Route::post('/payments/checkout', [PaymentController::class, 'checkout']);
        Route::post('/payments/{payment}/confirm', [PaymentController::class, 'confirm']);

        Route::get('/notifications', [NotificationController::class, 'index']);
        Route::patch('/notifications/read-all', [NotificationController::class, 'markAllRead']);
        Route::delete('/notifications/clear', [NotificationController::class, 'clear']);

        Route::get('/inbox/threads', [InboxController::class, 'threads']);
        Route::get('/inbox/threads/{thread}/messages', [InboxController::class, 'messages']);
        Route::post('/inbox/threads/{thread}/messages', [InboxController::class, 'send']);
    });
});
