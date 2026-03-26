<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreAppointmentRequest;
use App\Models\Appointment;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class AppointmentController extends Controller
{
    public function index(Request $request)
    {
        $tab = $request->string('tab', 'upcoming')->toString();
        $q = Appointment::query()->with('doctor.user')->where('patient_id', $request->user()->id);

        if ($tab === 'past') {
            $q->whereIn('status', ['completed','cancelled']);
        } else {
            $q->whereIn('status', ['pending','confirmed','rescheduled']);
        }

        return response()->json($q->latest()->paginate(15));
    }

    public function store(StoreAppointmentRequest $request)
    {
        $appointment = Appointment::create([
            ...$request->validated(),
            'patient_id' => $request->user()->id,
            'appointment_no' => strtoupper(Str::random(10)),
            'status' => 'pending',
            'payment_status' => 'unpaid',
            'total_amount' => 20,
        ]);

        return response()->json(['data' => $appointment], 201);
    }

    public function show(Appointment $appointment)
    {
        return response()->json(['data' => $appointment->load('doctor.user')]);
    }

    public function cancel(Appointment $appointment)
    {
        $appointment->update(['status' => 'cancelled']);
        return response()->json(['data' => $appointment]);
    }
}
