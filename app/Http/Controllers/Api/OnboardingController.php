<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ClientOnboarding;
use App\Models\User;
use App\Notifications\NewClientOnboarded;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Notification;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Rules\Password;

class OnboardingController extends Controller
{
    /**
     * Create a client account from the account.nerdworx.com sign-up flow.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', Rule::unique(User::class)],
            'phone' => ['nullable', 'string', 'max:50'],
            'company_name' => ['required', 'string', 'max:255'],
            'company_size' => ['required', Rule::in(ClientOnboarding::COMPANY_SIZES)],
            'solutions' => ['required', 'array', 'min:1'],
            'solutions.*' => ['distinct', Rule::in(array_keys(ClientOnboarding::SOLUTIONS))],
            'timeline' => ['required', Rule::in(ClientOnboarding::TIMELINES)],
            'notes' => ['nullable', 'string', 'max:5000'],
            'password' => ['required', 'confirmed', Password::defaults()],
        ]);

        $onboarding = DB::transaction(function () use ($validated) {
            $user = User::create([
                'name' => $validated['name'],
                'email' => $validated['email'],
                'password' => $validated['password'],
            ]);

            return $user->clientOnboarding()->create($validated);
        });

        if ($notifyEmail = config('services.onboarding.notify_email')) {
            Notification::route('mail', $notifyEmail)->notify(new NewClientOnboarded($onboarding));
        }

        return response()->json(['message' => 'Client account created.'], 201);
    }
}
