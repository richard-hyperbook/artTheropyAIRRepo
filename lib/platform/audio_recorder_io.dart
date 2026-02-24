// ignore_for_file: avoid_print

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../../appwrite_interface.dart';

mixin AudioRecorderMixin {
  Future<void> recordFile(AudioRecorder recorder, RecordConfig config,  String sessionStepId, int version) async {
    final path = await getPath(sessionStepId: sessionStepId, fileKind: FileKind.audio, version: version);
    print('(AU10)${path}');
    await recorder.start(config, path: path);
    print('(AU11)${config}');
  }

  Future<void> recordStream(AudioRecorder recorder, RecordConfig config,  String sessionStepId, int version) async {
    final path = await getPath(sessionStepId: sessionStepId, fileKind: FileKind.audio, version: version);

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


  Future<String> getPath({required String sessionStepId, required FileKind fileKind, required int version}) async {
    final dir = await getApplicationDocumentsDirectory();
    print('(AU1IO)${dir.path}');
    String prefix = '';
    String suffix = '';
    switch(fileKind){
      case FileKind.audio:
        prefix = 'audio';
        suffix = '.wav';
        break;
      case FileKind.photo:
        prefix = 'photo';
        suffix = '.jpg';
        break;
    }
    return p.join(
      dir.path,
      prefix + sessionStepId + '_${version}' + suffix
    );
  }
}