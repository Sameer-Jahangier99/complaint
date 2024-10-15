<?php

namespace App\Notifications;

use App\Models\Complaint;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class ComplaintUpdated extends Notification
{
    use Queueable;

    public function __construct(private readonly Complaint $complaint)
    {
    }

    public function via($notifiable)
    {
        return ['mail'];
    }

    public function toMail($notifiable)
    {
        $status = $this->complaint->status === 'completed' ? 'closed' : $this->complaint->status;

        return (new MailMessage)
            ->line('The status of your complaint has been updated to: ' . strtoupper($status) . '.')
            ->line('Please click the button below to view the updated complaint.')
            ->action('View Complaint', route('complaints.show', $this->complaint));
    }
}
