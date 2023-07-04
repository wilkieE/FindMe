import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'saved_locations_screen.dart';

class WelcomeScreen extends StatelessWidget {
  // Add a key parameter to the constructor and pass it to the super class
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: SafeArea(
        // Wrap the body in a SafeArea widget
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to our app, click the button below to view your location',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
              ElevatedButton(
                child: const Text('View Location'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LocationScreen()),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('View Saved Locations'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SavedLocationsScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
