<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Doctor;
use Illuminate\Http\Request;

class DoctorController extends Controller
{
    public function index(Request $request)
    {
        $q = Doctor::query()->with(['user','specialty'])->where('is_active', true);

        if ($search = $request->string('search')->toString()) {
            $q->whereHas('user', fn($x) => $x->where('name', 'like', "%$search%"));
        }

        if ($specialtyId = $request->integer('specialty_id')) {
            $q->where('specialty_id', $specialtyId);
        }

        return response()->json($q->paginate(15));
    }

    public function show(Doctor $doctor)
    {
        return response()->json(['data' => $doctor->load(['user','specialty'])]);
    }
}
