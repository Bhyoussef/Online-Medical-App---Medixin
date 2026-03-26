<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class ProfileController extends Controller
{
    public function show(Request $request)
    {
        return response()->json(['data' => $request->user()]);
    }

    public function update(Request $request)
    {
        $data = $request->validate([
            'name' => ['required','string','max:120'],
            'phone' => ['nullable','string','max:30'],
            'gender' => ['nullable','string','max:20'],
            'dob' => ['nullable','date'],
            'avatar_url' => ['nullable','url'],
        ]);

        $request->user()->update($data);

        return response()->json(['data' => $request->user()->fresh()]);
    }
}
