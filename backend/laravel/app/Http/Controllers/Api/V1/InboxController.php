<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\ConversationThread;
use App\Models\Message;
use Illuminate\Http\Request;

class InboxController extends Controller
{
    public function threads(Request $request)
    {
        $threads = ConversationThread::query()
            ->where('patient_id', $request->user()->id)
            ->latest('last_message_at')
            ->paginate(20);

        return response()->json($threads);
    }

    public function messages(Request $request, ConversationThread $thread)
    {
        $messages = Message::where('thread_id', $thread->id)->latest('sent_at')->paginate(50);
        return response()->json($messages);
    }

    public function send(Request $request, ConversationThread $thread)
    {
        $data = $request->validate([
            'type' => ['required','in:text,image,file'],
            'body' => ['nullable','string'],
            'media_url' => ['nullable','url'],
        ]);

        $message = Message::create([
            'thread_id' => $thread->id,
            'sender_id' => $request->user()->id,
            'type' => $data['type'],
            'body' => $data['body'] ?? null,
            'media_url' => $data['media_url'] ?? null,
            'sent_at' => now(),
        ]);

        $thread->update(['last_message_at' => now()]);

        return response()->json(['data' => $message], 201);
    }
}
