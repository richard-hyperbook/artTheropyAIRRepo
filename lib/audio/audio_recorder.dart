import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../../platform/audio_recorder_platform.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../appwrite_interface.dart';

class Recorder extends StatefulWidget {
  final void Function(String path, bool deleteFirst) onStop;
  final Future<bool> Function() carryOn;

  const Recorder({super.key, required this.onStop, required this.carryOn});

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> with AudioRecorderMixin {
  int _recordDuration = 0;
  Timer? _timer;
  late final AudioRecorder _audioRecorder;
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  bool _askIfOverwrite = false;
  // bool _overwrite = false;
  bool _deleteStorageFile = false;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;

  @override
  void initState() {
    _audioRecorder = AudioRecorder();
    // _overwrite = false;
    _deleteStorageFile = false;
    _askIfOverwrite = false;
    print('(AU75)');

    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      _updateRecordState(recordState);
    });

    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) {
      setState(() => _amplitude = amp);
    });
    print('(AU105)${_askIfOverwrite}');
    super.initState();
  }

  Future<void> _start() async {
    bool localCarryOn = await widget.carryOn();
    await setCurrentLocalAudioPath();
    try {
      if (await _audioRecorder.hasPermission()) {
        const encoder = AudioEncoder.aacLc;

        if (!await _isEncoderSupported(encoder)) {
          return;
        }

        print('(AU400)${localCarryOn}');
        if (localCarryOn) {
          print('(AU402)');
          _askIfOverwrite = true;
          // _overwrite = false;

          print('(AU73)');

          final devs = await _audioRecorder.listInputDevices();
          debugPrint(devs.toString());

          const config = RecordConfig(encoder: encoder, numChannels: 1);

          // Record to file
          await recordFile(_audioRecorder, config);

          // Record to stream
          // await recordStream(_audioRecorder, config);

          _recordDuration = 0;

          _startTimer();
        } else {
          setState(() {
            print('(AU102)');
            _askIfOverwrite = false;
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    final path = await _audioRecorder.stop();

    if (path != null) {
      print('(AU70)${_deleteStorageFile}');
      widget.onStop(path, _deleteStorageFile);
      _deleteStorageFile = false;

      downloadWebData(path);
    }
  }

  Future<void> _pause() => _audioRecorder.pause();

  Future<void> _resume() => _audioRecorder.resume();

  void _updateRecordState(RecordState recordState) {
    setState(() => _recordState = recordState);

    switch (recordState) {
      case RecordState.pause:
        _timer?.cancel();
        break;
      case RecordState.record:
        _startTimer();
        break;
      case RecordState.stop:
        _timer?.cancel();
        _recordDuration = 0;
        break;
    }
  }

  Future<bool> _isEncoderSupported(AudioEncoder encoder) async {
    final isSupported = await _audioRecorder.isEncoderSupported(
      encoder,
    );

    if (!isSupported) {
      debugPrint('${encoder.name} is not supported on this platform.');
      debugPrint('Supported encoders are:');

      for (final e in AudioEncoder.values) {
        if (await _audioRecorder.isEncoderSupported(e)) {
          debugPrint('- ${e.name}');
        }
      }
    }

    return isSupported;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildRecordStopControl(),
          const SizedBox(width: 5),
          _buildPauseResumeControl(),
          const SizedBox(width: 5),
          _buildText(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_recordState != RecordState.stop) {
      icon = const Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withValues(alpha: 0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withValues(alpha: 0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (_recordState != RecordState.stop) ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (_recordState == RecordState.stop) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (_recordState == RecordState.record) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withValues(alpha: 0.1);
    } else {
      final theme = Theme.of(context);
      icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withValues(alpha: 0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (_recordState == RecordState.pause) ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_recordState != RecordState.stop) {
      return _buildTimer();
    }
    if (_askIfOverwrite) {
      final Widget response =
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text('Recording\nexists'),
        SizedBox(width: 5),
        ChoiceChip(
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          showCheckmark: false,
          selectedColor: FlutterFlowTheme.of(context).tertiary,
          selected: (false),
          // height: kChickletHeight,
          onSelected: (ok) async {
            _askIfOverwrite = false;
            print('(AU500)${currentLocalAudioPath}');
            // _overwrite = true;
            await setCurrentLocalAudioPath();
            _deleteStorageFile = true;
            await deleteLocalFile(currentLocalAudioPath!);
            print('(AU501)${currentLocalAudioPath}');
            _start();
            print('(AU502)');
            setState(() {});
          },
          label: Text('Overwrite'),
        ),
        SizedBox(width: 5),
        ChoiceChip(
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          showCheckmark: false,
          selectedColor: FlutterFlowTheme.of(context).tertiary,
          selected: (false),
          // height: kChickletHeight,
          onSelected: (ok) {
            _askIfOverwrite = true;
            // _overwrite = false;
            print('(AU72)');
            setState(() {});
          },
          label: Text('Cancel'),
        ),
      ]);
      return response;
    }
    return const Text("Waiting to record");
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }
}
