// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

// import '/backend/backend.dart';
import '../../localDB.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Automatic FlutterFlow imports
import '../../chapter_read/chapter_read_widget.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import 'permissions.dart';
import 'package:hyperbook/appwrite_interface.dart';
import '../../flutter_flow/random_data_util.dart' as random_data;
import 'package:hyperbook/flutter_flow/flutter_flow_theme.dart';

class CustomIcons {
  CustomIcons._();

  static const String _kFontFam = 'CustomIcons';
  static const String? _kFontPkg = null;

  static const IconData book_1 = IconData(0xe800, fontFamily: _kFontFam);
  static const IconData remove_red_eye =
      IconData(0xe801, fontFamily: _kFontFam);
  static const IconData trash = IconData(0xe802, fontFamily: _kFontFam);
  static const IconData edit_1 = IconData(0xe803, fontFamily: _kFontFam);
  static const IconData local_see = IconData(0xe804, fontFamily: _kFontFam);
  static const IconData doc_new = IconData(0xe805, fontFamily: _kFontFam);
  static const IconData share = IconData(0xe806, fontFamily: _kFontFam);
  static const IconData eye_2 = IconData(0xe807, fontFamily: _kFontFam);
  static const IconData thumbs_up = IconData(0xe86d, fontFamily: _kFontFam);
  static const IconData thumbs_down = IconData(0xe86e, fontFamily: _kFontFam);
  static const IconData highlight = IconData(0xe897, fontFamily: _kFontFam);
  static const IconData heart = IconData(0xf004, fontFamily: _kFontFam);
  static const IconData book = IconData(0xf02d, fontFamily: _kFontFam);
  static const IconData edit = IconData(0xf044, fontFamily: _kFontFam);
  static const IconData eye = IconData(0xf06e, fontFamily: _kFontFam);
  static const IconData eye_slash = IconData(0xf070, fontFamily: _kFontFam);
  static const IconData share_alt = IconData(0xf1e0, fontFamily: _kFontFam);
  static const IconData trash_alt = IconData(0xf2ed, fontFamily: _kFontFam);
  static const IconData eye_closed = IconData(0xf366, fontFamily: _kFontFam);
  static const IconData eye_1 = IconData(0xf3a8, fontFamily: _kFontFam);
  static const IconData book_open = IconData(0xf518, fontFamily: _kFontFam);
  static const IconData spread = IconData(0xf527, fontFamily: _kFontFam);
  static const IconData highlighter = IconData(0xf591, fontFamily: _kFontFam);
  static const IconData book_reader = IconData(0xf5da, fontFamily: _kFontFam);

  static const Map<String, IconData> iconMap = <String, IconData>{
    'book_1': book_1,
    'remove_red_eye': remove_red_eye,
    'trash': trash,
    'edit_1': edit_1,
    'local_see': local_see,
    'doc_new': doc_new,
    'share': share,
    'eye_2': eye_2,
    'thumbs_up': thumbs_up,
    'thumbs_down': thumbs_down,
    'highlight': highlight,
    'heart': heart,
    'book': book,
    'edit': edit,
    'eye': eye,
    'eye_slash': eye_slash,
    'share_alt': share_alt,
    'trash_alt': trash_alt,
    'eye_closed': eye_closed,
    'eye_1': eye_1,
    'book_open': book_open,
    'spread': spread,
    'highlighter': highlighter,
    'book_reader': book_reader,
  };
}

List<DocumentReference>? _readReferenceList;

class ButtonChangeChapterState extends StatefulWidget {
  const ButtonChangeChapterState({
    super.key,
    this.width,
    this.height,
    this.readReference,
    this.chapter,
    this.user,
    this.newState,
    this.buttonLabel,
    this.buttonIcon,
    this.hyperbook,
    this.customIconString,
    this.tooltipMessage,
    required this.existingState,
    required this.localSetState,
  });

  final double? width;
  final double? height;
  final DocumentReference? readReference;
  final DocumentReference? chapter;
  final DocumentReference? user;
  final int? newState;
  final String? buttonLabel;
  final Widget? buttonIcon;
  final DocumentReference? hyperbook;
  final String? customIconString;
  final String? tooltipMessage;
  final int? existingState;
  final Function? localSetState;

  @override
  _ButtonChangeChapterStateState createState() =>
      _ButtonChangeChapterStateState();
}

class _ButtonChangeChapterStateState extends State<ButtonChangeChapterState> {
  static const double iconSize = 25;
  static const Color iconColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    print(
        '(D230-1A)${widget.chapter}£££££${widget.hyperbook}^^^^${widget.readReference}');
    // //>//>print('(D230-1B)${widget.chapter!.path}£££££${widget.hyperbook!.path}^^^^${widget.readReference!.path}');
    print(
        '(D230-11)${FFAppState().currentChapterStateIndex}£${FFAppState().chosenColors}');
    Widget icon = widget.buttonIcon!;
    if ((widget.customIconString != null) &&
        (widget.customIconString! != '') &&
        (widget.customIconString! != ' ')) {
      //%//>//>print('(N71)${0}');
      icon = kIconChooseChapterState;
    }
    print(
        '(N70)${icon}¤${widget.buttonIcon}!${widget.newState}^^^^${FFAppState().chosenColors.length}');
    return Tooltip(
        message: widget.tooltipMessage,
        child: FlutterFlowIconButton(
            tooltipMessage: widget.tooltipMessage,
            fillColor: /*FFAppState().chosenColors*/
                Color(currentUser!.chapterColorInts![widget.newState!]),
            borderRadius: 20,
            borderWidth: 1,
            buttonSize: 40,
            //color: Colors.amber, //FFAppState().chosenColors[widget.newState!],
            icon: icon,
            onPressed: () async {
              print(
                  '(D230-2)${widget.chapter!.path}£${widget.hyperbook!.path}^${widget.readReference}@${widget.user!.path}?${widget.newState}');
              changeChapterState(
                context: context,
                chapter: widget.chapter,
                hyperbook: widget.hyperbook,
                readReference: widget.readReference,
                user: widget.user,
                newState: widget.newState,
                ifExistNoChange: false,
                ifReadNewChapter: false,
                existingState: widget.existingState,
                localSetState: widget.localSetState,
              );
              await showDialog(
                context: context,
                builder: (BuildContext alertDialogContext) {
                  return AlertDialog(
                    backgroundColor:
                        /*FFAppState().chosenColors[widget.newState!]*/ Color(
                            currentUser!.chapterColorInts![widget.newState!]),
                    title: Text(
                        'Chapter state now = ${kChapterStateList[widget.newState!]}'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(alertDialogContext),
                        child: const Text('OK',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  );
                },
              );
            }));
  }
}

Future<void> changeChapterState(
    {required BuildContext? context,
    required DocumentReference? chapter,
    required DocumentReference? hyperbook,
    required DocumentReference? readReference,
    required DocumentReference? user,
    required int? newState,
    required bool ifExistNoChange,
    required bool ifReadNewChapter,
    required int? existingState,
    required Function? localSetState}) async  {
  // List<ReadReferencesRecord> readReferenceList = <ReadReferencesRecord>[];
  int finalState = newState!;
  print('(D231)$newState?$chapter£$ifExistNoChange***+$ifReadNewChapter');
  // bool isNewState = false;
  ChaptersRecord? chapterRecord;
  DocumentReference? localReadReference = readReference;;
  if (readReference == null) {
    chapterRecord = localDB.getChapterRecordFromWorkingList(chapter!);
    /*localReadReference = await localDB.createLocalDBReadReference(chapter: chapter,
        hyperbook: hyperbook,
        readStateIndex: kNotVisitedIndex,
        xCoord: chapterRecord!.xCoord,
        yCoord: chapterRecord.yCoord,
        parent: currentUser!.reference);*/
    //>//>print('[ERROR 1]');
  }
    /*final Map<String, dynamic> readReferencesUpdateData =
        createReadReferencesRecordData(
      readStateIndex: newState,
    );*/
    print('(SC1)${finalState}****${existingState}');
    if (currentUser!.userLevel == kUserLevelNotLoggedIn) {
      globalSharedPrefs.setInt(
          localReadReference!.path! + '.' + kConectedUserReadStateIndexPrefLabel,
          finalState);
      await localDB.updateReadReference(
        readReferenceIndex: localDB.getReadReferenceIndex(localReadReference),
        rp: kAttrReadReferenceReadStateIndex,
        value: existingState,
        contextualSetState: localSetState,
      );
      chapterHasBeenEdited = true;
      /*# await updateDocument(
          collection: readReferencesRef,
          document: readReference,
          data: {
            'readStateIndex': existingState,
          }
      );*/
    } else {
      print('(SC2)${finalState}****${existingState}>>>>${localDB.getReadReferenceIndex(localReadReference!)}!!!!${localReadReference.path}');
      await localDB.updateReadReference(
        readReferenceIndex: localDB.getReadReferenceIndex(localReadReference!),
        rp: kAttrReadReferenceReadStateIndex,
        value: finalState,
        contextualSetState: localSetState,
      );

      /*#await updateDocument(
      collection: readReferencesRef,
      document: readReference,
      data: {
        'readStateIndex': finalState,
      }
    );*/
      /*if (!ifExistNoChange) {
      await readReference.update(readReferencesUpdateData);
      //%//>//>print('(D232-2)');
      //%print(readReferencesUpdateData);
      isNewState = true;
    }*/
/*    //>//>print('(D233)');

    createReadReference(
      chapter: chapter,
      hyperbook: hyperbook,
      readStateIndex: finalState,
      xCoord: random_data.randomDouble(kMinRandomXCoord, kMaxRandomXCoord),
      yCoord: random_data.randomDouble(kMinRandomYCoord, kMaxRandomXCoord),
      parent: currentUser!.reference,
    );*/
      /*readReferenceList = await queryReadReferencesRecordOnce(
      parent: user,
      queryBuilder: (Query<Object?> ReadReferencesRecord) =>
          ReadReferencesRecord.where('chapter', isEqualTo: chapter),
    );
    //%//>//>print('(D234)${readReferenceList.length}^$chapter');
    if ((readReferenceList == null) || (readReferenceList.isEmpty)) {
      //%//>//>print('(D235)');

      final Map<String, dynamic> readReferencesCreateData =
          createReadReferencesRecordData(
        chapter: chapter,
        readStateIndex: newState,
        hyperbook: hyperbook,
      );
      //%//>//>print('(D236)$readReferencesCreateData');

      await ReadReferencesRecord.createDoc(user!).set(readReferencesCreateData);
      isNewState = true;
      //%//>//>print('(D237)');
    } else {
      final Map<String, dynamic> readReferencesUpdateData =
          createReadReferencesRecordData(
        readStateIndex: newState,
      );
      //%//>//>print('(D238)$newState');
      if (!ifExistNoChange) {
        await readReference!.update(readReferencesUpdateData);
        finalState = newState;
      } else {
        if (readReferenceList.isNotEmpty) {
        //  //%//>//>print('(N99)${0}');
          finalState = readReferenceList[0].readStateIndex;
        }
      }
      //%//>//>print('(D240)');
    }*/

  }

  /*if (ifReadNewChapter) {
    ChaptersRecord chapterRec;
    //chapterRec = await ChaptersRecord.getDocumentOnce(chapter!);
    chapterRec = await getChapter(
      document: chapter!,
    );
    //>//>print('(D241)');
    HyperbooksRecord hyperbookRec;
    hyperbookRec = await getHyperbook(document: hyperbook!);
    //%//>//>print('(D242)');

    *//*  if ((readReference != null) && ifExistNoChange) {
      ReadReferencesRecord readReferenceRec;
      readReferenceRec =
          await ReadReferencesRecord.getDocumentOnce(readReference);
      finalState = readReferenceRec.readStateIndex;
      //%//>//>print('(D243)$finalState');
    }*//*
    //>//>print('(NN40£)${FFAppState().chosenColors.toList()}');
    localDB.setWorkingChapter(chapter);
    await Navigator.push(
      context!,
      PageTransition(
        type: kStandardPageTransitionType,
        duration: kStandardTransitionTime,
        reverseDuration: kStandardReverseTransitionTime,
        child: ChapterReadWidget(
          chapterReference: chapter,
          title: chapterRec.title,
          body: chapterRec.body,
          hyperbookTitle: hyperbookRec.title,
          hyperbook: hyperbook,
          chapterState: finalState,
          readReference: readReference,
          chosenColors: FFAppState().chosenColors.toList(),
          chapterAuthor: chapterRec.author,
          chapterXCoord: chapterRec.xCoord,
          chapterYCoord: chapterRec.yCoord,
          hyperbookBlurb: hyperbookRec.blurb,
        ),
      ),
    );
  }*/
}
