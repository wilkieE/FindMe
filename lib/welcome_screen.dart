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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 250.0),
                child: Text(
                  'Welcome to FindMe',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  label: const Text('View Location'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocationScreen(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.bookmark,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  label: const Text('View Saved Locations'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SavedLocationsScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
