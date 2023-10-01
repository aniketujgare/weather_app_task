import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'temperature_unit_preference.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(const SettingsState(isCelsius: true, isDarkTheme: true)) {
    on<ThemeToggleEvent>((event, emit) {
      emit(SettingsState(
          isDarkTheme: !state.isDarkTheme, isCelsius: state.isCelsius));
    });
    on<TemperatureUnitToggleEvent>((event, emit) async {
      // Get temperature unit
      bool? temperatureUnit =
          await TemperatureUnitPreference.getTemperatureUnit();
      if (temperatureUnit == null) {
        // Default temperature unit if not set
        // Set temperature unit to Celsius
        TemperatureUnitPreference.setTemperatureUnit(true);

        temperatureUnit = true;
      }
      emit(SettingsState(
          isDarkTheme: state.isDarkTheme, isCelsius: !temperatureUnit));
    });
  }
}
