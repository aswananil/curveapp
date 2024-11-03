import 'package:geolocator/geolocator.dart';
import 'sound_service.dart';
import 'dart:math';

class CurveDetectionService {
  static List<Position> recentPositions = [];

  static double calculateCurveAngle(Position newPosition) {
    recentPositions.add(newPosition);
    if (recentPositions.length < 3) return 0.0;

    final p1 = recentPositions[recentPositions.length - 3];
    final p2 = recentPositions[recentPositions.length - 2];
    final p3 = newPosition;

    final angle = _angleBetweenThreePoints(p1, p2, p3);
    if (recentPositions.length > 3) recentPositions.removeAt(0);
    return angle;
  }

  static bool isSharpCurve(double angle, double speed) {
    const angleThreshold = 45;
    const speedLimit = 60;
    return angle > angleThreshold && speed > speedLimit;
  }

  static double _angleBetweenThreePoints(
      Position p1, Position p2, Position p3) {
    final dx1 = p1.longitude - p2.longitude;
    final dy1 = p1.latitude - p2.latitude;
    final dx2 = p3.longitude - p2.longitude;
    final dy2 = p3.latitude - p2.latitude;
    final angle = (dx1 * dx2 + dy1 * dy2) /
        (sqrt(dx1 * dx1 + dy1 * dy1) * sqrt(dx2 * dx2 + dy2 * dy2));
    return acos(angle) * (180 / pi);
  }

  static void playEmergencyAlert() {
    SoundService.playAlertSound();
  }
}
