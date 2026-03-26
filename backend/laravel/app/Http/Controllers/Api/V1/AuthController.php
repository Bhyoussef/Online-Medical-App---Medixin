<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $data = $request->validate([
            'name' => ['required','string','max:120'],
            'email' => ['required','email','unique:users,email'],
            'password' => ['required','string','min:8'],
        ]);

        $user = User::create([
            ...$data,
            'password' => Hash::make($data['password']),
        ]);

        $token = $user->createToken('mobile')->plainTextToken;

        return response()->json(['data' => ['token' => $token, 'user' => $user]], 201);
    }

    public function login(LoginRequest $request)
    {
        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['message' => 'Invalid credentials'], 422);
        }

        $token = $user->createToken('mobile')->plainTextToken;

        return response()->json(['data' => ['token' => $token, 'user' => $user]]);
    }

    public function forgotPassword(Request $request)
    {
        $request->validate(['email' => ['required','email']]);
        return response()->json(['message' => 'Reset code sent']);
    }

    public function resetPassword(Request $request)
    {
        $request->validate([
            'email' => ['required','email'],
            'password' => ['required','confirmed','min:8'],
            'code' => ['required','string'],
        ]);
        return response()->json(['message' => 'Password reset successful']);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()?->delete();
        return response()->json(['message' => 'Logged out']);
    }
}
