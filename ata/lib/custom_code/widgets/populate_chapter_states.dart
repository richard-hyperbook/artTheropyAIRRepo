// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../appwrite_interface.dart';

class PopulateChapterStates extends StatefulWidget {
  const PopulateChapterStates({
    super.key,
    this.width,
    this.height,
    this.user,
    this.hyperbook,
  });

  final double? width;
  final double? height;
  final DocumentReference? user;
  final DocumentReference? hyperbook;

  @override
  _PopulateChapterStatesState createState() => _PopulateChapterStatesState();
}

class _PopulateChapterStatesState extends State<PopulateChapterStates> {
  Future<List<String>> populateChapters(
      DocumentReference? user, DocumentReference? hyperbook) async {
    //%//>//>print('(D84-1)');

    //+//%//>//>print('(C87A-0)$chapterList');
    //+//%//>//>print('(C87A-1)$readReferenceList');
    FFAppState().chaptersRead.clear();
    FFAppState().chaptersReadState.clear();
    FFAppState().chaptersReadStateColors.clear();

    return [];
  }

  /*
  Future<List<ReadReferencesRecord>> populateChapters(
      DocumentReference? parent) async {
//    List<ReadReferencesRecord> readReferencesRecordList =
//        await queryReadReferencesRecordOnce(parent: widget.user,
//            ('hyperbook', isEqualTo: widget.hyperbook));
    
        List<ReadReferencesRecord> readReferencesRecordList =
        await queryReadReferencesRecordOnce(parent: widget.user,
            queryBuilder: (ReadReferencesRecord) => ReadReferencesRecord
                .where('hyperbook', isEqualTo: widget.hyperbook),);

    
    
    //%//>//>print('(D87-1)${readReferencesRecordList}');
    FFAppState().chaptersRead.clear();
    FFAppState().chaptersReadState.clear();
    for (int i = 0; i < readReferencesRecordList.length; i++) {
      FFAppState().chaptersRead.add(readReferencesRecordList[i].reference);
      FFAppState()
          .chaptersReadState
          .add(readReferencesRecordList[i].readStateIndex!);
    }
    //%//>//>print('(D87-2)${FFAppState().chaptersRead}&${FFAppState().chaptersReadState}');
    return readReferencesRecordList;
  }
*/

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: populateChapters(widget.user, widget.hyperbook),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasData) {
            return const Text('Loaded');
          } else {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              ),
            );
          }
        });
  }
}
