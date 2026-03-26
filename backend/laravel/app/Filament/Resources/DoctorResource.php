<?php

namespace App\Filament\Resources;

use App\Filament\Resources\DoctorResource\Pages;
use App\Models\Doctor;
use Filament\Forms;
use Filament\Resources\Resource;
use Filament\Tables;

class DoctorResource extends Resource
{
    protected static ?string $model = Doctor::class;

    public static function form(Forms\Form $form): Forms\Form
    {
        return $form->schema([
            Forms\Components\Select::make('user_id')->relationship('user', 'name')->required(),
            Forms\Components\Select::make('specialty_id')->relationship('specialty', 'name')->required(),
            Forms\Components\TextInput::make('license_no')->required()->unique(ignoreRecord: true),
            Forms\Components\TextInput::make('city')->required(),
            Forms\Components\TextInput::make('country')->required(),
            Forms\Components\Toggle::make('is_active')->default(true),
        ]);
    }

    public static function table(Tables\Table $table): Tables\Table
    {
        return $table->columns([
            Tables\Columns\TextColumn::make('user.name')->searchable()->sortable(),
            Tables\Columns\TextColumn::make('specialty.name')->sortable(),
            Tables\Columns\TextColumn::make('city')->searchable(),
            Tables\Columns\IconColumn::make('is_active')->boolean(),
            Tables\Columns\TextColumn::make('updated_at')->since(),
        ])->filters([
            Tables\Filters\TernaryFilter::make('is_active'),
        ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListDoctors::route('/'),
            'create' => Pages\CreateDoctor::route('/create'),
            'edit' => Pages\EditDoctor::route('/{record}/edit'),
        ];
    }
}
