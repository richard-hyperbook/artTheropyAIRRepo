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
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../platform/audio_recorder_platform.dart';

import 'package:http/http.dart' as http;
import 'package:appwrite/appwrite.dart' as appwrite;

import 'package:appwrite/models.dart' as models;
import 'package:appwrite/enums.dart' as enums;

http.Client _http = http.Client();

int _count = 0;
bool _iHaveRequests = false;
List<DocumentReference?> _hyperbookListRequesting = [];

class SessionStepDisplayWidget extends StatefulWidget {
  const SessionStepDisplayWidget({super.key});

  @override
  _SessionStepDisplayWidgetState createState() =>
      _SessionStepDisplayWidgetState();
}

class _SessionStepDisplayWidgetState extends State<SessionStepDisplayWidget>
    with AudioRecorderMixin {
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
      value2: index,
    );
    if (sessionStepList.documents.length > 0) {
      currentSessionStep =
          extractSessionStepRecord(sessionStepList.documents.first);
    } else {
      toast(context, 'Error in database', ToastKind.error);
    }
  }

  String generateAudioStorageFilename(
      SessionStepsRecord sessionStep, int version) {
    return 'audio${sessionStep.reference!.path}_${version}.wav';
  }

  String generatePhotoStorageFilename(
      SessionStepsRecord sessionStep, int version) {
    return 'photo${sessionStep.reference!.path}_${version}.jpg';
  }

  Future<int> checkIfCanPutInStorageLatestVersion({
    required String bucketId,
  }) async {
    bool askToOverwrite = false;
    bool doStore = true;
    bool doDelete = false;
    String storageFilename =
        generatePhotoStorageFilename(currentSessionStep!, 1);
    try {
      models.FileList fileList = await listStorageFiles(
        bucketId: bucketId,
      );
      print('(DE8)${fileList}');
      print('(DE9A)${fileList.files.length}');
      int maxVersion = 0;
      if (fileList.files.length > 0) {
        for (var file in fileList.files) {
          List<String> filenameSplit1 = file.$id.split('_');
          List<String> filenameSplit2 = filenameSplit1[1].split('.');
          int? version = int.tryParse(filenameSplit2[0]);
          if (version == null) {
            version = 0;
          }
          if (version > maxVersion) {
            maxVersion = version;
          }
          print(
              '(DE10A)${file.name}....${filenameSplit2[0]}----${version}----${maxVersion}');
        }
      }
      return maxVersion;
    } on AppwriteException catch (e) {
      print('(DE20)${e}....${e.code}');
      return 0;
    }
  }

  String imageNetworkPath = '';
  String transcription = '';
  int? maxVersion;

  Widget displayThumbnail() {
    print('(DE410)${imageNetworkPath}');
    return Image.network(
      imageNetworkPath,
      width: (MediaQuery.sizeOf(context).width * 0.9) -
          kIconButtonWidth -
          kIconButtonGap,
      height: (kIconButtonHeight * 2) + kIconButtonGap,
      fit: BoxFit.contain,
    );
  }

  Widget displaySessionStep(SessionStepsRecord sessionStep, int index, int maxVersion) {
    print('(ss111)${maxVersion}');
    loadImageNetworkPath(sessionStep, maxVersion);
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
                  'Step: ${(index + 1).toString()}',
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
                  'Question: ${sessionStep.question}',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
              ///////////////////////////////

              Container(
                height: 60,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // key: infoCount == 1
                    //     ? intro!.keys[4]
                    //     : UniqueKey(),
                    children: <Widget>[
                      Recorder(
                        sessionStepId: sessionStep.reference!.path,
                        onStart: () async {
                          currentSessionStep = sessionStep;
                          print('(DE3A)${currentSessionStep!.reference!.path}');
                          bool doRecord = true;
                          maxVersion =
                              await checkIfCanPutInStorageLatestVersion(
                                  bucketId: artTheopyAIRaudiosRef.path!);
                          print(
                              '(DE3B)${currentSessionStep!.reference!.path}....${maxVersion}');
                          return maxVersion!;
                        },
                        onStop: (path) async {
                          print('(DE1)$path....${maxVersion}');
                          await storeStorageFile(
                            bucketId: artTheopyAIRaudiosRef.path!,
                            storageFilename: generateAudioStorageFilename(
                                sessionStep, maxVersion! + 1),
                            localFilePath: path,
                          );
                          print('(DE6)${audioPath}');
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
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 60,
                      child: AudioPlayer(
                          sessionStepId: sessionStep.reference!.path,
                          onPlay: (String localPath) async {
                            maxVersion = await getMaxVersionNumber(
                              bucketId: artTheopyAIRaudiosRef.path!,
                              sessionStepId: sessionStep.reference!.path!,
                            );
                            if (maxVersion! < 1) {
                              toast(context, 'No recording stored',
                                  ToastKind.warning);
                            } else {
                              String correctedLocalPath = localPath.replaceAll('999999', maxVersion.toString());
                              print(
                                  '(DE33A)${sessionStep.reference!.path!}....${localPath},,,,${maxVersion}++++${correctedLocalPath}oooo${generateAudioStorageFilename(sessionStep, maxVersion!)}');
                              bool ok = await copyStorageFiletoLocal(
                                bucketId: artTheopyAIRaudiosRef.path,
                                fileId: generateAudioStorageFilename(
                                    sessionStep, maxVersion!),
                                localPath: correctedLocalPath,
                              );
                              print(
                                  '(DE33B)${generateAudioStorageFilename(sessionStep, maxVersion!)}');
                              if (maxVersion! < 1) {
                                toast(context, 'Error in replay',
                                    ToastKind.error);
                              }
                            }
                            print('(DE39)${maxVersion}');
                            return maxVersion!;
                          },
                          onDelete: () {
                            print('(DE7)');
                            setState(() => audioPath = '');
                          }),
                    )
                  ],
                ),
              ),

              Row(children:[
              Column(children:[
                FlutterFlowIconButton(
                  caption: 'Select photo',
                  tooltipMessage: 'Select photo from gallery',
                  borderColor: Colors.transparent,
                  borderRadius: 0.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  buttonWidth: kIconButtonWidth,
                  icon: Icon(Icons.camera),
                  onPressed: () async {
                    FFAppState().update(() {});
                    currentSessionStep = sessionStep;
                    insertPicture(context, sessionStep);
                  },
                ),

      SizedBox(height: kIconButtonGap),
                  FlutterFlowIconButton(
                    caption: 'Transcribe',
                    tooltipMessage: 'Speech to text',
                    borderColor: Colors.transparent,
                    borderRadius: 0.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    buttonWidth: kIconButtonWidth,
                    icon: Icon(Icons.speaker_notes),
                    onPressed: () async {
                      currentSessionStep = sessionStep;
//                      final uri = Uri.parse('698718ad000f1cc14442.fra.appwrite.run');
                      print('(PQ1)${sessionStep.reference!.path!}');
                      final uri = Uri.parse(
                          'https://698718ad000f1cc14442.fra.appwrite.run');
                      //final creds = base64.encode(utf8.encode('$clientId:$secret'));
                      final respAccessToken = await _http.post(
                        uri,
                        headers: {
                          // 'Authorization': 'Basic $creds',
                          'Content-Type': 'application/json',
                        },
                        body: 'audio' + sessionStep.reference!.path! + '.wav',
                      );
                      print('(PQ2)${respAccessToken.statusCode}');
                      print(respAccessToken.body);
                      var respDynamic = jsonDecode(respAccessToken.body);
                      Map<String, dynamic> respObject =
                          respDynamic as Map<String, dynamic>;
                      transcription = respObject['transcription']! as String;
                      print(
                          '(PQ4)${respDynamic}....${respObject},,,,${transcription}');
                      if (respAccessToken.statusCode < 200 ||
                          respAccessToken.statusCode >= 300) {
                        toast(
                            context, 'Error in transcription', ToastKind.error);
                      }
                      setState(() {});
                    },
                  ),
      ]),
                Expanded(child: displayThumbnail()),
      ]),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: Text(transcription),
              ),

              ////////////////////
            ]),
      ),
    );
  }

  BackupFileDetail? chosenFileDetail;

  Future<void> restoreHyperbookBackup({
    models.File? chosenHyperbookFile,
  }) async {}

  List<BackupFileDetail> backupFileDetailList = [];

  void loadImageNetworkPath(SessionStepsRecord sessionStep, int localMaxVersion) {
    final String BUCKET_ID = artTheopyAIRphotosRef.path!;
    final String FILE_ID = generatePhotoStorageFilename(sessionStep, localMaxVersion);
    final String PROJECT_ID = kProjectID;
    imageNetworkPath =
        'https://cloud.appwrite.io/v1/storage/buckets/${BUCKET_ID}/files/${FILE_ID}/view?project=${PROJECT_ID}';
  }

  void insertPicture(
      BuildContext context, SessionStepsRecord sessionStep) async {
    // //> print('(X400)${jobData[kJrAMS][0]}');
    // String? role = Provider.of<ScaffoldData>(context, listen: false).cUserRole;
    ImagePicker picker;
    const bool KIsWeb = identical(0, 0.0);

    if (!KIsWeb) {
      //((Platform.isAndroid) || (Platform.isIOS)) {
      // //> print('(XJJP0)');
      picker = ImagePicker();
      PickedFile pickedFile;

      XFile? imageFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      maxVersion = await checkIfCanPutInStorageLatestVersion(
          bucketId: artTheopyAIRphotosRef.path!);

        String localFilePath = imageFile!
            .path; //= await getPath(sessionStepId: sessionStep.reference!.path!, fileKind: FileKind.photo);
        print('(DE400)${maxVersion}====${localFilePath}....${sessionStep.reference!.path!}');
        await storeStorageFile(
            bucketId: artTheopyAIRphotosRef.path!,
            storageFilename: generatePhotoStorageFilename(sessionStep, maxVersion! + 1),
            localFilePath: localFilePath);
        setState(() {
          loadImageNetworkPath(sessionStep, maxVersion!);
        });

        print(
            '(DE401)${localFilePath}....${sessionStep.reference!.path!}----${imageNetworkPath}');

      // //> print('(XJJP9A)±${snapshot}');
      //File file = File(snapshot!.path);
      // //> print('(XJJPAA)${cloudStoragePathname}±${snapshot.path}±${file}');
      //   await storeFileInStorage(
      //       prefix: 'photo', bucketId: artTheopyAIRphotosRef.path, contents: contents);
      // //> print('(XJJPB)${snapshot2}');
      // //> print('(XJJPD)${e}');
    } else {
      // //> print('(XJJQ0)${cloudStoragePathname}');
      // Deploy.storeWebImage(context, jobId, cloudStoragePathname);
    }
  }

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
                                      /*SizedBox(width: 20),
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
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
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
                                      ),*/
                                      (currentUser!.role! == kRoleAdministrator)
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                              title: Text(
                                                                  'Message'),
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
                                                                    context
                                                                        .pop();
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      (currentUser!.role! ==
                                              kUserLevelSupervisor)
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                                      BorderRadius.circular(
                                                          8.0),
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
                                              listViewIndex, sessionSteps![listViewIndex].maxPhotoVersion!);
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
