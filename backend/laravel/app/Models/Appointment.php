<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Appointment extends Model
{
    protected $fillable = [
        'patient_id','doctor_id','appointment_no','type','consult_mode','schedule_date',
        'schedule_start','schedule_end','patient_name','patient_email','patient_phone',
        'patient_gender','patient_age','visiting_purpose','status','payment_status','total_amount'
    ];

    public function patient(): BelongsTo { return $this->belongsTo(User::class, 'patient_id'); }
    public function doctor(): BelongsTo { return $this->belongsTo(Doctor::class); }
    public function payment(): HasOne { return $this->hasOne(Payment::class); }
}
