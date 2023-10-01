part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class GetWeaterEvent extends WeatherEvent {
  final String city;

  GetWeaterEvent({required this.city});
}
