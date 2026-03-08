import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

import 'package:record/record.dart';
import '../../appwrite_interface.dart';

mixin AudioRecorderMixin {
  Future<void> recordFile(AudioRecorder recorder, RecordConfig config,  String sessionStepId, int version) {
    print('(AU2WEB)${config}');

    return recorder.start(config, path: '');
  }

  Future<void> recordStream(AudioRecorder recorder, RecordConfig config, String sessionStepId, int version) async {
    final bytes = <int>[];
    final stream = await recorder.startStream(config);
    print('(AU3WEB)${config}');

    stream.listen(
          (data) => bytes.addAll(data),
      onDone: () => downloadWebData(
        web.URL.createObjectURL(
          web.Blob(<JSUint8Array>[Uint8List.fromList(bytes).toJS].toJS),
        ),
      ),
    );
  }

  void downloadWebData(String path) {
    // Simple download code for web testing
    final anchor = web.document.createElement('a') as web.HTMLAnchorElement
      ..href = path
      ..style.display = 'none'
      ..download = 'audio.wav';
    print('(AU4WEB)${anchor.innerText}');
    web.document.body!.appendChild(anchor);
    anchor.click();
    web.document.body!.removeChild(anchor);
  }

  Future<String> getPath({required String sessionStepId, required FileKind fileKind, required int version}) async {
    return  '';
  }

  Future<String> getTempDirPath() async {
    return '';
  }
}