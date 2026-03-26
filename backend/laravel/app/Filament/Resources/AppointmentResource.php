<?php

namespace App\Filament\Resources;

use App\Filament\Resources\AppointmentResource\Pages;
use App\Models\Appointment;
use Filament\Forms;
use Filament\Resources\Resource;
use Filament\Tables;

class AppointmentResource extends Resource
{
    protected static ?string $model = Appointment::class;

    public static function form(Forms\Form $form): Forms\Form
    {
        return $form->schema([
            Forms\Components\Select::make('patient_id')->relationship('patient', 'name')->required(),
            Forms\Components\Select::make('doctor_id')->relationship('doctor.user', 'name')->required(),
            Forms\Components\Select::make('status')->options([
                'pending' => 'Pending',
                'confirmed' => 'Confirmed',
                'completed' => 'Completed',
                'cancelled' => 'Cancelled',
                'rescheduled' => 'Rescheduled',
            ])->required(),
            Forms\Components\DatePicker::make('schedule_date')->required(),
        ]);
    }

    public static function table(Tables\Table $table): Tables\Table
    {
        return $table->columns([
            Tables\Columns\TextColumn::make('appointment_no')->searchable(),
            Tables\Columns\TextColumn::make('patient.name')->searchable(),
            Tables\Columns\TextColumn::make('doctor.user.name')->searchable(),
            Tables\Columns\TextColumn::make('status')->badge(),
            Tables\Columns\TextColumn::make('schedule_date')->date(),
        ])->filters([
            Tables\Filters\SelectFilter::make('status')->options([
                'pending' => 'Pending', 'confirmed' => 'Confirmed', 'completed' => 'Completed',
                'cancelled' => 'Cancelled', 'rescheduled' => 'Rescheduled',
            ]),
        ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListAppointments::route('/'),
            'create' => Pages\CreateAppointment::route('/create'),
            'edit' => Pages\EditAppointment::route('/{record}/edit'),
        ];
    }
}
