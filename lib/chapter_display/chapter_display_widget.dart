import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

import 'chapter_display_model.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter_intro/flutter_intro.dart';
import 'package:hyperbook/custom_code/widgets/permissions.dart';
import 'package:hyperbook/custom_code/widgets/toast.dart';
import 'package:hyperbook/app_state.dart';
import 'package:hyperbook/appwrite_interface.dart';
// import 'package:hyperbook/custom_code/widgets/appwrite_realtime_subscribe.dart';
import 'package:hyperbook/custom_code/widgets/button_change_chapter_state.dart';
import '../../menu.dart';
import 'package:hyperbook/login/login_widget.dart';
import 'package:hyperbook/session_display/session_display_widget.dart';
// import 'package:hyperbook/map_display/map_display_widget.dart';
import 'package:hyperbook/chapter_edit/chapter_edit_widget.dart';
import 'package:hyperbook/chapter_read/chapter_read_widget.dart';
export 'chapter_display_model.dart';

class ChapterDisplayWidget extends StatefulWidget {
  const ChapterDisplayWidget({
    super.key,
    this.hyperbook,
    this.hyperbookTitle,
  });

  final DocumentReference? hyperbook;
  final String? hyperbookTitle;

  @override
  _ChapterDisplayWidgetState createState() => _ChapterDisplayWidgetState();
}

class _ChapterDisplayWidgetState extends State<ChapterDisplayWidget> {
  late ChapterDisplayModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // Intro? intro;
  _ChapterDisplayWidgetState() {
    //%//>print('(XI3)');
   /* intro = Intro(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      stepCount: 6,
      maskClosable: true,
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
        texts: [
          '\nClick to see hyperbook map',
          'Chapter title',
          'Chapter author',
          'Edit chapter',
          'Read chapter',
          'Delete chapter',
        ],
        buttonTextBuilder: (currPage, totalPage) {
          //%//>print('(XI1)${currPage}%${totalPage}');
          return currPage < totalPage - 1 ? 'Next' : 'Finish';
        },
      ),
    );
    intro!.setStepConfig(
      0,
      borderRadius: BorderRadius.circular(64),
    );*/
  }
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChapterDisplayModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    // chapterUnsubscribe();
    chapterReadPageChapterAppIsSubscribed = false;
    //>print('(DC1)');

    super.dispose();
  }

  void externalSetState() {
    //>print('(ES1)chhapter_display++++${context}');
    setState(() {});
  }

  // List<ChaptersRecord> listViewChaptersRecordList = [];
  int infoCount = 0;
  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    //# setCachedHyperbookAndChapterList(widget.hyperbook!);
    /*localDB.setWorkingHyperbookAndConnectedUser(//widget.hyperbook!);
        hyperbook: localDB.getWorkingHyperbook().reference,//#widget.hyperbook!,
        user: currentUser!.reference);*/
    if (!chapterReadPageChapterAppIsSubscribed) {
      // chapterSubscribe(externalSetState);
      chapterReadPageChapterAppIsSubscribed = true;
    }
    //>print('(NC1)${localDB.workingChapterList().length}');

    MenuDetails chapterDisplayMenuDetails = MenuDetails(menuLabelList: [
      'Login',
      'Hyperbook list',
      'Map',
      //'Chapter state',
    ], menuIconList: [
      kIconLogin,
      kIconHyperbooks,
      kIconHyperbookMap,
      // kIconChooseChapterState,
    ], menuColorList: [
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
    ], menuTargets: [
      (context) async {
        // context.goNamedAuth('login', context.mounted);

        Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration:kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: LoginWidget(),
            ));
      },
      (context)  async {
        // context.goNamedAuth('hyperbook_display', context.mounted);

        Navigator.push(
            context,
            PageTransition(
            type: kStandardPageTransitionType,
            duration:kStandardTransitionTime,
            reverseDuration: kStandardReverseTransitionTime,
            child: SessionDisplayWidget(),));
      },
      (context) {
/*        context.pushNamed(
          'map_display',
          queryParameters: <String, String?>{
            'hyperbook': serializeParam(
              widget.hyperbook,
              ParamType.DocumentReference,
            ),
            'hyperbookTitle': serializeParam(
              widget.hyperbookTitle,
              ParamType.String,
            ),
            'hyperbookBlurb': serializeParam(
              '',
              ParamType.String,
            ),
          }.withoutNulls,
        );*/

      },
    ]);

    return Title(
        title: 'chapter_display',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: const Color(0xFFF5F5F5),
            appBar: AppBar(
              leading: BackButton(color: Colors.white),
              backgroundColor: FlutterFlowTheme.of(context).primary,
              title: RichText(
                text: TextSpan(
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Rubik',
                        color: Colors.white,
                        fontSize: 22.0),
                    children: [
                      TextSpan(text: 'Chapters of '),
                      TextSpan(
                        text: 'XXX12',//localDB.getWorkingHyperbook().title!,//#widget.hyperbookTitle,
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Rubik',
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ]),
              ),
              actions: <Widget>[
             Text('XXX13')
                /* SizedBox(
                  width: 40,
                  height: 40,
                  child: FlutterFlowIconButton(
                    key: intro!.keys[0],
                    tooltipMessage: 'Go to hyperbook map',
                    borderColor: FlutterFlowTheme.of(context).primaryBtnText,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 60,
                    icon: kIconHyperbookMap,
                    fillColor: kIconHyperbookMapWhite.color,
                    hoverColor: kIconHyperbookMapWhite.color,
                    onPressed: () async {
                      context.pushNamed(
                        'map_display',
                        queryParameters: <String, String?>{
                          'hyperbook': serializeParam(
                            widget.hyperbook,
                            ParamType.DocumentReference,
                          ),
                          'hyperbookTitle': serializeParam(
                            widget.hyperbookTitle,
                            ParamType.String,
                          ),
                        }.withoutNulls,
                      );
                    },
                  ),
                ),*/

/*                InkWell(
                  onTap: () async {
                    //%//>print('(XI5)${intro!.stepCount}');
                    // intro!.start(context);
                  },
                  child: kIconInfoStartWhite,
                ),*/
              ],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 0.9,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount:2,
                      itemBuilder: (BuildContext context, int listViewIndex) {
                        // return (Text(listViewChaptersRecord.title!));

                        /*  ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: listViewChaptersRecordList.length,
                          itemBuilder:
                              (BuildContext context, int listViewIndex) {
                            final ChaptersRecord listViewChaptersRecord =
                                listViewChaptersRecordList[listViewIndex];*/
                        infoCount++;
                        return Material(
                            color: Colors.transparent,
                            elevation: 5.0,
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              width: MediaQuery
                                  .sizeOf(context)
                                  .width * 1.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5)),
                                color: FlutterFlowTheme
                                    .of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x33000000),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                border: Border.all(
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      // key: infoCount == 1
                                      //     ? intro!.keys[1]
                                      //     : UniqueKey(),
                                      children: <Widget>[
                                        Text(
                                          'Title: ',
                                          style: FlutterFlowTheme
                                              .of(context)
                                              .bodyMedium,
                                        ),

                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      // key: infoCount == 1
                                      //     ? intro!.keys[2]
                                      //     : UniqueKey(),
                                        children: <Widget>[
                                          Text(
                                            'Author: ',
                                            style: FlutterFlowTheme
                                                .of(context)
                                                .bodyMedium,
                                          ),
                                          SizedBox(
                                            width: 150.0,
                                            height: 20.0,
                                            child: Text('XXX14',
                                              style: FlutterFlowTheme
                                                  .of(context)
                                                  .bodyText1,
                                            ), /*custom_widgets
                                                .DisplayChapterAuthor(
                                              width: 150.0,
                                              height: 20.0,
                                              author: listViewChaptersRecord.author,*/ //?????
                                          ),
                                          Align(
                                              alignment: const AlignmentDirectional(
                                                  0.0, -0.05),
                                              child: FlutterFlowIconButton(
                                                icon: Text('XXX16'),
                                                caption: 'Edit',
                                              ))


                                        ]),
                                  ),
                                  FlutterFlowIconButton(
                                      caption: 'Read',

                                      icon: kIconReadChapter,
                                      tooltipMessage: 'Read this chapter',
                                      borderColor: Colors.transparent,
                                      borderRadius: 30.0,
                                      borderWidth: 1.0,
                                      buttonSize: 40.0,
                                      onPressed: () async {
                                        await Navigator.push(
                                            context,
                                            PageTransition(
                                                type: kStandardPageTransitionType,
                                                duration: kStandardTransitionTime,
                                                reverseDuration: kStandardReverseTransitionTime,
                                                child: ChapterReadWidget()));
                                      }

                                  ),
                                  FlutterFlowIconButton(
                                    caption: 'Delete',
                                    icon: kIconReadChapter,
                                    // chapterAuthor:
                                    //     listViewChaptersRecord.author,
                                    // chapterXCoord:
                                    //     listViewChaptersRecord.xCoord,
                                    // chapterYCoord:
                                    //     listViewChaptersRecord.yCoord,
                                  )

                                  // key: infoCount == 1
                                  //     ? intro!.keys[5]
                                  //     : UniqueKey(),

                                  /*#  localDB
                                              .getHyperbooksRecordFromReference(
                                                  widget.hyperbook!);*/

                                ],
                              ),
                            ));
                      }
                            ),
                          ),
                        ]))
          )
  )
    );







  }
}
