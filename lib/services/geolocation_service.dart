import 'package:geolocator/geolocator.dart';

class GeolocationService {
  static void startTracking(Function(Position) onPositionChanged) {
    Geolocator.getPositionStream().listen((Position position) {
      onPositionChanged(position);
    });
  }
}
