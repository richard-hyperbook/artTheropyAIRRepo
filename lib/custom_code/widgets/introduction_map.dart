/*
// Automatic FlutterFlow imports
import 'dart:math';

import 'package:flutter/material.dart';

// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:hyperbook/appwrite_interface.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../../chapter_read/chapter_read_widget.dart';
import 'permissions.dart';

GlobalKey _keyScreen = GlobalKey();

class Link {
  Link({this.start, this.end});
  final int? start;
  final int? end;
}

List<Link> links = <Link>[
  // Link(start: 0, end: 1),
  // Link(start: 0, end: 2),
  // Link(start: 0, end: 3),
  // Link(start: 1, end: 2),
  // Link(start: 1, end: 3),
];

class DrawMap extends StatefulWidget {
  const DrawMap({
    super.key,
    this.width,
    this.height,
    this.user,
    this.hyperbook,
    this.hyperbookTitle,
  });

  final double? width;
  final double? height;
  final DocumentReference? user;
  final DocumentReference? hyperbook;
  final String? hyperbookTitle;

  @override
  _DrawMapState createState() => _DrawMapState();
}

// List<ChaptersRecord> chapterDocs = [];

List<ItemModel>? items;

class _DrawMapState extends State<DrawMap> {
  bool areChaptersLoaded = false;

  @override
  void initState() {
    super.initState();
    // setuptUserList(context);

    items = <ItemModel>[
      // ItemModel(offset: Offset(70, 100), text: 'text1A'),
      //  ItemModel(offset: Offset(200, 100), text: 'text2A'),
      //   ItemModel(offset: Offset(200, 230), text: 'text3'),
    ];
    populateChapters();
    areChaptersLoaded = false;
  }

  Widget makeScreen() {
    return Scaffold(
      key: _keyScreen,
      body: Column(children: <Widget>[
        ElevatedButton(
          child: const Text('Save'),
          onPressed: () async {
            //%//>//>print('(D10-1)');
            for (int i = 0; i < items!.length; i++) {
              */
/*£final Map<String, dynamic> chaptersUpdateData = createChaptersRecordData(
                xCoord: items![i].offset!.dx,
                yCoord: items![i].offset!.dy,
              );*//*

              //%print(
               //   '(D10-2)$i@${items![i].text}%${items![i].chapterReference}?$chaptersUpdateData');
              //£await items![i].chapterReference!.update(chaptersUpdateData);
            }
          },
        ),
        Expanded(
          child: SizedBox(
            height: 500,
            width: 1000,
            child: Stack(
              children: <Widget>[
                CustomPaint(
                  size: const Size(double.infinity, double.infinity),
                  painter: CurvedPainter(
                      //       links: links,//links.map((item) => item.offset!).toList(),
                      ),
                ),
                ..._buildItems()
              ],
            ),
          ),
        )
      ]),
    );
  }

  void populateChapters(
      //   DocumentReference? parent
      ) {
    // List<ChaptersRecord> chapterList =
    //     await queryChaptersRecordOnce(parent: parent);
    List<ReadReferencesRecord> readReferenceList = [];
    //£     await queryReadReferencesRecordOnce(parent: widget.user);

    ////+//%//>//>print('(C87-0)$chapterList');
    ////+//%//>//>print('(C87-1)$readReferenceList');
    areChaptersLoaded = true;
    for (int i = 0; i < chapterList.length; i++) {
      final ChaptersRecord chapter = chapterList[i];

      final List<Color> defaultColors = <Color>[
        Colors.black,
        Colors.lime,
        Colors.red,
        Colors.blue,
        Colors.amber,
        Colors.grey,
      ];

      final double x = chapterList[i].xCoord!;
      final double y = chapterList[i].yCoord!;
      final String title = chapterList[i].title!;
      final DocumentReference chapterRef = chapterList[i].reference!;
      final String body = chapterList[i].body!;
      Color color = Colors.grey;
      // final bool isStartChapter = chapterList[i].isStartChapter;
      // String chapterSymbol = ' ';
      // chapterSymbol = chapterList[i].chapterSymbol;
          int state = 0;
      DocumentReference? readReference;
      for (int j = 0; j < readReferenceList.length; j++) {
        // //%//>//>print('(D69-0)${readReferenceList[j].chapter}*${chapter.ffRef}');
        if (readReferenceList[j].chapter == chapter.reference) {
          readReference = readReferenceList[j].reference;
          state = readReferenceList[j].readStateIndex!;
          color = FFAppState().chosenColors[state];
          //%//>//>print('(D69-1)$state*$j£$color');
          break;
        }
      }
     ////%print(
     //     '(C87-2)${FFAppState().chosenColors}\${x}|$y;$chapter%$title*$chapter>$body');
      items!.add(ItemModel(
        offset: Offset(x, y),
        text: title,
        chapterReference: chapterRef,
        body: body,
        color: color,
        chapterState: state,
        readReference: readReference,
        borderRadius: */
/*£isStartChapter ? 20 :*//*
 0,

      ));
    }
    //+//%//>//>print('(D43-1)${links.length}');
    links.clear();
    for (int i = 0; i < chapterList.length; i++) {
      ////+//%//>//>print('(D43-0)${i}£${chapterList[i].ffRef!.path}');
      int stringPos = 0;
      final String body = chapterList[i].body!;
      int subStartPos = 0;
      int subEndPos = 0;
      while (stringPos != -1) {
        String targetRef = '';
        subStartPos = body.indexOf('hyperbooks/', stringPos);
        if (subStartPos != -1) {
          subEndPos = body.indexOf('"', subStartPos);
          if (subEndPos != -1) {
            targetRef = body.substring(subStartPos, subEndPos);
            for (int j = 0; j < chapterList.length; j++) {
              //      //%print(
              //        '(D43-1)${i}%${j}£${chapterList[j].ffRef!.path}&&&${targetRef}');
              if (chapterList[j].reference!.path == targetRef) {
                links.add(Link(start: i, end: j));
                //+//%//>//>print('(D43-2)${links.length}');
                break;
              }
            }
            //+//%//>//>print('(D43-3)$subEndPos');
            subStartPos = subEndPos;
          }
          //+//%//>//>print('(D43-)$subEndPos');
          if (subEndPos > 0) {
            stringPos = subEndPos;
          } else {
            stringPos = -1;
          }
          //+//%//>//>print('(D43-5)$subEndPos');
        } else {
          stringPos = -1;
        }
        //+//%//>//>print('(D43-6)$subEndPos');
      }
      //+//%//>//>print('(D43-7)$subEndPos');
    }
    //+//%//>//>print('(D43-8)${links.length}');

    return;
  }

  Function onDragStart(int index) => (double x, double y) {
        //%//>//>print('(D23-1)$x*$y?${Offset(x, y)}');
        setState(() {
          items![index] = items![index].copyWithNewOffset(Offset(x, y));
        });
      };

  @override
  Widget build(BuildContext context) {
    return makeScreen();
  }

  List<Widget> _buildItems() {
    final List<Widget> res = <Widget>[];
    //%//>//>print('(D21)${items!.length}');
    items!.asMap().forEach((int ind, ItemModel item) {
      //%//>//>print('(D26)${item.text}+${item.chapterReference}#${item.offset}@');
      res.add(_Item(
        onDragStart: onDragStart(ind),
        offset: item.offset,
        text: item.text,
        chapterReference: item.chapterReference,
        body: item.body,
        color: item.color,
        hyperbook: widget.hyperbook,
        chapterState: item.chapterState,
        readReference: item.readReference,
        borderRadius: item.borderRadius,
        chapterSymbol: item.chapterSymbol,
        chapter: item.chapter,
      ));
    });
    //%//>//>print('(D22)$res%$items');
    return res;
  }
}

class _Item extends StatelessWidget {
  const _Item({
    this.offset,
    this.onDragStart,
    this.text,
    this.chapterReference,
    this.body,
    this.color,
    this.hyperbook,
    this.chapterState,
    this.readReference,
    this.borderRadius,
    this.chapterSymbol,
    this.chapter,
  });

  final double? size = 40;
  final Offset? offset;
  final Function? onDragStart;
  final String? text;
  final DocumentReference? chapterReference;
  final String? body;
  final Color? color;
  final DocumentReference? hyperbook;
  final int? chapterState;
  final DocumentReference? readReference;
  final double? borderRadius;
  final String? chapterSymbol;
  final ChaptersRecord? chapter;

  _handleDrag(details) {
    // final positionScreen = _keyScreen.currentContext!.findRenderObject()!.localToGlobal(Offset.zero);

    //%//>//>print('(D23)$details£${details.globalPosition}');
    final x = details.globalPosition.dx;
    final y = details.globalPosition.dy - 100;
    onDragStart!(x, y);
  }

  @override
  Widget build(BuildContext context) {
    //%//>//>print('(D27)${offset!.dx}^${offset!.dy}&$text');
    return Positioned(
      left: offset!.dx - size! / 2,
      top: offset!.dy - size! / 2,
      child: GestureDetector(
          onPanStart: _handleDrag,
          onPanUpdate: _handleDrag,
          onDoubleTap: () async {
            //%//>//>print('(D24)$body%$chapterReference*$text+');
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ChapterReadWidget(
                    chapterReference: chapterReference,
                    title: text,
                    body: body,
                    hyperbook: hyperbook,
                    chapterState: chapterState,
                    readReference: readReference,
                    chosenColors: FFAppState().chosenColors.toList(),
                    chapterAuthor: chapter!.author,
                    chapterXCoord: chapter!.xCoord,
                    chapterYCoord: chapter!.yCoord,
                  ),
                ));
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius!),
                  ),
                  child: Text(
                    chapterSymbol!,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(text!),
              ])),
    );
  }
}

class CurvedPainter extends CustomPainter {
  // CurvedPainter({this.offsets});
  // final List<Offset>? offsets;
//  CurvedPainter({));
  // final List<Link>? links;

  @override
  void paint(Canvas canvas, Size size) {
    ////%//>//>print('(XH14B)$links%');
    if (links.isNotEmpty) {
      links.asMap().forEach((int index, Link link) {
        // if (index == 0) return;
        final Offset o2 = items![links[index].start!].offset!;
        final Offset o1 = items![links[index].end!].offset!;
        ////+//%//>//>print('(D42A)$o1*$o2&$index?$link');
        canvas.drawLine(
          o1,
          o2,
          Paint()
            ..color = Colors.black
            ..strokeWidth = 2,
        );
        final double x1 = o1.dx;
        final double y1 = o1.dy;
        final double x2 = o2.dx;
        final double y2 = o2.dy;
        final double xDiff = x2 - x1;
        final double yDiff = y2 - y1;
        final double angle = atan2(yDiff, xDiff);
        final double transx = (x1 + x2) * 0.5;
        final double transy = (y1 + y2) * 0.5;
        canvas.translate(transx, transy);
        canvas.rotate(angle);
        final Paint paint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.0;
        canvas.drawLine(const Offset(0.0, 0.0), const Offset(10.0, 5.0), paint);
        canvas.drawLine(const Offset(0.0, 0.0), const Offset(10.0, -5.0), paint);
        canvas.rotate(-angle);
        canvas.translate(-transx, -transy);
      });
    }
  }

  @override
  bool shouldRepaint(CurvedPainter oldDelegate) => true;
}

class ItemModel {
  ItemModel(
      {this.offset,
      this.text,
      this.chapterReference,
      this.body,
      this.color,
      this.chapterState,
      this.readReference,
      this.borderRadius,
      this.chapterSymbol,
      this.chapter});

  final Offset? offset;
  final String? text;
  final DocumentReference? chapterReference;
  final String? body;
  final Color? color;
  final int? chapterState;
  final DocumentReference? readReference;
  final double? borderRadius;
  final String? chapterSymbol;
  final ChaptersRecord? chapter;

  ItemModel copyWithNewOffset(Offset offset) {
    return ItemModel(
        offset: offset,
        text: text,
        chapterReference: chapterReference,
        body: body,
        color: color,
        chapterState: chapterState,
        readReference: readReference,
        borderRadius: borderRadius,
        chapterSymbol: chapterSymbol);
  }
}
*/
