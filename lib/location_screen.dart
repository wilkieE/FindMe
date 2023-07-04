import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'location_service.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  Set<Marker> markers = {}; // Define a set of markers

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: FutureBuilder(
              future: determinePosition(context),
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null ||
                    snapshot.data!['position'] == null) {
                  return Container();
                } else {
                  markers.add(Marker(
                    markerId: const MarkerId('user_location'),
                    position: snapshot.data!['position'],
                  ));

                  return Column(
                    children: <Widget>[
                      Text('Address: ${snapshot.data!['address']}'),
                      ElevatedButton(
                        child: const Text('Save Location'),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          final savedLocations =
                              prefs.getStringList('savedLocations') ?? [];

                          final positionData = await determinePosition(context);
                          final position = positionData['position'];

                          savedLocations.add(
                              '${position.latitude},${position.longitude}');
                          await prefs.setStringList(
                              'savedLocations', savedLocations);
                        },
                      ),
                      Expanded(
                        child: GoogleMap(
                          onMapCreated: onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: snapshot.data!['position'],
                            zoom: 11.0,
                          ),
                          markers: markers,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
