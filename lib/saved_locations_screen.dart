import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedLocationsScreen extends StatefulWidget {
  const SavedLocationsScreen({Key? key}) : super(key: key);

  @override
  State<SavedLocationsScreen> createState() => _SavedLocationsScreenState();
}

class _SavedLocationsScreenState extends State<SavedLocationsScreen> {
  List<String>? locations;

  @override
  void initState() {
    super.initState();
    loadLocations();
  }

  Future<void> loadLocations() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      locations = prefs.getStringList('savedLocations');
    });
    print("hello");
    print(locations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Saved Locations',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: locations == null
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: locations!.length,
                itemBuilder: (context, index) {
                  return LocationTile(location: locations![index]);
                },
              ),
            ),
    );
  }
}

class LocationTile extends StatelessWidget {
  final String location;
  const LocationTile({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationParts = location.split(',');
    return Card(
      color: Colors.grey[200],
      shadowColor: Colors.black,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Latitude: ${locationParts[0]}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Longitude: ${locationParts[1]}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Address: ${locationParts[2]}, ${locationParts[3]}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Saved at: ${formatDateTime(locationParts[6])}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

String formatDateTime(String dateTimeString) {
  final dateTimeParts = dateTimeString.split(' ');
  final date = dateTimeParts[0];
  final time = dateTimeParts[1].split(':').sublist(0, 2).join(':');
  return '$time, $date';
}
