import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../platform/audio_recorder_platform.dart';
import '../../appwrite_interface.dart';

class AudioPlayer extends StatefulWidget {
  /// Path from where to play recorded audio
  // final String source;

  /// Callback when audio file should be removed
  /// Setting this to null hides the delete button
  final VoidCallback onDelete;
  final Future<void> Function(String localPath) onPlay;
  //final int? stepIndex;
  final String? sessionStepId;

  const AudioPlayer({
    super.key,
    // required this.stepIndex,
    required this.onDelete,
    required this.onPlay,
    required this.sessionStepId,
  });

  @override
  AudioPlayerState createState() => AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayer> with AudioRecorderMixin {
  static const double _controlSize = 56;
  static const double _deleteBtnSize = 24;

  final _audioPlayer = ap.AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  late StreamSubscription<void> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  Duration? _position;
  Duration? _duration;
  String? localPath;

  void localSetSource() async {
    _audioPlayer.setSource(await _source());
    print('(DE35)${_source()}');
  }

  void resetPlayer(){
    print('(DE304)');
    _playerStateChangedSubscription =
        _audioPlayer.onPlayerComplete.listen((state) async {
          await stop();
        });
    _positionChangedSubscription = _audioPlayer.onPositionChanged.listen(
          (position) => setState(() {
        _position = position;
      }),
    );
    _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
          (duration) => setState(() {
        _duration = duration;
      }),
    );

    localSetSource();
  }


  @override
  void initState() {
    print('(DE300)');
    _playerStateChangedSubscription =
        _audioPlayer.onPlayerComplete.listen((state) async {
      await stop();
    });
    _positionChangedSubscription = _audioPlayer.onPositionChanged.listen(
      (position) => setState(() {
        _position = position;
      }),
    );
    _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
      (duration) => setState(() {
        _duration = duration;
      }),
    );

    localSetSource();

    super.initState();
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('(DE301)');
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildControl(),
                _buildSlider(constraints.maxWidth),
                IconButton(
                  icon: const Icon(Icons.delete,
                      color: Color(0xFF73748D), size: _deleteBtnSize),
                  onPressed: () {
                    if (_audioPlayer.state == ap.PlayerState.playing) {
                      stop().then((value) => widget.onDelete());
                    } else {
                      widget.onDelete();
                    }
                  },
                ),
              ],
            ),
            // Text('${_duration ?? 0.0}'),
          ],
        );
      },
    );
  }

  Widget _buildControl() {
    Icon icon;
    Color color;
    print('(DE302)');
    if (_audioPlayer.state == ap.PlayerState.playing) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withValues(alpha: 0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withValues(alpha: 0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child:
              SizedBox(width: _controlSize, height: _controlSize, child: icon),
          onTap: () async {
            if (_audioPlayer.state == ap.PlayerState.playing) {
              pause();
            } else {
              await widget.onPlay(await getPath(sessionStepId: widget.sessionStepId!, fileKind: FileKind.audio));
              play();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSlider(double widgetWidth) {
    bool canSetValue = false;
    final duration = _duration;
    final position = _position;

    if (duration != null && position != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    double width = widgetWidth - _controlSize - _deleteBtnSize;
    width -= _deleteBtnSize;
    print('(AU44)${widgetWidth}....${position}');

    return SizedBox(
      width: width,
      child: Slider(
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Theme.of(context).colorScheme.secondary,
        onChanged: (v) {
          if (duration != null) {
            final position = v * duration.inMilliseconds;
            _audioPlayer.seek(Duration(milliseconds: position.round()));
          }
        },
        value: canSetValue && duration != null && position != null
            ? position.inMilliseconds / duration.inMilliseconds
            : 0.0,
      ),
    );
  }

  Future<void> play() async {
    //localSetSource();//???????????????

    final utf8Encoder = utf8.encoder;
    Source localSource = await _source();
    String localPath = await getPath(sessionStepId: widget.sessionStepId!, fileKind: FileKind.audio);
    List<String> dirPath = localPath.split('/audio');
    print('DE36A)${dirPath[0]}');
    var dir = Directory.fromRawPath(utf8Encoder.convert(dirPath[0]));
    await for (var entity in
    dir.list(recursive: true, followLinks: false)) {
      print('DE36B)${entity.path}');
      // if(entity.path.contains('audio')) {
      //   File file = File(entity.path);
      //   await file.delete();
      // }
    }
    print('(DE36C)${localSource.toString()}');
    _audioPlayer.play(localSource);
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    setState(() {});
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    setState(() {});
  }

  // Source get _source =>
  //     kIsWeb ? ap.UrlSource(localPath) : ap.DeviceFileSource(localPath!);

  Future<Source> _source() async {
    print('(DE34)${widget.sessionStepId!}....${await getPath(sessionStepId: widget.sessionStepId!, fileKind: FileKind.audio)}');
    return kIsWeb
        ? ap.UrlSource(await getPath(sessionStepId: widget.sessionStepId!, fileKind: FileKind.audio))
        : ap.DeviceFileSource(await getPath(sessionStepId: widget.sessionStepId!, fileKind: FileKind.audio));
  }
}
