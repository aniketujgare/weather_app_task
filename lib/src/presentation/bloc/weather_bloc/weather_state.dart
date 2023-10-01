part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  final The5DayWeatherModel the5Dayweather;

  WeatherLoaded({required this.weather, required this.the5Dayweather});
}
