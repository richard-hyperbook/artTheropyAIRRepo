import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'tutorial_model.dart';
import '../../session_display/session_display_widget.dart';
import 'package:hyperbook/appwrite_interface.dart';
export 'tutorial_model.dart';

class TutorialWidget extends StatefulWidget {
  const TutorialWidget({super.key});

  @override
  _TutorialWidgetState createState() => _TutorialWidgetState();
}

class _TutorialWidgetState extends State<TutorialWidget> {
  late TutorialModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TutorialModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Title(
        title: 'tutorial',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              leading: BackButton(
                  color: Colors.white
              ),
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              title: Text(
                'Welcome to Hyperbook',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Rubik',
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 500.0,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 50.0),
                            child: PageView(
                              controller: _model.pageViewController ??=
                                  PageController(),
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0.07, -1.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Message',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .cerise,
                                              action: SnackBarAction(
                                                label: 'OK',
                                                textColor: const Color(0x00000000),
                                                onPressed: () async {
                                                  context.pop();
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          'assets/images/hyperbook1.png',
                                          width: 50.0,
                                          height: 50.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-0.01, -0.9),
                                      child: Text(
                                        'How to read a hyperbook',
                                        style: FlutterFlowTheme.of(context)
                                            .displaySmall,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-0.4, 0.1),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.5,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.35,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '3.',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall,
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -0.9, -0.51),
                                              child: Text(
                                                'You will see a map of the chaptera\nof this hyperbook',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/folowMeMap1.png',
                                              width: 400.0,
                                              height: 300.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-0.64, -0.7),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.3,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.12,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '1.',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall,
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -3.97, -0.51),
                                              child: Text(
                                                "Go to the list of hyperbooks by clicking  on the  'Hyperbooks' icon at  the bottom of any screen.",
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.01),
                                              child: FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30.0,
                                                borderWidth: 1.0,
                                                buttonSize: 60.0,
                                                icon: kIconHyperbooks,
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context!,
                                                      PageTransition(
                                                        type: kStandardPageTransitionType,
                                                        duration:kStandardTransitionTime,
                                                        reverseDuration: kStandardReverseTransitionTime,
                                                        child: SessionDisplayWidget(
                                                        ),
                                                      ));
                                                  // context.pushNamed(
                                                  //     'hyperbook_display');
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0.55, -0.6),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.3,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.12,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '2.',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall,
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -3.97, -0.51),
                                              child: Text(
                                                "Choose your hyperbook by clicking on the 'Map'  icon next to its name.",
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.01),
                                              child: FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30.0,
                                                borderWidth: 1.0,
                                                buttonSize: 60.0,
                                                icon: kIconHyperbooks,
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context!,
                                                      PageTransition(
                                                        type: kStandardPageTransitionType,
                                                        duration:kStandardTransitionTime,
                                                        reverseDuration: kStandardReverseTransitionTime,
                                                        child: SessionDisplayWidget(
                                                        ),
                                                      ));
                                                  // context.pushNamed(
                                                  //     'hyperbook_display');
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Image.network(
                                  'https://picsum.photos/seed/608/600',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                                Image.network(
                                  'https://picsum.photos/seed/442/600',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: smooth_page_indicator.SmoothPageIndicator(
                                controller: _model.pageViewController ??=
                                    PageController(),
                                count: 3,
                                onDotClicked: (int i) async {
                                  await _model.pageViewController!
                                      .animateToPage(
                                    i,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                effect:
                                    const smooth_page_indicator.ExpandingDotsEffect(
                                  expansionFactor: 2.0,
                                  dotColor: Color(0xFF9E9E9E),
                                  activeDotColor: Color(0xFF3F51B5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
