import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '/../custom_code/widgets/email_sender.dart';
import '/../custom_code/widgets/toast.dart';
// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
//import '/backend/push_notifications/push_notifications_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'session_step_display_model.dart';
import '../../app_state.dart';
import '/app_state.dart';
// import 'package:flutter_intro/flutter_intro.dart';
import '/custom_code/widgets/permissions.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import '../../hyperbook_edit/hyperbook_edit_widget.dart';
export 'session_step_display_model.dart';
import 'dart:math';
import '../../appwrite_interface.dart';
// import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as models;
// import '/../custom_code/widgets/appwrite_realtime_subscribe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../menu.dart';
import '../../localDB.dart';
import '../../login/login_widget.dart';
// import '../../map_display/map_display_widget.dart';
import '../../hyperbook_edit/hyperbook_edit_widget.dart';
import '../../chapter_display/chapter_display_widget.dart';
import '../../paypal/paypal_widget.dart';
import '../../audio/audio_player.dart';
import '../../audio/audio_recorder.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

int _count = 0;
bool _iHaveRequests = false;
List<DocumentReference?> _hyperbookListRequesting = [];

class SessionStepDisplayWidget extends StatefulWidget {
  const SessionStepDisplayWidget({super.key});

  @override
  _SessionStepDisplayWidgetState createState() =>
      _SessionStepDisplayWidgetState();
}

class _SessionStepDisplayWidgetState extends State<SessionStepDisplayWidget> {
  late SessionStepDisplayModel _model;

  TextEditingController? enteredHyperbookTitleController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // Intro? intro;
  _SessionStepDisplayWidgetState() {}

  int? externalSetState() {
    //>print('(R10X)${context}');
    setState(() {});
    return null;
  }

  List<SessionStepsRecord>? sessionSteps;

  @override
  void initState() {
    print('${currentSession}');
    super.initState();
    _model = createModel(context, () => SessionStepDisplayModel());
    enteredHyperbookTitleController = TextEditingController();
    enteredHyperbookTitleController.text = '';
    // hyperbookDisplayscrollController = ScrollController();
    // WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    // hyperbookDisplayscrollController!.dispose();
    //>print('(XXDD)${hyperbookDisplayIsSubscribed}');
    if (hyperbookDisplayIsSubscribed) {
      // hyperbookDisplaySubscription!.close();
      hyperbookDisplayIsSubscribed = false;
    }
    super.dispose();
  }
  String audioPath = '';

  Future<void> setCurrentSessionStepAndIndex(int index) async {
    models.DocumentList sessionStepList = await listDocumentsWithTwoQueries(
      collection: sessionStepsRef,
      attribute1: kSessionStepSessionId,
      value1: currentSession!.reference!.path,
      attribute2: kSessionStepIndex,
      value2: index,);
    if (sessionStepList.documents.length > 0){
      currentSessionStep = extractSessionStepRecord(sessionStepList.documents.first);
    } else {
      toast(context, 'Error in database', ToastKind.error);
    }

  }


  Widget displaySessionStep(SessionStepsRecord sessionStep, int index) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 400.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: FlutterFlowTheme.of(context).secondaryBackground,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                // key: infoCount == 1
                // ? intro!.keys[2]
                // : UniqueKey(),
                child: Text(
                  'Step: ${index.toString()}',
                  softWrap: false,
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
              SingleChildScrollView(
                // key: infoCount == 1
                //     ? intro!.keys[3]
                //     : UniqueKey(),
                scrollDirection: Axis.horizontal,
                child: Text(
                  softWrap: false,
                  'PhotoId: ${sessionStep.photo!.path}',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
              Container(height: 60,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // key: infoCount == 1
                    //     ? intro!.keys[4]
                    //     : UniqueKey(),
                    children: <Widget>[
                      Recorder(
                        carryOn: () async {
                          print('(AU99)');
                          currentSessionStep = sessionStep;
                          try {
                            models.FileList fileList = await listStorageFiles(
                              bucketId: artTheopyAIRaudiosRef.path,
                            );
                            print('(AU100)');
                            print('(AU100A)${fileList.files.length}');
                            if (fileList.files.length > 0 ) {
                              print('(AU100B)${fileList.files.first.name}....${fileList.files.first.runtimeType.toString()}');
                            } else {
                              return true;
                            }
                          } on AppwriteException catch (e) {
                             print('(AU100C)${e}....${e.code}');
                             return true;
                          }
                          return false;
                        },
                        onStop: (String path, bool deleteFirst) async {
                          currentSessionStep = sessionStep;
                          if (deleteFirst){
                            await deleteStorageFile(
                              bucketId: artTheopyAIRaudiosRef.path,
                              fileId: 'audio' + currentSessionStep!.reference!.path!);
                            print('(AU60)${'audio' + currentSessionStep!.reference!.path!}');
                          }
                          print('(AU61)${path}');
                          await createStorageAudioFile(
                            therapistId: currentTherapist!.reference,
                            sessionStepId: currentSessionStep!.reference,
                            localFilePath: path,
                          );
                          setState(() => audioPath = path);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // key: infoCount == 1
                  //     ? intro!.keys[4]
                  //     : UniqueKey(),
                  children: <Widget>[
                    Container(width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 60,
                      child: AudioPlayer(
                        source: audioPath,
                        onStart: () async {
                          currentSessionStep = sessionStep;
                          print('(AP4)${artTheopyAIRaudiosRef.path}');
                          copyStorageFiletoLocal(
                              bucketId: artTheopyAIRaudiosRef.path,
                              fileId: 'audio' + currentSessionStep!.reference!.path!,
                              localPath: currentLocalAudioPath,
                          );
                        },
                        onDelete: () {
                          print('(AP5)');
                          setState(() => audioPath = '');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(children: [
                FlutterFlowIconButton(
                  caption: 'Edit',
                  tooltipMessage: 'Go to hyperbook map',
                  borderColor: Colors.transparent,
                  borderRadius: 0.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  icon: kIconHyperbookMap,
                  onPressed: () async {
                    FFAppState().update(() {});

                    Navigator.push(
                        context,
                        PageTransition(
                          type: kStandardPageTransitionType,
                          duration: kStandardTransitionTime,
                          reverseDuration: kStandardReverseTransitionTime,
                          child: LoginWidget(),
                        ));
                  },
                ),
                FlutterFlowIconButton(
                  caption: 'List',
                  tooltipMessage: 'Go to list of chapters of this hyperbook',
                  borderColor: Colors.transparent,
                  borderRadius: 0.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  icon: kIconList,
                  onPressed: () async {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: kStandardPageTransitionType,
                            duration: kStandardTransitionTime,
                            reverseDuration: kStandardReverseTransitionTime,
                            child: LoginWidget()));
                  },
                ),
                FlutterFlowIconButton(
                  caption: 'Settings',
                  tooltipMessage: 'Hyperbook settings',
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  icon: kIconSettings,
                  onPressed: () async {},
                ),
              ]),
              Row(
                children: <Widget>[
                  FlutterFlowIconButton(
                    caption: 'Delete',
                    tooltipMessage: 'Delete this hyperbook',
                    borderColor: Colors.transparent,
                    borderRadius: 0.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    icon: kIconDelete,
                    onPressed: () async {},
                  ),
                  FlutterFlowIconButton(
                    caption: 'Notice',
                    colorIfEnabled: Colors.yellow,
                    // key: infoCount == 1
                    //     ? intro!.keys[9]
                    //     : UniqueKey(),
                    tooltipMessage:
                        'Enabled if you need to respond to requests',
                    borderColor: Colors.transparent,
                    borderRadius: 0.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    icon: kIconRequestsOutstanding,
                    onPressed: () async {},
                  ),
                  FlutterFlowIconButton(
                    caption: 'Request',
                    tooltipMessage: 'Click to request access to this hyperbook',
                    borderColor: Colors.transparent,
                    borderRadius: 0.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    icon: kIconRequest,
                    onPressed: () async {},
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  BackupFileDetail? chosenFileDetail;

  Future<void> restoreHyperbookBackup({
    models.File? chosenHyperbookFile,
  }) async {}

  List<BackupFileDetail> backupFileDetailList = [];

  @override
  Widget build(BuildContext context) {
    print('(SS2)${currentSession}`}');
    print('(SS3)${currentSession!.clientDisplayName}');

    MenuDetails hyperbookDisplayMenuDetails = MenuDetails(
      menuLabelList: [
        'Login',
      ],
      menuIconList: [
        kIconLogin,
      ],
      menuTargets: [
        (context) {
          //# context.goNamedAuth('login', context.mounted);
          Navigator.push(
              context,
              PageTransition(
                type: kStandardPageTransitionType,
                duration: kStandardTransitionTime,
                reverseDuration: kStandardReverseTransitionTime,
                child: LoginWidget(),
              ));
        },
      ],
    );
    print('(SS4)${currentSession}');
    print('(SS5)${currentSession!.clientDisplayName}');

    return FutureBuilder<List<SessionStepsRecord>>(
        future: listSessionStepList(justCurrentSession: true),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print('(SS80)${snapshot}');
            sessionSteps = snapshot.data;
            print('(SS81)${sessionSteps}');
            print(
                '(SS82)${sessionSteps!.length}....${sessionSteps!.first.reference!.path}');

            return Title(
                title: 'steps_display',
                color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
                child: Scaffold(
                    key: scaffoldKey,
                    backgroundColor: const Color(0xFFF5F5F5),
                    appBar: AppBar(
                      leading: BackButton(color: Colors.white),
                      backgroundColor: FlutterFlowTheme.of(context).primary,
                      automaticallyImplyLeading: false,
                      title: Text(
                        'Steps',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Rubik',
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                      ),
                      actions: [
                        // insertOutstandingRequestsButton(context),
                        insertMenu(
                            context, hyperbookDisplayMenuDetails, setState),
                        GestureDetector(
                            onTap: () async {
                              //# await loadCachedChaptersReadReferencesCachedHyperbookIndex(
                              //#     hyperbook: tutorialHyperbook, user: currentUser);
                              // localDB.setTutorialAsWorkingHyperbook();
                              toast(
                                  context,
                                  'Please wait while Hyperbook Tutorial loads',
                                  ToastKind.success);

                              Navigator.push(
                                  context,
                                  PageTransition(
                                    type: kStandardPageTransitionType,
                                    duration: kStandardTransitionTime,
                                    reverseDuration:
                                        kStandardReverseTransitionTime,
                                    child: LoginWidget(),
                                  ));
                            },
                            child: Text(
                                'XXX16') /*SvgPicture.asset(
                            'assets/images/hyperbooklogosvg10.svg',
                            width: 40,
                            height: 40,
                          ),*/
                            ),
                      ],
                      centerTitle: false,
                      elevation: 2.0,
                    ),
                    body: SafeArea(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: SingleChildScrollView(
                          // controller: hyperbookDisplayscrollController,
                          physics: ScrollPhysics(),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Wrap(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      SizedBox(width: 20),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FFButtonWidget(
                                          // key: intro!.keys[1],
                                          tooltipMessage:
                                              'Click to create a new hyperbook',
                                          onPressed: () async {
                                            print(('AAT1'));
                                          },
                                          text: 'Create session',
                                          options: FFButtonOptions(
                                            //width: 200.0,
                                            height: 30.0,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10.0, 0.0, 10.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Rubik',
                                                      color: Colors.white,
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                            elevation: 2.0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      (currentUser!.role! == kRoleAdministrator)
                                          ? Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: FFButtonWidget(
                                                text: 'check',
                                                onPressed: () async {
                                                  String? message =
                                                      currentUser!.userMessage;
                                                  //>print('(UM4)${message}');
                                                  if ((message != null) &&
                                                      (message != '')) {
                                                    //>print('(UM5)${message}');
                                                    showDialog<bool>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          // currentCachedHyperbookIndex = getCurrentHyperbookIndex(widget.hyperbook!);
                                                          //>print('(UM6)${message}');
                                                          return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return AlertDialog(
                                                              title:
                                                                  Text('Message'),
                                                              content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(message)
                                                                ],
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          false),
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    toast(
                                                                        context,
                                                                        '',
                                                                        ToastKind
                                                                            .success);
                                                                    context.pop();
                                                                  },
                                                                  child: const Text(
                                                                      'Confirm'),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                        });
                                                  }
                                                },
                                                options: FFButtonOptions(
                                                  //width: 200.0,
                                                  height: 30.0,
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10.0, 0.0, 10.0, 0.0),
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  color:
                                                      FlutterFlowTheme.of(context)
                                                          .primary,
                                                  textStyle:
                                                      FlutterFlowTheme.of(context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily: 'Rubik',
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                  elevation: 2.0,
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      (currentUser!.role! == kUserLevelSupervisor)
                                          ? Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: FFButtonWidget(
                                                text: 'loadDB',
                                                onPressed: () async {},
                                                options: FFButtonOptions(
                                                  //width: 200.0,
                                                  height: 30.0,
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10.0, 0.0, 10.0, 0.0),
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  color:
                                                      FlutterFlowTheme.of(context)
                                                          .primary,
                                                  textStyle:
                                                      FlutterFlowTheme.of(context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily: 'Rubik',
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                  elevation: 2.0,
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: sessionSteps!.length,
                                        //#cachedHyperbookList.length,
                                        itemBuilder: (BuildContext context,
                                            int listViewIndex) {
                                          return displaySessionStep(
                                              sessionSteps![listViewIndex],
                                              listViewIndex);
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )));
          }
        });
  }
}

class BackupFileDetail {
  String? hyperbookName;
  int? versionNumber;
  DocumentReference hyperbookReference;
  models.File? file;
  BackupFileDetail(this.hyperbookName, this.versionNumber,
      this.hyperbookReference, this.file);
}

List<CP> cpList = [];

class CP {
  String chapterPath = '';
  String parentPath = '';
  int count = 0;
  CP(this.chapterPath, this.parentPath, this.count);
}

void findAndIncrementCP(String hyperbook, String parent) {
  for (int i = 0; i < cpList.length; i++) {
    if ((hyperbook == cpList[i].chapterPath) &&
        (parent == cpList[i].parentPath)) {
      cpList[i].count++;
      return;
    }
  }
  cpList.add(CP(hyperbook, parent, 1));
}

void listCP() {
  //>print('(CP1)${cpList.length}');
  for (int i = 0; i < cpList.length; i++) {
    if (cpList[i].count > 1) {
      print(
          '(CP2)${cpList[i].count}>>>>${cpList[i].chapterPath}<<<<<${cpList[i].parentPath}');
    }
  }
}
