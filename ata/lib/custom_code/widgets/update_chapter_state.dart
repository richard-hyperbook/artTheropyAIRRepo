// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

// import '/ba?ckend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../appwrite_interface.dart';

// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class UpdateChapterState extends StatefulWidget {
  const UpdateChapterState({
    super.key,
    this.width,
    this.height,
    this.chapter,
    this.hyperbook,
    this.user,
    this.minState,
  });

  final double? width;
  final double? height;
  final DocumentReference? chapter;
  final DocumentReference? hyperbook;
  final DocumentReference? user;
  final int? minState;

  @override
  _UpdateChapterStateState createState() => _UpdateChapterStateState();
}

class _UpdateChapterStateState extends State<UpdateChapterState> {
  updateChapter() async {
    int index = -1;
    for (int i = 0; i < FFAppState().chaptersRead.length; i++) {
      if (FFAppState().chaptersRead[i] == widget.chapter) {
        index = i;
        break;
      }
    }
    if (index == -1) {
     /*£ final Map<String, dynamic> readReferenceCreateData = createReadReferencesRecordData(
        chapter: widget.chapter,
        hyperbook: widget.hyperbook,
        readStateIndex: widget.minState,
      );*/

      /*£await ReadReferencesRecord.createDoc(widget.user!)
          .set(readReferenceCreateData);*/
    }
  }

  @override
  Widget build(BuildContext context) {
    updateChapter();
    return Container(child: const Text('RR loaded'));
  }
}
