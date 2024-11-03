import 'package:flutter_sound/flutter_sound.dart';

class SoundService {
  static FlutterSoundPlayer? _player = FlutterSoundPlayer();

  static Future<void> playAlertSound() async {
    await _player?.startPlayer();
    await _player?.startPlayer(fromURI: 'assets/sounds/emergency_alert.mp3');
  }

  static void stopAlertSound() async {
    await _player?.stopPlayer();
  }
}
