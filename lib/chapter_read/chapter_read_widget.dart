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
// import '/custom_code/widgets/appwrite_realtime_subscribe.dart';
import '../../menu.dart';
import '../custom_code/widgets/toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyperbook/login/login_widget.dart';
import 'package:hyperbook/session_display/session_display_widget.dart';
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
      // chapterSubscribe(externalSetState);
      // readReferenceSubscribe(externalSetState);
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



  Future<void> showChapterStateChangeDialog() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext alertDialogContext) {
        return AlertDialog(
            title: const Text('Set state of chapter'),
            content: Text('XX8'),
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
      return Text('XXX9');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Text('XXX11');
  }
}
