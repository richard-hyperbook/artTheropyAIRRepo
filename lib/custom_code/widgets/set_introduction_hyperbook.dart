/*
// Automatic FlutterFlow imports
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'permissions.dart';
import 'package:hyperbook/appwrite_interface.dart';

class SetIntroductionHyperbook extends StatefulWidget {
  const SetIntroductionHyperbook({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  _SetIntroductionHyperbookState createState() =>
      _SetIntroductionHyperbookState();
}

HyperbooksRecord? tutorialHyperbook;

Future<HyperbooksRecord?> populateIntroductionHyperbook() async {
  //>//>print('(D831)');
  List<HyperbooksRecord> hypebookList;
  hypebookList = await listHyperbookList();
  //>//>print('(HT1)${hypebookList.length}');
  */
/*hypebookList = await queryHyperbooksRecordOnce(
    queryBuilder: (Query<Object?> HyperbooksRecord) =>
        HyperbooksRecord.where('type', isEqualTo: kHyperbookTutorialTypeNumber),
  );
  if (hypebookList.isNotEmpty) {
    FFAppState().introductionHyperbook = hypebookList[0].reference;
  } else {
    FFAppState().introductionHyperbook = null;
  }*//*


  for (int i = 0; i < hyperbookList.length; i++) {
    //>//>print('(HT2)${hypebookList[i].title}');
    if (hypebookList[i].title == 'Hyperbook Tutorial') {
      tutorialHyperbook = hypebookList[i];
      //>//>print('(HT3)${i}');
      break;
    }
  }
  await loadCachedChaptersReadReferencesCachedHyperbookIndex(
      hyperbook: tutorialHyperbook!.reference, user: currentUser);
  return tutorialHyperbook;
}

class _SetIntroductionHyperbookState extends State<SetIntroductionHyperbook> {
  @override
  Widget build(BuildContext context) {
    //%//>//>print('(D830)');
    chapterList.clear();
    return FutureBuilder<void>(
        future: populateIntroductionHyperbook(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasData) {
            //>//>print('(HT4)${tutorialHyperbook!.title}');
            return DrawMap3(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              user: currentUser!.reference,
              hyperbook: tutorialHyperbook!.reference,
              isIntroductionMap: true,
              hyperbookTitle: 'Hyperbook Tutorial',
              hyperbookBlurb: "Double-click 'Introduction' to get started",

              */
/*GetChapters(
                  width: MediaQuery.of(context).size.width,
                  height: 20,
                  drawMapWhenComplete: true,
                  hyperbookTitle: FFAppState().currentChapterTitle,
                  editHtmlWhenComplete: true,
                  body: 'BBBBB',
                  chapterTitle: 'CCCCC',
                  hyperbook: FFAppState().introductionHyperbook,
                  chapter: FFAppState().currentChapter,
                  isIntroductionMap: true,
                )*//*

            );
          } else {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            );
          }
        });
  }
}
*/
