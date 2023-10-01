part of 'settings_bloc.dart';

@immutable
final class SettingsState {
  final bool isDarkTheme;
  final bool isCelsius;
  const SettingsState({required this.isDarkTheme, required this.isCelsius});
}
