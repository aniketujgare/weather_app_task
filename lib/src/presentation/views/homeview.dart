import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../utils/constants.dart';
import '../bloc/settings_bloc/settings_bloc.dart';
import '../bloc/weather_bloc/weather_bloc.dart';
import 'widgets/city_name.dart';
import 'widgets/extra_details.dart';
import 'widgets/settings_button.dart';
import 'widgets/weather_forecast.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String cityName = ''; // Store the entered city name here

    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 40),
                height: height * 0.8,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.4, 0.9],
                    colors: [
                      Color(0XFF13B9FA),
                      Color(0XFF1266F3),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    //Search
                    TextField(
                      onChanged: (value) {
                        cityName = value; // Update cityName when text changes
                      },
                      onSubmitted: (value) {
                        context
                            .read<WeatherBloc>()
                            .add(GetWeaterEvent(city: cityName));
                      },
                      decoration: const InputDecoration(
                          hintText: 'City Name',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    buildDegreeIcon(),
                    weaherImage(),
                    buildTemperature(),
                    buildWeatherCondition(),
                    buildDate(),
                    // const SizedBox(height: 15),
                    Divider(
                      color: Colors.white.withOpacity(0.2),
                      indent: 25,
                      endIndent: 25,
                    ),
                    const SizedBox(height: 15),
                    buildExtraWeatherDetails(),
                  ],
                ),
              ),
              WeatherForecast(width: width),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<WeatherBloc, WeatherState> buildDate() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoaded) {
          // Convert Unix timestamp to DateTime
          DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(state.weather.dt * 1000);
          // Format the DateTime
          String formattedDate = DateFormat('EEEE, d MMMM').format(dateTime);
          return Text(
            formattedDate,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  BlocBuilder<WeatherBloc, WeatherState> buildWeatherCondition() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoaded) {
          return Text(
            state.weather.weather.first.main,
            style: const TextStyle(
              height: 0.9,
              color: Colors.white,
              fontSize: 30,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  BlocBuilder<WeatherBloc, WeatherState> buildTemperature() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoaded) {
          return BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, settinsState) {
              var isCelcius = settinsState.isCelsius;
              return FittedBox(
                child: Text(
                  isCelcius
                      ? '${kFtoDegreeCelsius(state.weather.main.temp)}'
                      : '${state.weather.main.temp.toInt()}',
                  style: const TextStyle(
                    height: 0.9,
                    color: Colors.white,
                    fontSize: 135,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  SizedBox weaherImage() {
    return SizedBox(
      height: 180,
      width: 200,
      child: Image.network(
          'https://static.vecteezy.com/system/resources/previews/008/854/781/original/lightning-strike-thunderstorm-weather-icon-meteorological-sign-3d-render-png.png',
          fit: BoxFit.cover),
    );
  }

  Stack buildDegreeIcon() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const CityName(),
        const SettingsButton(),
        Positioned(
          top: 235,
          right: 85,
          child: Text(
            '°',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 75,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Row buildExtraWeatherDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoaded) {
              return ExtraWeatherDetails(
                icon: Icons.wind_power,
                textMain:
                    '${kMpsToKmph(state.weather.wind.speed).toInt()} Km/h',
                textSub: 'Wind',
              );
            }
            return const SizedBox();
          },
        ),
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoaded) {
              return ExtraWeatherDetails(
                icon: Icons.water_drop,
                textMain: '${state.weather.main.humidity} %',
                textSub: 'Humidity',
              );
            }
            return const SizedBox();
          },
        ),
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoaded) {
              return ExtraWeatherDetails(
                icon: Icons.water,
                textMain: '${state.weather.clouds.all} %',
                textSub: 'Chances of Rain',
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
