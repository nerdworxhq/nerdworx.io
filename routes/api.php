<?php

use App\Http\Controllers\Api\OnboardingController;
use Illuminate\Support\Facades\Route;

Route::post('/v1/onboarding', [OnboardingController::class, 'store'])
    ->middleware('throttle:5,1')
    ->name('api.onboarding.store');
