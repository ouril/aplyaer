import 'dart:async';
import 'dart:html';
import 'exceptions.dart';

enum APlayerState { PLAY, PAUSE, STOP }

abstract class APlayer {
  factory APlayer(String link) => _LinkPlayer(link);

  Stream<Duration> get curentTime;

  Duration get duration;

  APlayerState aState;

  playPause();

  setCurrentTime(Duration time);

  stop();

  dispose();
}

class _LinkPlayer implements APlayer {
  final link;

  AudioElement _audio;

  APlayerState aState = APlayerState.STOP;

  bool _isPlayed = false;

  num _duration = 0;

  StreamSubscription _curentTimeSub;

  StreamSubscription _playedSub;

  StreamSubscription _pauseSub;

  StreamSubscription _errorSub;

  StreamSubscription _readySub;

  StreamController<Duration> _currentTime = StreamController.broadcast();

  _LinkPlayer(this.link) {
    _audio = AudioElement(link);
    _readySub = _audio.onDurationChange.capture((e) {
      _duration = _audio.duration * 1000;
    }); 
    _duration = _audio.duration * 1000;
    _curentTimeSub = _audio.onTimeUpdate.capture((e) {
      _currentTime.sink.add(Duration(milliseconds: (_audio.currentTime * 1000).toInt()));
    });
    _playedSub = _audio.onPlay.capture((e) {
      _isPlayed = true;
      aState = APlayerState.PLAY;
    });
    _playedSub = _audio.onPlaying.capture((e) {
      _isPlayed = true;
      aState = APlayerState.PLAY;
    });
    _pauseSub = _audio.onPause.capture((e) {
      _isPlayed = false;
      aState = APlayerState.PAUSE;
    });
    _errorSub = _audio.onError.capture((Event e){
      throw APlayerException(e.toString());
    });

  }

  @override
  playPause() {
    _isPlayed ? _audio.pause() : _audio.play();
  }

  @override
  setCurrentTime(Duration time) {
     if(time.inMilliseconds/1000 > _duration) throw APlayerException("Time more then duration");
     _audio.currentTime = time.inMilliseconds/1000;

  }

  @override
  Stream<Duration> get curentTime => _currentTime.stream;

  @override
  Duration get duration => Duration(milliseconds: _duration.toInt());

  @override
  dispose() {
    _curentTimeSub.cancel();
    _playedSub.cancel();
    _pauseSub.cancel();
    _readySub.cancel();
    _currentTime.close();

    this.dispose();
  }

  @override
  stop() {
    _audio.pause();
    aState = APlayerState.STOP;
    setCurrentTime(Duration(milliseconds: 0));
  }

  
}
