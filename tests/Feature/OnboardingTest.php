<?php

namespace Tests\Feature;

use App\Models\User;
use App\Notifications\NewClientOnboarded;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Notifications\AnonymousNotifiable;
use Illuminate\Notifications\SendQueuedNotifications;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Notification;
use Illuminate\Support\Facades\Queue;
use Tests\TestCase;

class OnboardingTest extends TestCase
{
    use RefreshDatabase;

    private function payload(array $overrides = []): array
    {
        return array_merge([
            'name' => 'Pat Client',
            'email' => 'pat@example.com',
            'phone' => '555-0100',
            'company_name' => 'Example Co',
            'company_size' => '2-10',
            'solutions' => ['business-branding', 'office-technology'],
            'timeline' => 'asap',
            'notes' => 'Our WiFi drops every afternoon.',
            'password' => 'correct-horse-battery',
            'password_confirmation' => 'correct-horse-battery',
        ], $overrides);
    }

    public function test_creates_client_account_with_onboarding_answers(): void
    {
        config(['services.onboarding.notify_email' => 'team@example.com']);
        Notification::fake();

        $this->postJson('/api/v1/onboarding', $this->payload())->assertCreated();

        $user = User::where('email', 'pat@example.com')->firstOrFail();
        $this->assertTrue(Hash::check('correct-horse-battery', $user->password));
        $this->assertSame('Example Co', $user->clientOnboarding->company_name);
        $this->assertSame(['business-branding', 'office-technology'], $user->clientOnboarding->solutions);

        Notification::assertSentTo(
            new AnonymousNotifiable,
            NewClientOnboarded::class,
            fn ($notification, $channels, $notifiable) => $notifiable->routes['mail'] === 'team@example.com',
        );

        $mail = (new NewClientOnboarded($user->clientOnboarding))->toMail(new AnonymousNotifiable);
        $this->assertSame('New client sign-up: Example Co', $mail->subject);
        $this->assertContains('Solutions: Business Branding, Office Technology', $mail->introLines);
    }

    public function test_queues_notification_so_mail_failures_do_not_fail_sign_up(): void
    {
        config(['services.onboarding.notify_email' => 'team@example.com']);
        Queue::fake();

        $this->postJson('/api/v1/onboarding', $this->payload())->assertCreated();

        Queue::assertPushed(SendQueuedNotifications::class);
    }

    public function test_skips_notification_when_no_recipient_configured(): void
    {
        config(['services.onboarding.notify_email' => null]);
        Notification::fake();

        $this->postJson('/api/v1/onboarding', $this->payload())->assertCreated();

        Notification::assertNothingSent();
    }

    public function test_rejects_existing_email(): void
    {
        User::factory()->create(['email' => 'pat@example.com']);

        $this->postJson('/api/v1/onboarding', $this->payload())
            ->assertUnprocessable()
            ->assertJsonValidationErrors('email');
    }

    public function test_rejects_unknown_solutions_and_missing_fields(): void
    {
        $this->postJson('/api/v1/onboarding', $this->payload([
            'solutions' => ['time-travel'],
            'company_name' => '',
            'password_confirmation' => 'mismatch',
        ]))
            ->assertUnprocessable()
            ->assertJsonValidationErrors(['solutions.0', 'company_name', 'password']);

        $this->assertDatabaseCount('users', 0);
    }

    public function test_allows_cors_preflight_from_account_site(): void
    {
        $this->options('/api/v1/onboarding', [], [
            'Origin' => 'https://account.nerdworx.com',
            'Access-Control-Request-Method' => 'POST',
        ])->assertHeader('Access-Control-Allow-Origin', 'https://account.nerdworx.com');
    }

    public function test_cors_never_echoes_other_origins(): void
    {
        $this->options('/api/v1/onboarding', [], [
            'Origin' => 'https://evil.example',
            'Access-Control-Request-Method' => 'POST',
        ])->assertHeader('Access-Control-Allow-Origin', 'https://account.nerdworx.com');
    }
}
