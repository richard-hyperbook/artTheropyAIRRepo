import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
// import '/backend/firebase_storage/storage.dart';
import '../index.dart';
import '../localDB.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'sales_model.dart';
import 'package:hyperbook/appwrite_interface.dart';
import 'package:appwrite/models.dart' as models;
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:hyperbook/conditional.dart';
export 'sales_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '/../custom_code/widgets/toast.dart';
// import 'package:hyperbook/map_display/map_display_widget.dart';
import 'package:hyperbook/hyperbook_edit/hyperbook_edit_widget.dart';
import 'package:hyperbook/chapter_display/chapter_display_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hyperbook/paypal/paypal_widget.dart';

class SalesWidget extends StatefulWidget {
  const SalesWidget({super.key});

  @override
  _SalesWidgetState createState() => _SalesWidgetState();
}

class _SalesWidgetState extends State<SalesWidget> {
  late SalesModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late VideoPlayerController videoPlayercontroller;
  bool videoIsInitialized = false;
  AnimatedTextController? animatedTextController;

  Future<void> initVideo() async {
    videoIsInitialized = false;
    videoPlayercontroller = await VideoPlayerController.networkUrl(Uri.parse(
        // 'https://tin.syi.mybluehost.me/images/woodland7.mp4',
        // 'https://fra.cloud.appwrite.io/v1/storage/buckets/6976480a000f753c7f66/files/69764845002270220aa0/view?project=696ddda6001b28f2352e&mode=admin',
        'https://fra.cloud.appwrite.io/v1/storage/buckets/6976480a000f753c7f66/files/697b914d000bc9a390e2/view?project=696ddda6001b28f2352e&mode=admin'))
      ..initialize().then((_) {
        startupVideo();
        // video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    ;
    print(
        '(SA1) ${videoPlayercontroller!.value.isInitialized}++++${videoIsInitialized}');
    videoPlayercontroller!.setLooping(true);
    videoIsInitialized = true;
  }

  Future<void> startupVideo() async {
    print(
        '(SA4) ${videoPlayercontroller!.value.isInitialized}++++${videoIsInitialized}');
    videoPlayercontroller!.setVolume(0);
    await videoPlayercontroller!.play();
    print(
        '(SA7) ${videoPlayercontroller!.value.isInitialized}++++${videoIsInitialized}');
    videoPlayercontroller!.setLooping(true);
  }

  @override
  void initState() {
    print('(SA40)');
    super.initState();
    _model = createModel(context, () => SalesModel());
    animatedTextController = AnimatedTextController();
    initVideo();
    _model.textController ??=
        TextEditingController(text: currentUserDisplayName);
    print('(SA41)');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initVideo();
      print('(SA42)');

      setState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double kStaggeredGridWidth = 1000;
    const double kStaggeredGridHeight = 1000;
    const kStaggeredGridRowCount = 10;
    const double kItemMargin = 20;
    const double kSection1Height = 1000;
    const double kPanelTop = 70;
    const double kPanelWidthProportion = 0.9;
    final double kPanelWidth =
        MediaQuery.sizeOf(context).width * kPanelWidthProportion;
    const double kPanelHeight = kSection1Height * 0.95;
    final double kPanelLeft =
        ((1.0 - kPanelWidthProportion) / 2) * MediaQuery.sizeOf(context).width;
    final double kBlurbLeft = kPanelLeft + kItemMargin;
    const double kBlurbTop = kPanelTop + kItemMargin;


    const double kLogoWidth = 130;
    const double kLogoHeight = 130;
    final double kLogoLeft =
        kPanelLeft + kPanelWidth - kItemMargin - kItemMargin - kLogoWidth;
    const double kLogoTop = kBlurbTop;
    const double kMapWidth = 200;
    const double kMapHeight = 300;
    final double kMapLeft = kBlurbLeft;
    const double kMapTop = 400;


    const double kBlurb1Width = 600;
    const double kBlurb2Width = 500;
    const double kBlurbHeight = kPanelHeight - kItemMargin;
    const double kBlurb0Width = 600;
    const double kBlurb0TextWidth = kBlurb0Width - (kStaggeredGridWidth / kStaggeredGridRowCount);
    const double kBlurb0Height = kBlurbHeight;
    final TextStyle kPanelTextStyle = TextStyle(
      color: Colors.amber,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(5.0, 5.0),
          blurRadius: 3.0,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        Shadow(
          offset: Offset(5.0, 5.0),
          blurRadius: 8.0,
          color: Color.fromARGB(125, 0, 0, 255),
        ),
      ],
      fontFamily: 'Rubik',
    );

    final TextStyle kPanelTextStyleSmaller = TextStyle(
      color: Colors.amber,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(5.0, 5.0),
          blurRadius: 3.0,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        Shadow(
          offset: Offset(5.0, 5.0),
          blurRadius: 8.0,
          color: Color.fromARGB(125, 0, 0, 255),
        ),
      ],
      fontFamily: 'Rubik',
    );

    final TextStyle kPanelTextStyleLarger = TextStyle(
      color: Colors.amber,
      fontWeight: FontWeight.bold,
      fontSize: 32,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(5.0, 5.0),
          blurRadius: 3.0,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        Shadow(
          offset: Offset(5.0, 5.0),
          blurRadius: 8.0,
          color: Color.fromARGB(125, 0, 0, 255),
        ),
      ],
      fontFamily: 'Rubik',
    );



    Widget salesButton(String text, Function onClicked){
      return         FFButtonWidget(
        tooltipMessage: text,
        onPressed: () async {
         onClicked;
          //context.pushNamed('changePassword');
        },
        text: 'Read/Write\nHyperbooks',
        options: FFButtonOptions(
          maxLines: 2,
          width: 170.0,
          height: (MediaQuery.sizeOf(context).width < kPhonewWidthThreashold)
              ? 20.0
              : 40.0,
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          iconPadding:
          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          color: FlutterFlowTheme.of(context).white,
          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
            fontFamily: 'Rubik',
            color: FlutterFlowTheme.of(context).primary,
          ),
          elevation: 0.0,
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
      );
    }


    Widget svgLogo() {
      return SvgPicture.asset(
        'assets/images/hyperbooklogosvg10.svg',
        width: kLogoWidth,
        height: kLogoHeight,
      );
    }

    Widget svgLogoButton() {
      return Column(children: [
        svgLogo(),
        salesButton('Read/Write Hyperbooks',
            (){
              Navigator.push(
                  context,
                  PageTransition(
                      type: kStandardPageTransitionType,
                      duration: kStandardTransitionTime,
                      reverseDuration: kStandardReverseTransitionTime,
                      child: LoginWidget()));
            }),
      ]);
    }

    Widget animatedHyperbookApp() {
      return AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            ScaleAnimatedText('Hyperbook App',
                textStyle: kPanelTextStyle, duration: Duration(seconds: 5)),
          ],
          controller: animatedTextController);
    }

    Widget blurb0() {
      return Row(
        children: [
          svgLogoButton(),
          Container(
            width: kBlurb0TextWidth,
            height: kBlurbHeight,
            child: Stack(children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: kBlurb1Width,
                  height: kBlurbHeight,
                  child: Wrap(children: [
                    RichText(
                        text: TextSpan(
                            text: '''
Are you one of a group of people with ideas that grow organically?
Why not try the ''',
                            style: kPanelTextStyle,
                            children: [
                              TextSpan(
                                text: '                     ',
                                style: kPanelTextStyleLarger,
                              ),
                              TextSpan(
                                  text:
                                      ' which will allow everyone to contribute, and which will automatically draw a map illustrating how the ideas fit together.'),
                            ])),
                  ]),
                ),
              ),
              Positioned(
                left: 160,
                top: 60,
                child: animatedHyperbookApp(),
              )
            ]),
          ),
        ],
      );
    }

    Widget blurb1() {
      return Container(
        width: kBlurb1Width,
        height: kBlurbHeight,
        child: Text(
          // 'A hyperbook is a document that is not constrained to a linear or hierarchical structure.  The creative process can be individual or collaborative, the Hyperbook App supplies all that is needed to ensure that the writing and reading of hyperbooks is productive and intuitive.',
          'A hyperbook is an online document composed of chapters.  In contrast to most electronic documents, it is not organised as either as a linear stream, nor as a hierarchy (with sections, subsections, etc.). Rather, the chapters of a hyperbook appear a as a network where each chapter is represented as a node (usually a small square) and the connections between chapters are shown as arrows.',
          style: kPanelTextStyle,
        ),
      );
    }

    Widget map() {
      return Image.network(
        // 'assets/images/Map4.png',
        //  'https://tin.syi.mybluehost.me/images/Map4.png',
        'https://fra.cloud.appwrite.io/v1/storage/buckets/69764619000a02b4adae/files/6976464200277abd2680/view?project=696ddda6001b28f2352e&mode=admin',
        width: kMapWidth,
        height: kMapHeight,
      );
    }

    Widget blurb2() {
      return Container(
        width: kBlurb2Width,
        height: kBlurbHeight,
        child: Text(
          '''
Some hyperbooks (including the Hyperbook tutorial) can be read by visiting the Hyperbook App website (https://hyperbook.co.uk)  or by downloading the Hyperbook App from the Google Play Store or the Apple App Store (soon).  However, to benefit from all that hyperbooks have to offer, please sign up for a free account.  This will enable you to:
* read any hyperbook that has been made public by its author (or moderator)
* Contribute to hyperbooks
* Start your own hyperbook and invite others to contribute''',
          style: kPanelTextStyleSmaller,
        ),
      );
    }

    Widget blurb3() {
      return Row(
        children: [
          svgLogoButton(),
          Container(
            width: kBlurb1Width,
            height: kBlurbHeight,
            child: Text(
              '''
Sign up for a Hyperbook App account and you will be able to read all publicly available hyperbooks, read and contribute to hyperbooks created by others, and create 2 hyperbooks of your own.
Each hyperbook you create can be read and extended by up to 5 others.  To remove these limits, a subscription is required to become a Pro member.  
''',
              style: kPanelTextStyleSmaller,
            ),
          ),
        ],
      );
    }

    StaggeredGridTile staggeredGridTile({
      required int crossCount,
      required int mainCount,
      required Widget contents,
      double? width,
      double? height,
    }) {
      return StaggeredGridTile.count(
        crossAxisCellCount: crossCount,
        mainAxisCellCount: mainCount,
        child: BackGroundTile(
          backgroundColor: Colors.orange,
          icondata: Icons.ac_unit,
          contents: contents,
        ),
      );
    }

    List<StaggeredGridTile> _cardTiles = [
      // staggeredGridTile(crossCount: 1, mainCount: 2, contents: svgLogoButton()),
      staggeredGridTile(crossCount: 10, mainCount: 2, contents: blurb0()),
      staggeredGridTile(crossCount: 9, mainCount: 2, contents: blurb1()),
      staggeredGridTile(crossCount: 3, mainCount: 3, contents: map()),
      staggeredGridTile(crossCount: 7, mainCount: 3, contents: blurb2()),
      staggeredGridTile(crossCount: 7, mainCount: 2, contents: blurb3()),
    staggeredGridTile(crossCount: 2, mainCount: 2, contents:
      salesButton('Upgrade\nto Pro',
              (){
            Navigator.push(
                context,
                PageTransition(
                    type: kStandardPageTransitionType,
                    duration: kStandardTransitionTime,
                    reverseDuration: kStandardReverseTransitionTime,
                    child: PayPalWidget()));
          })),
    ];

    Widget staggeredDisplay() {
      return Container(
        width: kStaggeredGridWidth,
        height: kStaggeredGridHeight,
        child: StaggeredGrid.count(
          crossAxisCount: kStaggeredGridRowCount,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: _cardTiles,
        ),
      );
    }

    Widget stackedDisplay() {
      return Container(
        width: kBlurb0Width,
        height: kBlurb0Height,
        child: Stack(children: [
          Positioned(
              left: 0,
              top: 0,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    width: 2000, //MediaQuery.sizeOf(context).width * 0.99,
                    height: 1000, //MediaQuery.sizeOf(context).height * 0.99,
                    child: videoIsInitialized
                        ? AspectRatio(
                            aspectRatio: videoPlayercontroller!.value.aspectRatio,
                            child: VideoPlayer(videoPlayercontroller!),
                          )
                        : Container(),
                  ),
                ),
              )),
          Positioned(
            left: kPanelLeft,
            top: kPanelTop,
            child: Container(
              width: kPanelWidth,
              height: kPanelHeight,
              color: Colors.white.withAlpha(128),
            ),
          ),
          Positioned(left: kPanelLeft, top: kPanelTop, child: staggeredDisplay())
          /*Positioned(
            left: kLogoLeft,
            top: kLogoTop,
            child: svgLogo(),

          ),
          Positioned(
            left: kBlurbLeft,
            top: kBlurbTop,
            child: blurb(),
          ),
          Positioned(
            left: kMapLeft,
            top: kMapTop,
            child: Image.network(
              // 'assets/images/Map4.png',
              //  'https://tin.syi.mybluehost.me/images/Map4.png',
              'https://fra.cloud.appwrite.io/v1/storage/buckets/69764619000a02b4adae/files/6976464200277abd2680/view?project=696ddda6001b28f2352e&mode=admin',
              width: kMapWidth,
              height: kMapHeight,
            ),
          ),*/
        ]),
      );
    }

    context.watch<FFAppState>();
    print(
        '(SA3)${videoPlayercontroller!.value.isInitialized}++++${videoIsInitialized}');

    /*if (!videoPlayercontroller!.value.isInitialized){
      print('(SA8)${videoPlayercontroller!.value.isInitialized}++++${videoIsInitialized}');
      startupVideo();
    }*/
    print('(SA44)');

    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              videoPlayercontroller!.value.isPlaying
                  ? videoPlayercontroller!.pause()
                  : videoPlayercontroller!.play();
            });
          },
          child: Icon(
            videoPlayercontroller!.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
          ),
        ),
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Hyperbook App',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Rubik',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                //# await loadCachedChaptersReadReferencesCachedHyperbookIndex(
                //#     hyperbook: tutorialHyperbook, user: currentUser);
                // localDB.setTutorialAsWorkingHyperbook();
                toast(context, 'Please wait while Hyperbook Tutorial loads',
                    ToastKind.success);

                // localDB.setTutorialAsWorkingHyperbook();
                Navigator.push(
                    context,
                    PageTransition(
                      type: kStandardPageTransitionType,
                      duration: kStandardTransitionTime,
                      reverseDuration: kStandardReverseTransitionTime,
                      child: LoginWidget(),
                    ));
              },
              child: SvgPicture.asset(
                'assets/images/hyperbooklogosvg10.svg',
                width: 40,
                height: 40,
              ),
            ),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: kSection1Height,
                child: stackedDisplay(),
                // staggeredDisplay(),
              ),
              Container(height: 500, color: Colors.amber),
            ],
          ),
        ));
  }
}

class BackGroundTile extends StatelessWidget {
  final Color backgroundColor;
  final IconData icondata;
  final Widget? contents;

  BackGroundTile(
      {required this.backgroundColor, required this.icondata, this.contents});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent, //backgroundColor,
      child: (contents == null)
          ? Icon(icondata, color: Colors.white)
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: contents,
            ),
    );
  }
}
