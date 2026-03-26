<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreAppointmentRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'doctor_id' => ['required','exists:doctors,id'],
            'type' => ['required','in:hospital,online'],
            'consult_mode' => ['required','in:messaging,voice,video'],
            'schedule_date' => ['required','date','after_or_equal:today'],
            'schedule_start' => ['required'],
            'schedule_end' => ['required'],
            'patient_name' => ['required','string','max:120'],
            'patient_email' => ['required','email'],
            'patient_phone' => ['required','string','max:30'],
            'patient_gender' => ['required','string','max:20'],
            'patient_age' => ['required','string','max:40'],
            'visiting_purpose' => ['nullable','string'],
        ];
    }
}
