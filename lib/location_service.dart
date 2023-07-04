import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

GoogleMapController? mapController;

void onMapCreated(GoogleMapController controller) {
  mapController = controller;
}

Future<Map<String, dynamic>> determinePosition(BuildContext context) async {
  checkLocationService(context);
  final Position position = await getPosition();

  final List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

  String address = 'No address found';

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

void checkLocationService(BuildContext context) {
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

Future<Position> getPosition() async {
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
