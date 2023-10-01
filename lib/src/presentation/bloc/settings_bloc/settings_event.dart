part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class ThemeToggleEvent extends SettingsEvent {}

class TemperatureUnitToggleEvent extends SettingsEvent {}
