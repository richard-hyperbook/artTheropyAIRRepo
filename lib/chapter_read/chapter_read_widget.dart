import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

// import '../custom_code/widgets/draw_map3.dart';
import '../chapter_edit/chapter_edit_widget.dart';
import '../custom_code/widgets/permissions.dart';
// import '/auth/firebase_auth/auth_util.dart';
import '/custom_code/widgets/button_change_chapter_state.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'chapter_read_model.dart';

export 'chapter_read_model.dart';
// import 'package:flutter_intro/flutter_intro.dart';
// import '/backend/backend.dart';
import 'package:hyperbook/appwrite_interface.dart';
import 'package:appwrite/appwrite.dart' as appwrite;
import '/custom_code/widgets/appwrite_realtime_subscribe.dart';
import '../../menu.dart';
import '../custom_code/widgets/toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyperbook/login/login_widget.dart';
import 'package:hyperbook/hyperbook_display/hyperbook_display_widget.dart';
// import 'package:hyperbook/map_display/map_display_widget.dart';
import 'package:hyperbook/chapter_display/chapter_display_widget.dart';


class ChapterReadWidget extends StatefulWidget {
  const ChapterReadWidget({
    super.key,
    this.chapterReference,
    this.title,
    this.body,
    this.hyperbookTitle,
    this.hyperbook,
    this.chapterState,
    this.chosenColors,
    this.chapterReaderIndex,
    this.readReference,
    this.chapterAuthor,
    this.chapterXCoord,
    this.chapterYCoord,
    this.hyperbookBlurb,
  });

  final DocumentReference? chapterReference;
  final String? title;
  final String? body;
  final String? hyperbookTitle;
  final DocumentReference? hyperbook;
  final int? chapterState;
  final List<Color>? chosenColors;
  final int? chapterReaderIndex;
  final DocumentReference? readReference;
  final DocumentReference? chapterAuthor;
  final double? chapterXCoord;
  final double? chapterYCoord;
  final String? hyperbookBlurb;

  @override
  _ChapterReadWidgetState createState() => _ChapterReadWidgetState();
}

class _ChapterReadWidgetState extends State<ChapterReadWidget> {
  late ChapterReadModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // Intro? intro;

  void externalSetState() {
    //>print('(R10X)chapter_read++++${context}');
    setState(() {});
  }

  _ChapterReadWidgetState() {
    //>print('(XI3A)');
    double screenWidth = WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.width;
    //>print('(XI3AA)${screenWidth}++++${kPhonewWidthThreashold}');
/*    if (screenWidth < kPhonewWidthThreashold) {
      intro = Intro(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        stepCount: 10,
        maskClosable: true,
        widgetBuilder: StepWidgetBuilder.useDefaultTheme(
          texts: [
            '\nThis colour shows the state of this chapter',
            '\nClick to see hyperbook map',
            '\nClick to edit this chapter',
            "\nClick to change chapter state",
            "\nClick to post comment on this chapter",
            "",
            "",
            "",
            "",
            "",
          ],
          buttonTextBuilder: (currPage, totalPage) {
            //%//>print('(XI1A)${currPage}%${totalPage}');
            return currPage < totalPage - 1 ? 'Next' : 'Finish';
          },
        ),
      );
    } else {
      intro = Intro(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        stepCount: 10,
        maskClosable: true,
        widgetBuilder: StepWidgetBuilder.useDefaultTheme(
          texts: [
            '\nThis colour shows the state of this chapter',
            '\nClick to see hyperbook map',
            '\nClick to edit this chapter',
            "\nClick to change chapter state to 'Not visited'",
            "\nClick to change chapter state to 'Visited'",
            "\nClick to change chapter state to 'Partially read'",
            "\nClick to change chapter state to 'Fully read'",
            "\nClick to change chapter state to 'Highlighted'",
            "\nClick to change chapter state to 'Deprecated'",
            "\nClick to post comment on this chapter",
          ],
          buttonTextBuilder: (currPage, totalPage) {
            //%//>print('(XI1B)${currPage}%${totalPage}');
            return currPage < totalPage - 1 ? 'Next' : 'Finish';
          },
        ),
      );
    }*/
/*    intro!.setStepConfig(
      0,
      borderRadius: BorderRadius.circular(64),
    );*/
    //%print(
    //   '(N1200)${MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width.toInt()}');
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChapterReadModel());
    //>print('(R10IA)${chapterReadPageChapterAppIsSubscribed}');
    if (!chapterReadPageChapterAppIsSubscribed) {
      chapterSubscribe(externalSetState);
      readReferenceSubscribe(externalSetState);
      //>print('(R10IB)${chapterReadPageChapterAppIsSubscribed}');
      chapterReadPageChapterAppIsSubscribed = true;
      chapterReadPageReadReferenceAppIsSubscribed = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    //>print('(R10D)${chapterReadPageChapterAppIsSubscribed}');
    if (chapterReadPageChapterAppIsSubscribed) {
      // if (chapterChapterSubscription != null) {
      //   chapterChapterSubscription!.close();
      // }
      // if (chapterReadReferenceSubscription != null) {
      //   chapterReadReferenceSubscription!.close();
      // }
      chapterReadPageChapterAppIsSubscribed = false;
      chapterReadPageReadReferenceAppIsSubscribed = false;
    }
    super.dispose();
  }

  Widget insertStateChangeButtons({bool onAppBar = false}) {
    //>print('(ISCB1)${onAppBar}^^^^${localDB.getWorkingReadReference()}');
    return Container(
      width: 500,
      child: Wrap(children: [
        SizedBox(
          // key: onAppBar ? intro!.keys[3] : Key('Not visited'),
          width: 40.0,
          height: 40.0,
          child: custom_widgets.ButtonChangeChapterState(
            width: 40.0,
            height: 40.0,
            newState: 0,
            buttonLabel: 'Not visited',
            buttonIcon: kIconNotVisited,
            readReference: localDB.getWorkingReadReference()!.reference,
            chapter: localDB.getWorkingChapter()!.reference,
            user: currentUser!.reference,
            hyperbook: localDB.getWorkingHyperbook().reference,
            customIconString: ' ',
            tooltipMessage: 'Not visited',
            existingState: localDB.getWorkingReadReference()!.readStateIndex,
            localSetState: setState,
          ),
        ),
        SizedBox(
          // key: onAppBar ? intro!.keys[4] : Key('Visited'),
          width: 40.0,
          height: 40.0,
          child: custom_widgets.ButtonChangeChapterState(
            width: 40.0,
            height: 40.0,
            newState: 1,
            buttonLabel: 'Visited',
            buttonIcon: kIconVisited,
            hyperbook: localDB.getWorkingHyperbook().reference,
            readReference: localDB.getWorkingReadReference()!.reference,
            chapter: localDB.getWorkingChapter()!.reference,
            user: currentUser!.reference,
            customIconString: ' ',
            tooltipMessage: 'Visited',
            existingState: localDB.getWorkingReadReference()!.readStateIndex,
            localSetState: setState,
          ),
        ),
        SizedBox(
          // key: onAppBar ? intro!.keys[5] : Key('Partially read'),
          width: 40.0,
          height: 40.0,
          child: custom_widgets.ButtonChangeChapterState(
            width: 40.0,
            height: 40.0,
            newState: 2,
            buttonLabel: 'Partially read',
            buttonIcon: kIconPariallyRead,
            hyperbook: localDB.getWorkingHyperbook().reference,
            readReference: localDB.getWorkingReadReference()!.reference,
            chapter: localDB.getWorkingChapter()!.reference,
            user: currentUser!.reference,
            customIconString: ' ',
            tooltipMessage: 'Partially read',
            existingState: localDB.getWorkingReadReference()!.readStateIndex,
            localSetState: setState,
          ),
        ),
        SizedBox(
          // key: onAppBar ? intro!.keys[6] : Key('Fully read'),
          width: 40.0,
          height: 40.0,
          child: custom_widgets.ButtonChangeChapterState(
            width: 40.0,
            height: 40.0,
            newState: 3,
            buttonLabel: 'Fully read',
            buttonIcon: kIconFullyRead,
            hyperbook: localDB.getWorkingHyperbook().reference,
            readReference:  localDB.getWorkingReadReference()!.reference,
            chapter: localDB.getWorkingChapter()!.reference,
            user: currentUser!.reference,
            customIconString: ' ',
            tooltipMessage: 'Fully read',
            existingState: localDB.getWorkingReadReference()!.readStateIndex,
            localSetState: setState,
          ),
        ),
        SizedBox(
          // key: onAppBar ? intro!.keys[7] : Key('Highlighted'),
          width: 40.0,
          height: 40.0,
          child: custom_widgets.ButtonChangeChapterState(
            width: 40.0,
            height: 40.0,
            newState: 4,
            buttonLabel: 'Highlighted',
            buttonIcon: kIconHighlighted,
            hyperbook: localDB.getWorkingHyperbook().reference,
            readReference:  localDB.getWorkingReadReference()!.reference,
            chapter: localDB.getWorkingChapter()!.reference,
            user: currentUser!.reference,
            customIconString: ' ',
            tooltipMessage: 'Highlighted',
            existingState: localDB.getWorkingReadReference()!.readStateIndex,
            localSetState: setState,
          ),
        ),
        SizedBox(
          // key: onAppBar ? intro!.keys[8] : Key('Depreciated'),
          width: 40.0,
          height: 40.0,
          child: custom_widgets.ButtonChangeChapterState(
            width: 40.0,
            height: 40.0,
            newState: 5,
            buttonLabel: 'Depreciated',
            buttonIcon: kIconDepreciated,
            hyperbook: localDB.getWorkingHyperbook().reference,
            readReference:  localDB.getWorkingReadReference()!.reference,
            chapter: localDB.getWorkingChapter()!.reference,
            user: currentUser!.reference,
            customIconString: ' ',
            tooltipMessage: 'Depreciated',
            existingState: localDB.getWorkingReadReference()!.readStateIndex,
            localSetState: setState,
          ),
        ),
      ]),
    );
  }

  Future<void> showChapterStateChangeDialog() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext alertDialogContext) {
        return AlertDialog(
            title: const Text('Set state of chapter'),
            content: insertStateChangeButtons(),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext, false),
                child: const Text('OK'),
              ),
            ]);
      },
    );
  }

  Widget stateChangeButtons() {
    if (MediaQuery.sizeOf(context).width < kPhonewWidthThreashold) {
      return SizedBox(
          width: 40,
          height: 40,
          child: FlutterFlowIconButton(
            // key: intro!.keys[3],
            tooltipMessage: 'Change chapter state',
            borderColor: FlutterFlowTheme.of(context).primaryBtnText,
            borderRadius: kAbbBarButtonSize / 2.0,
            borderWidth: 1,
            buttonSize: kAbbBarButtonSize,
            icon: kIconChooseChapterStateWhite,
            onPressed: showChapterStateChangeDialog,
          ));
    } else {
      return insertStateChangeButtons(onAppBar: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    // chapterClicked = widget.chapterReference!;
    // localDB.setWorkingChapter(widget.chapterReference!);
    /*#setCurrentCachedChapterIndex(chapter: widget.chapterReference!);*/
    //localDB.setWorkingChapter(widget.chapterReference!);
    // DocumentReference? readReference = getReadReferenceFromChapter(
    //     chapter: /*#currentCachedChapterList[currentCachedChapterIndex!].reference,*/
    //         localDB.getWorkingChapter()!.reference,
    //     user: currentUser!.reference);
    ReadReferencesRecord? readReference = localDB.getWorkingReadReference();
    print(
        '(NN20A)${localDB.getWorkingChapter()}');
    // print(
    //     '(NN20B)${localDB.getWorkingChapter()!.reference}}');
    // print(
    //     '(NN20C)${localDB.getWorkingChapter()!.reference!.path}@@@@${localDB.getWorkingChapter()}');
    // print(
    //     '(NN20D)${localDB.getWorkingChapter()!.reference!.path}@@@@${localDB.getWorkingChapter()!.body}');
    if (readReference != null) {
      int chapterState = readReference.readStateIndex!;
      //>print('(NN20A)${readReference.readStateIndex!}');

      if (chapterState == 0) {
        changeChapterState(
          context: context,
          chapter: localDB
              .getWorkingChapter()!
              .reference,
          hyperbook: widget.hyperbook,
          readReference: readReference.reference,
          user: currentUser?.reference,
          newState: 1,
          ifExistNoChange: false,
          ifReadNewChapter: false,
          existingState: readReference.readStateIndex,
          localSetState: setState,
        );
      }
    }
    // int infoCount = 0;
    // if (currentCachedHyperbook == null){
    //   setCachedHyperbookAndChapterList(widget.hyperbook!);
    // }
    // //>print('(NR0)${currentCachedChapterIndex}');
    // //>print('(NR1)${currentCachedChapterList[currentCachedChapterIndex!]}');

Future<void> changeChapterStateInMenu(int newState) async {
      //# //>print('(ME3)${currentCachedReadReferenceIndex}');
      changeChapterState(
        context: context,
        chapter: localDB.getWorkingChapter()!.reference,
        hyperbook: localDB.getWorkingHyperbook().reference,
        readReference: localDB.getWorkingReadReference()!.reference,
        user: currentUser?.reference,
        newState: newState,
        ifExistNoChange: false,
        ifReadNewChapter: false,
        existingState: localDB.getWorkingReadReference()!.readStateIndex,
        localSetState: setState,
      );
      /*#setCurrentCachedReadReferenceIndex(
          readReference: readReference.reference!);*/
      await localDB.setWorkingReadReference(readReference!.reference);
      //>print('(ME4)${localDB.getWorkingReadReference()!.reference!.path}');
      /*#currentCachedReadReferenceList[currentCachedReadReferenceIndex!]
          .readStateIndex = newState;*/
      // print(
      //     '(ME5)${localDB.getWorkingHyperbookLocalDB().workingReadReferenceIndex}');
      // localDB.getWorkingHyperbookLocalDB().readReferenceList[
      //     localDB.getWorkingHyperbookLocalDB().workingReadReferenceIndex!];
    }

    bool ableToComment = canUserCommentChapter(
        user: currentUser!.reference,
        hyperbookLocalDB: /*#cachedHyperbookList[currentCachedHyperbookIndex!]*/
        localDB.getWorkingHyperbookLocalDB(),
        // chapterAuthor: localDB.getWorkingChapter()!.author,//widget.chapterAuthor,
        chapter: localDB.getWorkingChapter()!.reference,//widget.chapterReference,
        // chapterXCoord: localDB.getWorkingChapter()!.xCoord,
        // chapterYCoord: localDB.getWorkingChapter()!.yCoord
      );

    bool ableToEdit = canUserWriteChapter(
        user: currentUser!.reference,
        hyperbook: /*#cachedHyperbookList[currentCachedHyperbookIndex!]*/
        localDB.getWorkingHyperbook(),
        // chapterAuthor: localDB.getWorkingChapter()!.author,//widget.chapterAuthor,
        chapter: localDB.getWorkingChapter()!.reference,//widget.chapterReference,
        // chapterXCoord: localDB.getWorkingChapter()!.xCoord,
        // chapterYCoord: localDB.getWorkingChapter()!.yCoord
         );

    MenuDetails chapterReadMenuDetails = MenuDetails(menuLabelList: [
      'Login',
      ableToComment ? 'Add comment' : '',
      'Hyperbook list',
      'Map',
      ableToEdit ? 'Edit chapter' : '',
      'Chapter list',
      'Not visited',
      'Visited',
      'Partially read',
      'Fully read',
      'Highlighted',
      'Depreciated',
    ], menuIconList: [
      kIconLogin,
      ableToComment ? kIconPostComment : kIconMinimize,
      kIconHyperbooks,
      kIconHyperbookMap,
      ableToEdit ? kIconEditChapter : kIconMinimize,
      kIconList,
      kIconNotVisited,
      kIconVisited,
      kIconPariallyRead,
      kIconFullyRead,
      kIconHighlighted,
      kIconDepreciated,
    ], menuColorList: [
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
      // FFAppState().chosenColors.toList()
      FFAppState().chosenColors[kNotVisitedIndex],
      FFAppState().chosenColors[kVisitedIndex],
      FFAppState().chosenColors[kPartiallyReadIndex],
      FFAppState().chosenColors[kFullyReadIndex],
      FFAppState().chosenColors[kHighlightedIndex],
      FFAppState().chosenColors[kDepredciatedIndex],

/*
      widget.chosenColors![kNotVisitedIndex],
      widget.chosenColors![kVisitedIndex],
      widget.chosenColors![kPartiallyReadIndex],
      widget.chosenColors![kFullyReadIndex],
      widget.chosenColors![kHighlightedIndex],
      widget.chosenColors![kDepredciatedIndex],
*/
    ], menuTargets: [
      (context) {
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
      (context) {
        if (ableToComment) {
          custom_widgets.showCommentDialog(
            context,
            localDB.getWorkingHyperbook().reference!,
            localDB.getWorkingReadReference()!.reference!,
            localDB.getWorkingChapter()!.body!,
            setState,
            localDB.getWorkingHyperbook().title!,
            localDB.getWorkingHyperbook().blurb!,
          );
        }
      },
      (context) {
        // context.goNamedAuth('hyperbook_display', context.mounted);
        Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: HyperbookDisplayWidget(),
            ));
      },
      (context) {/*
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
            'hyperbookBlurb': serializeParam(
              widget.hyperbookBlurb,
              ParamType.String,
            ),
          }.withoutNulls,
        );*/



      },
      ableToEdit ? (context) {
/*        context.pushNamed(
          'chapterEdit',
          queryParameters: <String, String?>{
            'chapter': serializeParam(
              widget.chapterReference,
              ParamType.DocumentReference,
            ),
            'title': serializeParam(
              widget.title,
              ParamType.String,
            ),
            'body': serializeParam(
              widget.body,
              ParamType.String,
            ),
            'hyperbookTitle': serializeParam(
              widget.hyperbookTitle,
              ParamType.String,
            ),
            'hyperbook': serializeParam(
              widget.hyperbook,
              ParamType.DocumentReference,
            ),
            'user': serializeParam(
              currentUser!.reference,
              ParamType.DocumentReference,
            ),
          }.withoutNulls,
        );*/
        Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration:kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: const ChapterEditWidget(
                /*hyperbook: widget.hyperbook,
                hyperbookTitle: widget.hyperbookTitle,
                hyperbookBlurb: '',*/
              ),));

      } : (context) {},
      (context) {
        //>print('(PN1)');
        /*context.pushNamed(
          'chapter_display',
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
              widget.hyperbookBlurb,
              ParamType.String,
            ),
          }.withoutNulls,
        );*/
        Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration:kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: const ChapterDisplayWidget(

              ),));
      },
      (context) async {
        await changeChapterStateInMenu(kNotVisitedIndex);
      },
      (context) async {
        await changeChapterStateInMenu(kVisitedIndex);
      },
      (context) async {
        await changeChapterStateInMenu(kPartiallyReadIndex);
      },
      (context) async {
        await changeChapterStateInMenu(kFullyReadIndex);
      },
      (context) async {
        await changeChapterStateInMenu(kHighlightedIndex);
      },
      (context) async {
        await changeChapterStateInMenu(kDepredciatedIndex);
      },
    ]);
    if (localDB.getWorkingChapter() == null){
      toast(context, 'Error in Chapter selection', ToastKind.error);
    }
    return Title(
        key: UniqueKey(),
        title: 'chapterRead',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              leading: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() {});
                    //>print('(RE1)');
                    Navigator.pop(context, true);
                  }),
              backgroundColor: FlutterFlowTheme.of(context).primary,
              title: RichText(
                text: TextSpan(
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Rubik',
                        color: Colors.white,
                        fontSize: 22.0),
                    children: [
                      // TextSpan(text: 'Hyperbook: '),
                      TextSpan(
                        text: localDB.getWorkingHyperbook().title,
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
                SizedBox(
                    // key: intro!.keys[0],
                    width: kAbbBarButtonSize,
                    height: kAbbBarButtonSize,
                    child: Container(
                      color:
                      FFAppState().chosenColors[readReference!.readStateIndex!],
                    )),
                /* SizedBox(
                  width: 40,
                  height: 40,
                  child: FlutterFlowIconButton(
                    key: intro!.keys[1],
                    tooltipMessage: 'Go to see hyperbook map',
                    borderColor: FlutterFlowTheme.of(context).primaryBtnText,
                    borderRadius: kAbbBarButtonSize / 2.0,
                    borderWidth: 1,
                    buttonSize: kAbbBarButtonSize,
                    icon: kIconHyperbookMapWhite,
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
                          'hyperbookBlurb': serializeParam(
                            widget.hyperbookBlurb,
                            ParamType.String,
                          ),
                        }.withoutNulls,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: FlutterFlowIconButton(
                    key: intro!.keys[2],
                    tooltipMessage: 'Edit this chapter',
                    borderColor: FlutterFlowTheme.of(context).primaryBtnText,
                    borderRadius: kAbbBarButtonSize / 2.0,
                    borderWidth: 1,
                    buttonSize: kAbbBarButtonSize,
                    icon: kIconEditChapterWhite,
                    onPressed: () async {
                      //>print('(N1105)${widget.chapterReference!.path}');
                      context.pushNamed(
                        'chapterEdit',
                        queryParameters: <String, String?>{
                          'chapter': serializeParam(
                            widget.chapterReference,
                            ParamType.DocumentReference,
                          ),
                          'title': serializeParam(
                            widget.title,
                            ParamType.String,
                          ),
                          'body': serializeParam(
                            widget.body,
                            ParamType.String,
                          ),
                          'hyperbookTitle': serializeParam(
                            widget.hyperbookTitle,
                            ParamType.String,
                          ),
                          'hyperbook': serializeParam(
                            widget.hyperbook,
                            ParamType.DocumentReference,
                          ),
                          'user': serializeParam(
                            currentUser!.reference,
                            ParamType.DocumentReference,
                          ),
                        }.withoutNulls,
                      );
                    },
                  ),
                ),
                */ /*Container(
                  width: 130.0,
                  height: 100.0,
                  constraints: const BoxConstraints(
                    maxWidth: 20.0,
                  ),
                  decoration: const BoxDecoration(),
                ),*/ /*
                stateChangeButtons(),
                SizedBox(width: 15),*/
                insertOutstandingRequestsButton(context),
               /* canUserCommentChapter(
                        user: currentUser!.reference,
                        hyperbookLocalDB:
                            localDB.getWorkingHyperbookLocalDB(),
                        *//*# cachedHyperbook:
                            cachedHyperbookList[currentCachedHyperbookIndex!],*//*
                        // chapterAuthor: localDB.getWorkingChapter()!.author,
                        chapter: localDB.getWorkingChapter()!.reference,
                        // chapterXCoord: localDB.getWorkingReadReference()!.xCoord,
                        // chapterYCoord: localDB.getWorkingReadReference()!.yCoord
                    )
                    ? SizedBox(
                        // key: intro!.keys[9],
                        width: 40.0,
                        height: 40.0,
                        child: custom_widgets.ButtonCreateChapterWithLinkTitle(
                          tooltipMessage: 'Post comment on this chapter',
                          width: 40.0,
                          height: 40.0,
                          body: localDB.getWorkingChapter()!.body,
                          hyperbook: localDB.getWorkingHyperbook().reference,
                          chapter: localDB.getWorkingChapter()!.reference,
                          hyperbookTitle: localDB.getWorkingChapter()!.title,
                          icon: kIconPostCommentWhite,
                          hyperbookBlurb: localDB.getWorkingHyperbook().blurb,
                        ),
                      )
                    : Container(),*/
                insertMenu(context, chapterReadMenuDetails, setState),
                GestureDetector(
                  onTap: () async {
                    /*#await loadCachedChaptersReadReferencesCachedHyperbookIndex(
                        hyperbook: tutorialHyperbook, user: currentUser);*/
                    toast(context, 'Please wait while Hyperbook Tutorial loads',
                        ToastKind.success);
                    localDB.setTutorialAsWorkingHyperbook();
                    /*context.pushNamed(
                      'map_display',
                      queryParameters: <String, String?>{
                        'hyperbook': serializeParam(
                          localDB.getWorkingHyperbook().reference,
                          ParamType.DocumentReference,
                        ),
                        'hyperbookTitle': serializeParam(
                          localDB.getWorkingHyperbook().title,
                          ParamType.String,
                        ),
                        'hyperbookBlurb': serializeParam(
                          localDB.getWorkingHyperbook().blurb,
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );*/

                  },
                  child: SvgPicture.asset(
                    'assets/images/hyperbooklogosvg10.svg',
                    width: 40,
                    height: 40,
                  ),
                ),
                /*InkWell(
                  onTap: () async {
                    //  //%//>print('(XI5)${intro!.stepCount}');
                    intro!.start(context);
                  },
                  child: kIconInfoStartWhite,
                ),*/
              ],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: /*Text(
                            'Chapter: ${widget.title!}',
                            overflow: TextOverflow.visible,
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                          ),*/

                              RichText(
                            text: TextSpan(
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                        fontFamily: 'Rubik',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 22.0),
                                children: [
                                  // TextSpan(text: 'Chapter: '),
                                  TextSpan(
                                    text: localDB.getWorkingChapter()!.title,
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily: 'Rubik',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontStyle: FontStyle.italic,
                                        ),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 0.0, 20.0, 0.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.9,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 0.9,
                          child: custom_widgets.DisplayChapterHtml(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.9,
                            body: localDB.getWorkingChapter()!.body,
                            /*#widget.body,*/
                            hyperbook: localDB.getWorkingHyperbook().reference,
                            user: currentUser!.reference,
                            chapter: localDB.getWorkingChapter()!.reference,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
