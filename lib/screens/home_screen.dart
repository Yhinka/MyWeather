import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.locationWeather}) : super(key: key);

   final dynamic locationWeather;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel weather = WeatherModel();

  int? temperature;
  late dynamic weatherIcon;
  String? cityName, weatherMessage;
  int? hum;
  double? wind;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = ' ';
        weatherMessage = 'Unable to get weather data';
        cityName = 'No city found!';
        return;
      }
      double temp = weatherData['current']['temp_c'];
      temperature = temp.toInt();
      weatherMessage = weatherData['current']['condition']['text'];

      int condition = weatherData['current']['condition']['code'];
      int hour = weatherData['current']['is_day'];

      weatherIcon = weather.getWeatherIcon(condition, hour);
      cityName = weatherData['location']['name'];
      hum = weatherData['current']['humidity'];
      wind = weatherData['current']['wind_kph'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 60.0),
                ),
                const FaIcon(
                  FontAwesomeIcons.locationDot,
                  color: Colors.red,
                ),
                const SizedBox(width: 10.0),
                Text(
                  '$cityName',
                  style: const TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: weatherIcon),
                Text(
                  '$temperature°C',
                  style: const TextStyle(
                      fontSize: 35.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 30.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children:  [
                        Text('$hum%'),
                        const Text('Humidity'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children:  [
                        Text('$wind km/h'),
                        const Text('Wind'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
             Center(
              child: Text("$weatherMessage" , style: const TextStyle(fontStyle: FontStyle.italic),),
            ),
            const Divider(
              thickness: 1.0,
              color: Colors.white38,
            ),
          ],
        ),
      ),
    );
  }
}