import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants.dart';
import '../../bloc/settings_bloc/settings_bloc.dart';
import '../../bloc/weather_bloc/weather_bloc.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoaded) {
            return PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.the5Dayweather.list.length,
              itemBuilder: (context, index) {
                return Container(
                  // height: 50,
                  width: width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color: Colors.blue, // Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('EEE')
                            .format(state.the5Dayweather.list[index].dtTxt)
                            .toUpperCase(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        state.the5Dayweather.list[index].weather.first.main,
                        style: const TextStyle(fontSize: 20),
                      ),
                      BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (context, settingsState) {
                          var temp = state.the5Dayweather.list[index].main.temp;
                          var isCelcius = settingsState.isCelsius;
                          return Text(
                            isCelcius
                                ? '${kFtoDegreeCelsius(temp)}°'
                                : '${temp.toInt()}°',
                            style: const TextStyle(fontSize: 20),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
