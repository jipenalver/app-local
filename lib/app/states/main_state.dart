import 'dart:async';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:overlay_support/overlay_support.dart';

class MyAppState extends ChangeNotifier {
  final mapController = MapController();
  final List<Marker> markers = [];
  double lat = 8.996741;
  double long = 125.812437;

  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSimpleNotification(
          Text("GPS/Location is disabled. Please turn on GPS/Location."),
          background: Colors.red);
      return Future.error('Location services are disabled.');
    }

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

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void liveLocation() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    // ignore: unused_local_variable
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        lat = position.latitude;
        long = position.longitude;
        print('$lat, $long');
      }
    });

    notifyListeners();
  }

  void setMarker() {
    getLocation().then((value) {
      lat = value.latitude;
      long = value.longitude;
    });

    mapController.move(LatLng(lat, long), 18);

    print(markers.length);
    notifyListeners();
  }

  bool checkLocation() {
    if (lat == 8.996741 && long == 125.812437) {
      toast('Fetching GPS/Location... Please press again...');
      return false;
    }
    return true;
  }
}
