// Automatic FlutterFlow imports
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';

// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';

import 'button_change_chapter_state.dart';
import 'permissions.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hyperbook/appwrite_interface.dart';
// import 'package:flutter_super_html_viewer/flutter_super_html_viewer.dart';
// import 'package:fwfh_svg/fwfh_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fwfh_svg/fwfh_svg.dart';

import 'toast.dart';

class DisplayChapterHtml extends StatefulWidget {
  const DisplayChapterHtml({
    super.key,
    this.width,
    this.height,
    this.body,
    this.hyperbook,
    this.user,
    this.chapter,
  });

  final double? width;
  final double? height;
  final String? body;
  final DocumentReference? hyperbook;
  final DocumentReference? user;
  final DocumentReference? chapter;

  @override
  _DisplayChapterHtmlState createState() => _DisplayChapterHtmlState();
}

// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

/*class MyWidgetFactory extends WidgetFactory with WebViewFactory {
  // optional: override getter to configure how WebViews are built
  @override
  bool get webViewMediaPlaybackAlwaysAllow => true;
  @override
  String? get webViewUserAgent => 'My app';
}*/

class MyWidgetFactory extends WidgetFactory with SvgFactory {}

const String _chars =
    'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class _DisplayChapterHtmlState extends State<DisplayChapterHtml> {
  @override
  Widget build(BuildContext context) {
    ChaptersRecord? chapter = localDB.getWorkingChapter();//#getChapterFromCache(widget.chapter!, widget.hyperbook!);
    //>//>print('(D998)${chapter!.body}');
    return SingleChildScrollView(
        // child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //GetChapters(
        //   width: 100,
        //  height: 100,
        //  hyperbook: widget.hyperbook!,
        //  user: widget.user!),
        //   Expanded(child:
        child: // HtmlContentViewer(htmlContent:  widget.body!),





            HtmlWidget(
      //widget.body!,
      //~chapter!.body!,
              localDB.getWorkingChapter()!.body!,
      // factoryBuilder: (){return HTMLWidgetFactory();},
      customWidgetBuilder: (element) {
        print(
            '(DX3)${element.localName}----${element.text}++++${element.outerHtml}****${element.nodeType}');
        if (element.localName == 's') {
          print(
              '(DX6)${element.text}++++${element.outerHtml}****${element.nodeType}');
          Icon? icon = kIconMapStandard[element.text];
          if (icon == null) {
            //>//>print('(DX6A)');
            return InlineCustomWidget(
                child: Text(element.text,
                    style: TextStyle(decoration: TextDecoration.lineThrough)));
          } else {
            return InlineCustomWidget(child: (kIconMapStandard[element.text]!));
          }
        }
        /*if (element.localName == 'img') {
          print(
              '(DX41)${element.text}++++${element.outerHtml}****${element.innerHtml}');
          List<String> elementList = element.outerHtml.split('"');
          //>//>print('(DX41A)${elementList[1]}');
          return Image.network(elementList[1]);
        }*/

        /*
        if (element.outerHtml.contains('<h1>')) {
          // String strippedInnerHtml =
          //     (element.innerHtml).replaceAll(RegExp(r"\s+"), "");
          //  Icon icon = kIconMapStandard[strippedInnerHtml]!;
          print(
              '(DX70)${element.text}****${element.innerHtml}%%%%${element.outerHtml}');
          return Text(element.outerHtml, style: TextStyle(color: Colors.red));
        }*/
      },
      //element.classes.contains('name') ? {'color': 'green'} : null;},
      onTapUrl: (String value) async {
        //  currentCachedChapterList = List.from(FFAppState().hyperbookcurrentCachedChapterList);
        //readReferenceList = List.from(FFAppState().userReadReferenceList);
        //%print(
        //    '(D44-0)$value');
        String correctedValue = value.replaceAll('#', '/');
        //var doc = DocumentReference()/*£_firestore.doc(correctedValue)*/;
        //>//>print('(D44-1)$correctedValue');
        DocumentReference? targetChapter;
        int chapterIndex = -1;
        if ((localDB.getWorkingChapterList() != null) &&
            (localDB.getWorkingChapterList().isNotEmpty)) {
          for (int i = 0; i < localDB.getWorkingChapterList().length; i++) {
            print(
                '(D44-2)${i}^${localDB.getWorkingChapterList()[i].reference!.path}*');
            if (value == ('#${localDB.getWorkingChapterList()[i].reference!.path}')) {
              chapterIndex = i;
              targetChapter = localDB.getWorkingChapterList()[i].reference;
              break;
            }
          }
        }
        // chapterIndex = 1;
        if (chapterIndex != -1) {
          await localDB.setupWorkingChapter(chapterReference: targetChapter);

          /*ReadReferencesRecord? readReferenceRecord =
              await getReadReferenceFromChapterOrCreate(
            chapter: localDB.getWorkingChapterList()[chapterIndex].reference,
            user: currentUser!.reference,
            hyperbook: widget.hyperbook,
            chapxCoord: localDB.getWorkingChapterList()[chapterIndex].xCoord!,
            chapyCoord: localDB.getWorkingChapterList()[chapterIndex].yCoord!,
          );
          DocumentReference? readReference;
          print(
              '(NG1)${localDB.getWorkingChapterList()[chapterIndex].reference!.path}****${currentUser!.reference!.path}&&&&${readReferenceRecord!.reference!.path}');
          if (readReferenceRecord != null)
            readReference = readReferenceRecord.reference;
          //   if(readReferenceRecord!.readStateIndex == 0) {
          */

          changeChapterState(
            context: context,
            chapter: targetChapter,
            hyperbook: localDB.getWorkingHyperbook().reference,
            readReference: localDB.getWorkingReadReference()!.reference,
            user: currentUser!.reference,
            newState: 1,
            ifExistNoChange: true,
            ifReadNewChapter: true,
            existingState: 0,
            localSetState: setState,
          );
          // }
        } else {
          toast(context, 'This chapter has been deleted', ToastKind.warning);
        }
        return true;
      },
      factoryBuilder: () => MyWidgetFactory(),
    )

        // )
        // ])

        );
  }
}
