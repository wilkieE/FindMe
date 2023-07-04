# FindMe

<p float="left">
  <img src="https://github.com/wilkieE/DEF-Electronics/assets/48595932/2ae88be4-4649-4295-a444-2d98ad652142" width="33%" /> 
  <img src="https://github.com/wilkieE/DEF-Electronics/assets/48595932/93a1bc86-c017-46e9-aa77-acc7cc54cc03" width="33%" />
  <img src="https://github.com/wilkieE/DEF-Electronics/assets/48595932/fa2d25a4-637e-4d52-85bc-63d5493e0f88" width="33%" />
</p>

## Introduction
This repository contains the source code for FindMe, an application built with Flutter that allows users to determine their current GPS location, translate the coordinates into a readable address, display the address marker on a Google Map, and save the location for future reference. Users can also view their previously saved locations.

## Features

- Real-time GPS tracking: Users can find their current location in real-time.
- GPS-to-address translation: Converts GPS coordinates to a readable address.
- Google Maps Integration: Shows the user's location on Google Maps.
- Location storage: Users can save their current location for future use.
- Previous location review: Users can see all of their previously saved locations.

## Tech Stack

The application is built in flutter using the following packages:

- [geolocator](https://pub.dev/packages/geolocator): ^8.0.0
- [geocoding](https://pub.dev/packages/geocoding): ^2.1.0
- [google_maps_flutter](https://pub.dev/packages/google_maps_flutter): ^2.0.10
- [shared_preferences](https://pub.dev/packages/shared_preferences): ^2.0.5

## Setup and Installation

### Prerequisites
Ensure you have the following installed on your local machine:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)

### Steps to follow
1. Clone this repository from GitHub:
   `git clone https://github.com/wilkieE/FindMe.git`
2. Navigate into the cloned repository:
  `cd FindMe`
3. Install all the packages:
   `flutter pub get`
4. Run the app:
   `flutter run`

## Usage
Once you've launched the application, you can easily check your current location by clicking on the 'View Current Location' button. This will also display your location on the integrated Google Map. You can save your location by clicking on the 'Save Location' button. The 'View Saved Locations' button will display a list of all previously saved locations.

