import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/src/presentation/bloc/weather_bloc/weather_bloc.dart';

Future<void> showCityNameDialog(BuildContext context) async {
  String cityName = ''; // Store the entered city name here
  return showDialog(
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter City Name'),
        content: TextField(
          onChanged: (value) {
            cityName = value; // Update cityName when text changes
          },
          decoration: const InputDecoration(
            hintText: 'City Name',
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Fetch Weather'),
            onPressed: () {
              debugPrint('Fetching weather for $cityName');
              context.read<WeatherBloc>().add(GetWeaterEvent(city: cityName));
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
