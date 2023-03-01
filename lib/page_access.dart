import 'package:clima_2/screens/home_screen.dart';
import 'package:clima_2/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key,}) : super(key: key);

  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  List<Widget> body = [
    HomeScreen(
      locationWeather: Get.arguments,
    ),
    const SearchScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF265B83),
        body: Container(
          child: body[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 16,
          unselectedFontSize: 14,
          elevation: 2.0,
          backgroundColor: const Color(0xFF3E6D9C),
          unselectedItemColor: const Color(0xFFF6F6C9),
          selectedItemColor: const Color(0xFFFF8DC7),
          currentIndex: _currentIndex,
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: FaIcon(
                FontAwesomeIcons.house,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: FaIcon(
                FontAwesomeIcons.magnifyingGlassLocation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
