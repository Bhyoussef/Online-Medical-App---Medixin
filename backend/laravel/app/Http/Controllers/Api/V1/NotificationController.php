<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class NotificationController extends Controller
{
    public function index(Request $request)
    {
        return response()->json($request->user()->notifications()->latest()->paginate(20));
    }

    public function markAllRead(Request $request)
    {
        $request->user()->notifications()->update(['is_read' => true, 'read_at' => now()]);
        return response()->json(['message' => 'All notifications marked as read']);
    }

    public function clear(Request $request)
    {
        $request->user()->notifications()->delete();
        return response()->json(['message' => 'Notifications cleared']);
    }
}
