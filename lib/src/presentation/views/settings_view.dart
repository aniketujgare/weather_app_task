import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/settings_bloc/settings_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return const Text(
                  'Temperature Unit',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                );
              },
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: const Text('Celsius'),
                  value: state.isCelsius,
                  onChanged: (_) {
                    BlocProvider.of<SettingsBloc>(context)
                        .add(TemperatureUnitToggleEvent());
                  },
                );
              },
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: const Text('Fahrenheit'),
                  value: !state.isCelsius,
                  onChanged: (_) {
                    BlocProvider.of<SettingsBloc>(context)
                        .add(TemperatureUnitToggleEvent());
                  },
                );
              },
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return const Text(
                  'App Theme',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                );
              },
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: const Text('Light Theme'),
                  value: !state.isDarkTheme,
                  onChanged: (_) {
                    BlocProvider.of<SettingsBloc>(context)
                        .add(ThemeToggleEvent());
                  },
                );
              },
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: const Text('Dark Theme'),
                  value: state.isDarkTheme,
                  onChanged: (_) {
                    BlocProvider.of<SettingsBloc>(context)
                        .add(ThemeToggleEvent());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
