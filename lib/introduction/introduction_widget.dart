/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'introduction_model.dart';

export 'introduction_model.dart';

class IntroductionWidget extends StatefulWidget {
  const IntroductionWidget({super.key});

  @override
  _IntroductionWidgetState createState() => _IntroductionWidgetState();
}

class _IntroductionWidgetState extends State<IntroductionWidget> {
  late IntroductionModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    //%//>print('(M10)');
    super.initState();
    _model = createModel(context, () => IntroductionModel());

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
    //%//>print('(M11)');
    return Title(
        title: 'Hyperbook App',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            leading: BackButton(
                color: Colors.white
            ),
            backgroundColor: FlutterFlowTheme.of(context).primary,
            title: Text(
              'Hyperbook App',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Rubik',
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 2.0,
          ),
          body: SafeArea(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 0.9,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                     // height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Wrap(
                        children: <Widget>[
                          Text(
                            "Double-click the 'Introduction' circle or ",
                            style: FlutterFlowTheme.of(context).headlineSmall,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FFButtonWidget(
                              tooltipMessage: 'Click to create new account',
                              onPressed: () async {
                                context.push('/createAccount');
                              },
                              text: 'Create Account',
                              options: FFButtonOptions(
                                width: 130.0,
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Rubik',
                                      color: Colors.white,
                                    ),
                                elevation: 2.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          Text(
                            ' or ',
                            style: FlutterFlowTheme.of(context).headlineSmall,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FFButtonWidget(
                                tooltipMessage: 'Click to login',
                              onPressed: () async {
                                //>print('(N1)');
                                // context.goNamedAuth(
                                //     'hyperbook_display',context.mounted);
                                context.go('/login');
                                //context.pushNamed('/login');
                               // context.pushNamed(
                               // 'hyperbook_display');


                              },
                              text: 'Login',
                              options: FFButtonOptions(
                                width: 130.0,
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Rubik',
                                      color: Colors.white,
                                    ),
                                elevation: 2.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.8,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.9,
                        child: custom_widgets.SetIntroductionHyperbook(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 0.9,
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
*/
