/*
// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import 'button_change_chapter_state.dart';
import 'package:hyperbook/appwrite_interface.dart';

class IconButtonChapterRead extends StatefulWidget {
  IconButtonChapterRead({
    super.key,
    this.width,
    this.height,
    this.hyperbook,
    this.hyperbookTitle,
    this.chapter,
    this.chapterTitle,
    this.body,
    this.user,
    this.enabled = true,
    required this.chapxCoord,
    required this.chapyCoord,
  });

  final double? width;
  final double? height;
  final DocumentReference? hyperbook;
  final String? hyperbookTitle;
  final DocumentReference? chapter;
  final String? chapterTitle;
  final String? body;
  final DocumentReference? user;
  bool enabled;
  final double? chapxCoord;
  final double? chapyCoord;

  @override
  _IconButtonChapterReadState createState() => _IconButtonChapterReadState();
}

class _IconButtonChapterReadState extends State<IconButtonChapterRead> {
  ReadReferencesRecord? readReferenceFound;

  Widget readIconButton() {
    return FlutterFlowIconButton(
      enabled: widget.enabled,
      tooltipMessage: 'Read chapter',
      borderColor: Colors.transparent,
      borderRadius: 30,
      borderWidth: 1,
      buttonSize: 40,
      icon: kIconReadChapter,
      onPressed: () async {
        ReadReferencesRecord? readReferenceRecord =
            await getReadReferenceFromChapterOrCreate(
          chapter: widget.chapter,
          user: currentUser!.reference,
          hyperbook: widget.hyperbook,
          chapxCoord: widget.chapxCoord!,
          chapyCoord: widget.chapyCoord!,
        );
        DocumentReference? readReference;
        if (readReferenceRecord != null) {
          readReference = readReferenceRecord.reference;
        }
        print(
            '(D101-1)${widget.chapter}%%%%${readReference}>>>>$readReferenceFound');
        // if(readReferenceRecord!.readStateIndex == 0) {
        await changeChapterState(
          context: context,
          chapter: widget.chapter,
          hyperbook: widget.hyperbook,
          readReference: readReference,
          user: widget.user,
          newState: 1,
          ifExistNoChange: true,
          ifReadNewChapter: true,
          existingState: 0,
        );
        //  }

*/
/*

        context,
        DocumentReference? chapter,
        DocumentReference? hyperbook,
        DocumentReference? readReference,
        DocumentReference? user,
        int? newState,
        bool ifExistNoChange,
        bool ifReadNewChapter,
*//*


        //%print(
        //   '(D101-4)${widget.chapter}%${widget.chapterTitle}>$readReferenceFound');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //%//>//>print('(D102)${widget.chapter}%${widget.chapterTitle}');

    return readIconButton();
  }
}
*/
