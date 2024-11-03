import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/geolocation_service.dart';
import '../services/curve_detection_service.dart';
import '../widgets/alert_icon.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showAlert = false;

  @override
  void initState() {
    super.initState();
    GeolocationService.startTracking((position) {
      final angle = CurveDetectionService.calculateCurveAngle(position);
      final speed = position.speed * 3.6; // Convert m/s to km/h
      if (CurveDetectionService.isSharpCurve(angle, speed)) {
        setState(() => showAlert = true);
        CurveDetectionService.playEmergencyAlert();
      } else {
        setState(() => showAlert = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Truck Curve Alert')),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(40.7128, -74.0060), // Set initial map center
              zoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
            ],
          ),
          if (showAlert) AlertIcon(),
        ],
      ),
    );
  }
}
