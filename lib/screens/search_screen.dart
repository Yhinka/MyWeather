import 'package:clima_2/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../services/weather.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  WeatherModel weather = WeatherModel();

  int? temperature;
  String? cityName, weatherMessage, regionZone, regionTime;
  late dynamic weatherIcon;
  int? hum;
  double? wind;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/RoomBG.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: kTextFieldInputDecor,
                      onChanged: (value) {
                        cityName = value;
                      },
                    )),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try{
                      dynamic weatherData =  await weather.getCityWeather(cityName);
                      double temp = weatherData['current']['temp_c'];
                      temperature = temp.toInt();
                      weatherMessage = weatherData['current']['condition']['text'];

                      int condition = weatherData['current']['condition']['code'];
                      int hour = weatherData['current']['is_day'];

                      weatherIcon = weather.getWeatherIcon(condition, hour);
                      cityName = weatherData['location']['name'];
                      regionZone = weatherData['location']['tz_id'];
                      regionTime = weatherData['location']['localtime'];
                      hum = weatherData['current']['humidity'];
                      wind = weatherData['current']['wind_kph'];

                      if(weatherData != null){
                        showModalBottomSheet(
                          backgroundColor: const Color(0xFF265B83),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            isDismissible: false,
                            builder: (BuildContext context)
                            {
                              return SizedBox(
                                height: 380,
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.locationDot,
                                                  color: Colors.redAccent,
                                                  size: 10.0,
                                                ),
                                                Text(' $cityName',
                                                  style: const TextStyle(
                                                      fontSize: 15.0,color: Colors.white,
                                                  fontStyle: FontStyle.italic),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('$regionZone ', style: const TextStyle(fontSize: 10.0,color: Colors.white)),
                                              Text('($regionTime)', style: const TextStyle(fontSize: 10.0,color: Colors.white))
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                                        child: weatherIcon),
                                    Text(
                                      '$temperature°C',
                                      style: const TextStyle(
                                          fontSize: 35.0, fontWeight: FontWeight.bold,color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children:  [
                                              Text('$hum%', style: const TextStyle(color: Colors.white)),
                                              const Text('Humidity', style: TextStyle(color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children:  [
                                              Text('$wind km/h', style: const TextStyle(color: Colors.white)),
                                              const Text('Wind', style: TextStyle(color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Text("$weatherMessage", style: const TextStyle(fontSize: 15.0,color: Colors.white, fontStyle: FontStyle.italic)),
                                    ),
                                  ],
                                ),
                              );
                            }, context: context);
                      }
                      setState(() {
                      showSpinner = false;
                      });
                    }
                    catch(e){openWeatherUrl;}
                  },
                  child: const Text(
                    'Get Weather',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
