<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Message extends Model
{
    protected $fillable = [
        'thread_id', 'sender_id', 'type', 'body', 'media_url', 'sent_at', 'seen_at',
    ];

    protected $casts = ['sent_at' => 'datetime', 'seen_at' => 'datetime'];

    public function thread(): BelongsTo { return $this->belongsTo(ConversationThread::class, 'thread_id'); }
    public function sender(): BelongsTo { return $this->belongsTo(User::class, 'sender_id'); }
}
