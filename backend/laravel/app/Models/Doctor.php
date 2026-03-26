<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Doctor extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'user_id','specialty_id','license_no','bio','experience_years',
        'consultation_fee_chat','consultation_fee_voice','consultation_fee_video',
        'city','country','rating_avg','rating_count','is_active'
    ];

    public function user(): BelongsTo { return $this->belongsTo(User::class); }
    public function specialty(): BelongsTo { return $this->belongsTo(Specialty::class); }
    public function appointments(): HasMany { return $this->hasMany(Appointment::class); }
}
