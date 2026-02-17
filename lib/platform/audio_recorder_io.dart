// ignore_for_file: avoid_print

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../appwrite_interface.dart';

mixin AudioRecorderMixin {
  Future<void> recordFile(AudioRecorder recorder, RecordConfig config) async {
    final path = await _getPath();
    print('(AU10)${path}');
    await recorder.start(config, path: path);
    print('(AU11)${config}');
  }

  Future<void> recordStream(AudioRecorder recorder, RecordConfig config) async {
    final path = await _getPath();

    final file = File(path);
    print('(AU12)${path}');

    final stream = await recorder.startStream(config);
    print('(AU13)${path}');

    stream.listen(
      (data) {
        file.writeAsBytesSync(data, mode: FileMode.append);
      },
      onDone: () {
        print('(AU14)End of stream. File written to $path.');
      },
    );
  }

  void downloadWebData(String path) {}

  Future<void> setCurrentLocalAudioPath() async {
    print('(AU0IO)');
    await _getPath();
  }

  Future<String> _getPath() async {
    final dir = await getApplicationDocumentsDirectory();
    print('(AU1IO)${dir.path}....${currentSessionStep}');
    String path =  p.join(
      dir.path,
      'audio${currentSessionStep!.reference!.path}.m4a',
    );
    currentLocalAudioPath = path;
    return path;
  }

  Future<void> deleteLocalFile(String path) async {
    print('(AU300)${path}');
    try {
      File file = File(path);
      await file.delete();
    } on Exception catch (e){
      print('(AU30E)${e}');
    }
  }

}
