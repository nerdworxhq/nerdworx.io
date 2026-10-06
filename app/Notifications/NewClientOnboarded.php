<?php

namespace App\Notifications;

use App\Models\ClientOnboarding;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class NewClientOnboarded extends Notification implements ShouldQueue
{
    use Queueable;

    /**
     * Create a new notification instance.
     */
    public function __construct(public ClientOnboarding $onboarding)
    {
        //
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        $onboarding = $this->onboarding;
        $solutions = array_map(fn (string $key) => ClientOnboarding::SOLUTIONS[$key], $onboarding->solutions);

        return (new MailMessage)
            ->subject("New client sign-up: {$onboarding->company_name}")
            ->line("{$onboarding->user->name} ({$onboarding->user->email}) signed up as a client.")
            ->line("Company: {$onboarding->company_name} ({$onboarding->company_size})")
            ->line('Phone: '.($onboarding->phone ?: 'Not provided'))
            ->line('Solutions: '.implode(', ', $solutions))
            ->line("Timeline: {$onboarding->timeline}")
            ->line('Notes: '.($onboarding->notes ?: 'None'));
    }
}
