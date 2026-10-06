<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['phone', 'company_name', 'company_size', 'solutions', 'timeline', 'notes'])]
class ClientOnboarding extends Model
{
    /**
     * Solutions a client can request, keyed by the value the sign-up form sends.
     */
    public const SOLUTIONS = [
        'business-branding' => 'Business Branding',
        'office-technology' => 'Office Technology',
        'website-development' => 'Website Development',
        'mobile-app-development' => 'Mobile App Development',
    ];

    public const COMPANY_SIZES = ['just-me', '2-10', '11-50', '51+'];

    public const TIMELINES = ['asap', '1-3-months', 'exploring'];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'solutions' => 'array',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
