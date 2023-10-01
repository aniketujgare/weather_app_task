import 'package:http/http.dart' as http;
import 'package:weather_forecast/src/domain/models/the_5_day_weather_model.dart';
import 'package:weather_forecast/src/domain/models/weather_model.dart';

class WeatherApi {
  static const apiKey = '36a06a01f22cbbc23d6a6f0e09dbed10';
  // static const city = 'London';
  // final String urlLatLong =
  //     'httpsvscode-file://vscode-app/c:/Program%20Files/Microsoft%20VS%20Code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.html://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';
  Future<WeatherModel> getWeather({required String city}) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&&units=imperial&appid=$apiKey'));
    if (response.statusCode == 200) {
      return weatherModelFromJson(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  get5DayWeather(Map<String, dynamic> coord) async {
    var uri =
        'https://api.openweathermap.org/data/2.5/forecast?lat=${coord['lat']}&lon=${coord['lon']}&units=imperial&appid=$apiKey';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return the5DayWeatherModelFromJson(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
