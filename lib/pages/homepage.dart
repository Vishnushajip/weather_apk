import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(HomePage());
}

class WeatherProvider extends ChangeNotifier {
  IconData weatherIcon = Icons.cloud;
  String weatherCondition = 'Cloudy';
  String temperature = '25°C';
  String location = 'New York';

  void refreshWeather() {
    final List<Map<String, dynamic>> weatherConditions = [
      {'icon': Icons.cloud, 'condition': 'Cloudy'},
      {'icon': Icons.wb_sunny, 'condition': 'Sunny'},
      {'icon': Icons.ac_unit, 'condition': 'Snowy'},
      {'icon': Icons.grain, 'condition': 'Windy'},
    ];

    final randomIndex = Random().nextInt(weatherConditions.length);

    weatherIcon = weatherConditions[randomIndex]['icon'];
    weatherCondition = weatherConditions[randomIndex]['condition'];
    temperature = '${Random().nextInt(35)}°C';

    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => WeatherProvider(),
        child: WeatherHomePage(),
      ),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  String currentLocation = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() {
    // Simulating getting current location
    setState(() {
      currentLocation = 'Malappuram';
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather Buddy',
          style: TextStyle(
            fontFamily: 'customFont',
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Action when search icon is pressed
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Action when settings icon is pressed
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Main Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                // Action when Item 1 is tapped
              },
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Action when Item 2 is tapped
              },
            ),
            ListTile(
              title: Text(' About'),
              onTap: () {
                // Action when Item 3 is tapped
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current Weather',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Icon(
              weatherProvider.weatherIcon,
              size: 100.0,
              color: Colors.blue,
            ),
            SizedBox(height: 20.0),
            Text(
              'Temperature: ${weatherProvider.temperature}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Location: $currentLocation',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                weatherProvider.refreshWeather();
              },
              child: Text('Refresh'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        selectedItemColor: Colors.blue,
        // currentIndex: _selectedIndex,
        // onTap: _onItemTapped,
      ),
    );
  }
}
