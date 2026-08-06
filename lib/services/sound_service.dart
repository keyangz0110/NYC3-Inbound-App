import 'package:audioplayers/audioplayers.dart';

enum SoundEvent {
  cartonOpened,
  productScanned,
  slotClosed,
  sortingFinished,
}

class SoundService {
  SoundService() : _player = AudioPlayer();

  final AudioPlayer _player;

  static const Map<SoundEvent, String> _assetPaths = {
    SoundEvent.cartonOpened: 'sounds/proxima.ogg',
    SoundEvent.productScanned: 'sounds/canopus.ogg',
    SoundEvent.slotClosed: 'sounds/adara.ogg',
    SoundEvent.sortingFinished: 'sounds/tinkerbell.ogg',
  };

  Future<void> play(SoundEvent event) async {
    final path = _assetPaths[event];
    if (path == null) {
      return;
    }

    try {
      await _player.stop();
      await _player.play(AssetSource(path));
    } catch (_) {
      // Ignore playback errors on devices without audio output.
    }
  }

  void dispose() {
    _player.dispose();
  }
}
