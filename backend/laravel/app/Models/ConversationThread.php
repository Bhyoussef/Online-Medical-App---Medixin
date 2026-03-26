<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ConversationThread extends Model
{
    protected $fillable = ['patient_id', 'doctor_id', 'last_message_at'];

    protected $casts = ['last_message_at' => 'datetime'];

    public function patient(): BelongsTo { return $this->belongsTo(User::class, 'patient_id'); }
    public function doctor(): BelongsTo { return $this->belongsTo(Doctor::class); }
    public function messages(): HasMany { return $this->hasMany(Message::class, 'thread_id'); }
}
