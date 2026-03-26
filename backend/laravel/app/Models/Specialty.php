<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Specialty extends Model
{
    use SoftDeletes;

    protected $fillable = ['name', 'icon', 'is_active'];

    public function doctors(): HasMany { return $this->hasMany(Doctor::class); }
}
