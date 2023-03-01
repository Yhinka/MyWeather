import 'package:clima_2/services/location.dart';
import 'package:clima_2/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const kApiKey = '46442812617a4007800142854221312';
const openWeatherUrl = 'https://api.weatherapi.com/v1/current.json';

class WeatherModel {
  Future<dynamic> getCityWeather(cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherUrl?key=$kApiKey&q=$cityName');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherUrl?key=$kApiKey&q=${location.latitude},${location
            .longitude}'
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  dynamic getWeatherIcon(int condition, hour) {
    if (condition == 1000) {
      if (hour == 1) {
        return const WeatherIcon(icon: Icons.sunny, color: Colors.yellowAccent,);
      } else {
        return const WeatherIcon(icon: FontAwesomeIcons.moon, color: Colors.grey,);
      }
    }
    else if (condition == 1003) {
      if (hour == 1) {
        return const WeatherIcon(icon:FontAwesomeIcons.cloudSun);
      } else {
        return const WeatherIcon(icon:FontAwesomeIcons.cloudMoon,);
      }
    }
    else if (condition == 1006) {
      return const WeatherIcon(icon:Icons.cloud, color: Colors.white70,);
    }
    else if (condition == 1009) {
      return const WeatherIcon(icon:FontAwesomeIcons.cloud, color: Colors.white24,);
    }
    else if (condition == 1030) {
      return const WeatherIcon(icon:Icons.foggy, color: Colors.white,);
    }
    else if (condition == 1063) {
      if (hour == 1) {
        return const WeatherIcon(icon:FontAwesomeIcons.cloudSunRain);
      } else {
        return const WeatherIcon(icon:FontAwesomeIcons.cloudMoonRain);
      }
    }
    else if (condition == 1066 || condition == 1069) {
      return const WeatherIcon(icon:Icons.cloudy_snowing, color: Colors.white70,);
    }
    else if (condition == 1072 || condition == 1150) {
      return const WeatherIcon(icon:FontAwesomeIcons.cloudRain);
    }
    else if (condition == 1168 || condition == 1153) {
      return const WeatherIcon(icon:FontAwesomeIcons.cloudRain);
    }
    else if (condition == 1171 || condition == 1183) {
      return const WeatherIcon(icon:FontAwesomeIcons.cloudRain);
    }
    else if (condition == 1189 || condition == 1198) {
      return const WeatherIcon(icon:FontAwesomeIcons.cloudRain);
    }
    else if (condition == 1201 || condition == 1150) {
      return const WeatherIcon(icon:FontAwesomeIcons.cloudRain);
    }
    else if (condition == 1087) {
      return const WeatherIcon(icon:FontAwesomeIcons.cloudBolt);
    }
    else if (condition == 1114 || condition == 1117) {
      return const WeatherIcon(icon:FontAwesomeIcons.snowman, color: Colors.white70,);
    }
    else if (condition == 1135 || condition == 1147) {
      return const WeatherIcon(icon:Icons.foggy, color: Colors.white60,);
    }
    else if (condition == 1180 || condition == 1186) {
      if (hour == 1) {
        return const WeatherIcon(icon:FontAwesomeIcons.cloudSunRain);
      } else {
        return const WeatherIcon(icon:FontAwesomeIcons.cloudMoonRain);
      }
    }
    else if (condition == 1192 || condition == 1240) {
      if (hour == 1) {
        return const WeatherIcon(icon:FontAwesomeIcons.cloudSunRain);
      } else {
        return const WeatherIcon(icon:FontAwesomeIcons.cloudMoonRain);
      }
    }
    else if (condition == 1243 || condition == 1246) {
      if (hour == 1) {
        return const WeatherIcon(icon:FontAwesomeIcons.cloudSunRain);
      } else {
        return const WeatherIcon(icon:FontAwesomeIcons.cloudMoonRain);
      }
    }
    else if (condition == 1195) {
      return const WeatherIcon(icon:FontAwesomeIcons.cloudRain);
    }
    else if (condition == 1204 || condition == 1207) {
      return const WeatherIcon(icon:FontAwesomeIcons.cloudRain);
    }
    else if (condition == 1210 || condition == 1216) {
      if(hour == 1){
      return const WeatherIcon(icon:Icons.sunny_snowing);
    } else {return const WeatherIcon(icon:Icons.cloudy_snowing);}
      }
    else if (condition == 1213 || condition == 1219) {
      return const WeatherIcon(icon:Icons.cloudy_snowing);
    }
    else if (condition == 1222 || condition == 1225) {
      if(hour == 1){
        return const WeatherIcon(icon:Icons.sunny_snowing);
      } else {return const WeatherIcon(icon:Icons.cloudy_snowing);}
    }
    else if (condition == 1237) {
      return const WeatherIcon(icon:Icons.snowing, color: Colors.blueGrey,);
    }
    else if (condition == 1249 || condition == 1252) {
      if(hour == 1){
        return const WeatherIcon(icon:FontAwesomeIcons.cloudSunRain);
      } else {return const WeatherIcon(icon:FontAwesomeIcons.cloudMoonRain);}
    }
    else if (condition == 1255 || condition == 1258) {
      if(hour == 1){
        return const WeatherIcon(icon:Icons.sunny_snowing);
      } else {return const WeatherIcon(icon:Icons.cloudy_snowing);}
    }
    else if (condition == 1261 || condition == 1264) {
      if(hour == 1){
        return const WeatherIcon(icon:Icons.sunny_snowing);
      } else {return const WeatherIcon(icon:Icons.cloudy_snowing);}
    }
    else if (condition == 1273) {
        return const WeatherIcon(icon:FontAwesomeIcons.cloudBolt);
    }
    else if (condition == 1276) {
      return const WeatherIcon(icon:FontAwesomeIcons.boltLightning);
    }
    else if (condition == 1279) {
      if(hour == 1){
        return const WeatherIcon(icon:Icons.sunny_snowing);
      } else {return const WeatherIcon(icon:Icons.cloudy_snowing);}
    }
     else {
      return const WeatherIcon(icon:FontAwesomeIcons.bolt);
    }
  }

    String getMessage(int temp) {
      if (temp > 25) {
        return 'It\'s 🍦 time';
      } else if (temp > 20) {
        return 'Time for shorts and 👕';
      } else if (temp < 10) {
        return 'You\'ll need 🧣 and 🧤';
      } else {
        return 'Bring a 🧥 just in case';
      }
    }
  }

class WeatherIcon extends StatelessWidget {
   const WeatherIcon({
    super.key, this.icon, this.color,
  });

  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FaIcon(icon, color: color, size: 120.0,);
  }
}
