import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_forecast/src/presentation/bloc/settings_bloc/settings_bloc.dart';
import 'package:weather_forecast/src/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_forecast/src/presentation/views/homeview.dart';
import 'package:weather_forecast/src/presentation/views/settings_view.dart';

import 'app_router_constants.dart';

final setttingsBloc = SettingsBloc();
final weatherBloc = WeatherBloc()..add(GetWeaterEvent(city: 'Mumbai'));

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: AppRoutConstants.homeRoutName,
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
            child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: weatherBloc,
              // value: weatherBloc,
            ),
            BlocProvider.value(
              value: setttingsBloc,
            ),
          ],
          child: const HomeView(),
        )),
      ),
      GoRoute(
        name: AppRoutConstants.settingsRoutName,
        path: '/settings',
        pageBuilder: (context, state) => MaterialPage(
          child: BlocProvider.value(
            value: setttingsBloc,
            child: const SettingsView(),
          ),
        ),
      ),
    ],
  );
}
