import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_forecast/src/data/datasources/weather_api.dart';
import 'package:weather_forecast/src/domain/models/the_5_day_weather_model.dart';
import 'package:weather_forecast/src/domain/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<GetWeaterEvent>((event, emit) async {
      emit(WeatherLoading());
      try {
        WeatherModel weather = await WeatherApi().getWeather(city: event.city);
        The5DayWeatherModel the5dayWeatherModel = await WeatherApi()
            .get5DayWeather(
                {'lat': weather.coord.lat, 'lon': weather.coord.lon});
        // Pick next 5 dates
        int i = 0;
        while (DateTime.now().day == the5dayWeatherModel.list[i].dtTxt.day) {
          i++;
        }
        the5dayWeatherModel.list.removeRange(0, i);
        i = 0;
        int j = i + 1;
        int n = the5dayWeatherModel.list.length;

        while (j < n) {
          if (the5dayWeatherModel.list[j].dtTxt.day !=
              the5dayWeatherModel.list[i].dtTxt.day) {
            i++;
            the5dayWeatherModel.list[i] = the5dayWeatherModel.list[j];
          }
          j++;
        }
        the5dayWeatherModel.list.removeRange(i + 1, n);

        emit(WeatherLoaded(
            weather: weather, the5Dayweather: the5dayWeatherModel));
      } catch (e) {
        emit(WeatherErrorState(
            error: 'Error getting weather for that location'));
      }
    });
  }
}
