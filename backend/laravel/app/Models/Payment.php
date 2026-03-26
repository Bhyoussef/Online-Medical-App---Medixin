<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    protected $fillable = [
        'appointment_id','patient_id','method_id','voucher_id','amount',
        'discount_amount','final_amount','provider_txn_id','status','paid_at'
    ];
}
