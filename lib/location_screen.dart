import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  GoogleMapController? mapController;
  Set<Marker> markers = {}; // Define a set of markers

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: _determinePosition(context),
            builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data == null ||
                  snapshot.data!['position'] == null) {
                return Container(); // Or any other widget you want to show when location services are disabled
              } else {
                // Add a marker at the user's location
                markers.add(Marker(
                  markerId: const MarkerId('user_location'),
                  position: snapshot.data!['position'],
                ));

                return Column(
                  children: <Widget>[
                    Text('Address: ${snapshot.data!['address']}'),
                    Expanded(
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: snapshot.data!['position'],
                          zoom: 11.0,
                        ),
                        markers:
                            markers, // Pass the set of markers to the GoogleMap widget
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Map<String, dynamic>> _determinePosition(BuildContext context) async {
    _checkLocationService(context);
    final Position position = await _getPosition();

    // Get the placemark using the geocoding package
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String address = 'No address found';

    // Ensure that an address was found
    if (placemarks.isNotEmpty) {
      final Placemark placemark = placemarks.first;
      address =
          '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
    }

    return {
      'position': LatLng(position.latitude, position.longitude),
      'address': address,
    };
  }

  void _checkLocationService(BuildContext context) {
    Geolocator.isLocationServiceEnabled().then((serviceEnabled) {
      if (!serviceEnabled) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Location Services Disabled'),
              content:
                  const Text('Please enable location services and try again.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  Future<Position> _getPosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
