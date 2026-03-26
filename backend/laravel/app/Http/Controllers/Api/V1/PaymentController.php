<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Payment;
use App\Models\PaymentMethod;
use App\Models\Voucher;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    public function methods()
    {
        return response()->json(['data' => PaymentMethod::where('is_active', true)->get()]);
    }

    public function previewVoucher(Request $request)
    {
        $request->validate(['code' => ['required','string']]);
        $voucher = Voucher::where('code', $request->code)->where('is_active', true)->first();

        if (!$voucher) {
            return response()->json(['message' => 'Invalid voucher'], 422);
        }

        return response()->json(['data' => ['code' => $voucher->code, 'type' => $voucher->type, 'value' => $voucher->value]]);
    }

    public function checkout(Request $request)
    {
        $data = $request->validate([
            'appointment_id' => ['required','exists:appointments,id'],
            'method_id' => ['required','exists:payment_methods,id'],
            'voucher_id' => ['nullable','exists:vouchers,id'],
        ]);

        $payment = Payment::create([
            ...$data,
            'patient_id' => $request->user()->id,
            'amount' => 20,
            'discount_amount' => 5,
            'final_amount' => 15,
            'status' => 'initiated',
        ]);

        return response()->json(['data' => $payment], 201);
    }

    public function confirm(Payment $payment)
    {
        $payment->update(['status' => 'success', 'paid_at' => now()]);
        return response()->json(['data' => $payment]);
    }
}
