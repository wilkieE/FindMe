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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Locations'),
      ),
      body: locations == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: locations!.length,
              itemBuilder: (context, index) {
                final location = locations![index].split(',');
                return ListTile(
                  title: Text(
                      'Latitude: ${location[0]}, Longitude: ${location[1]}'),
                );
              },
            ),
    );
  }
}
