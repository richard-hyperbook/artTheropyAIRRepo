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
import 'session_display_model.dart';
import '../../app_state.dart';
import '/app_state.dart';
// import 'package:flutter_intro/flutter_intro.dart';
import '/custom_code/widgets/permissions.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import '../../hyperbook_edit/hyperbook_edit_widget.dart';
export 'session_display_model.dart';
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
import '../../session_step_display/session_step_display_widget.dart';
import '../../templates_page/templates_page_widget.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/log.dart';
import 'package:ffmpeg_kit_flutter_new/session.dart';
import 'package:ffmpeg_kit_flutter_new/statistics.dart';
import '../../platform/audio_recorder_platform.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'dart:convert';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:image/image.dart' as image2;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io' as Io;
import 'package:image/image.dart' as superImage;
import '../../clients_page/clients_page_widget.dart';

int _count = 0;
bool _iHaveRequests = false;
List<DocumentReference?> _hyperbookListRequesting = [];

class SessionDisplayWidget extends StatefulWidget {
  const SessionDisplayWidget({super.key});

  @override
  _SessionDisplayWidgetState createState() => _SessionDisplayWidgetState();
}

class _SessionDisplayWidgetState extends State<SessionDisplayWidget>
    with AudioRecorderMixin {
  late SessionDisplayModel _model;

  TextEditingController? enteredHyperbookTitleController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // Intro? intro;
  _SessionDisplayWidgetState() {}

  int? externalSetState() {
    //>print('(R10X)${context}');
    setState(() {});
    return null;
  }

  List<SessionsRecord>? sessions;

  VideoPlayerController videoController = VideoPlayerController.file(File(''));

  @override
  void initState() {
    print('(XXDI-1)${hyperbookDisplayIsSubscribed}....${currentUser}');
    super.initState();
    _model = createModel(context, () => SessionDisplayModel());
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

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<SessionStepsRecord>? sessionStepsList;
  String? tempDirPath;
  Utf8Encoder? utf8Encoder;
  Directory? dir;

  Future<void> generateStepVideo(int step) async {
    SessionStepsRecord sessionStep = sessionStepsList![step];
    currentSessionStep = sessionStepsList![step];
    print(
        '(QQ31)${currentSessionStep!.reference!.path}....${(currentSessionStep!.audio!.path ?? '').length}');
    if (true /*(currentSessionStep!.audio!.path ?? '').length > 0*/) {
      await setMaxVersionNumbersCurrentSessionStep();
      final int maxAudioVersion = currentSessionStep!.maxAudioVersion!;
      final maxPhotoVersion = currentSessionStep!.maxPhotoVersion!;
      final String audioPath =
          '${tempDirPath}/audio_${(step + 1).toString()}.wav';
      final String photoPath =
          '${tempDirPath}/photo_${(step + 1).toString()}.jpg';
      final String videoPath =
          '${tempDirPath}/video_${(step + 1).toString()}.mp4';
      print('(VC1D)');
      bool okAudio = await copyStorageFiletoLocal(
        bucketId: artTheopyAIRaudiosRef.path,
        fileId: generateAudioStorageFilename(sessionStep, maxAudioVersion),
        localPath: audioPath,
        fileKind: FileKind.audio,
      );
      print(
          '(VC2)${step}~~~~${okAudio}....${maxAudioVersion},,,,${audioPath}====${generateAudioStorageFilename(sessionStep, maxAudioVersion)}');
      print(
          '(VC3A)${step}~~~~${generatePhotoStorageFilename(sessionStep, maxPhotoVersion)}....${maxPhotoVersion},,,,${photoPath}====');
      bool okPhoto = await copyStorageFiletoLocal(
        bucketId: artTheopyAIRphotosRef.path,
        fileId: generatePhotoStorageFilename(sessionStep, maxPhotoVersion),
        localPath: photoPath,
        fileKind: FileKind.photo,
      );
      // Image photoImage = Image.file(File(photoPath));
      superImage.Image? image =
          superImage.decodeImage(File(photoPath).readAsBytesSync());
      superImage.Image? resizedImage =
          superImage.copyResize(image!, width: 500, height: 500);
      File(photoPath).writeAsBytesSync(superImage.encodeJpg(resizedImage));
      print('(VC3P)${resizedImage.frameType}');

      Image modifiedImage = Image(
        image: ResizeImage(
          FileImage(File(photoPath)),
          width: 500,
          height: 500,
        ),
      );

      print(
          '(VC4A)${step}~~~~${okPhoto}....${maxPhotoVersion},,,,${photoPath}<');
      dir = Directory.fromRawPath(utf8Encoder!.convert(tempDirPath!));
      await for (var entity in dir!.list(recursive: true, followLinks: false)) {
        print('(VC4B)${entity.path}....${entity.statSync().size}');
      }
      final String command =
          '-loop 1 -i ${photoPath} -i ${audioPath} -shortest ${videoPath}';
      print('(VC4C)${command}');
      String logString = 'Logs will appear here...';

      Session ffmpegSession = await FFmpegKit.execute(command);
      print('(VC9A)${logString}');

      final output = await ffmpegSession.getOutput();
      final returnCode = await ffmpegSession.getReturnCode();
      final duration = await ffmpegSession.getDuration();
      print(
          '(VC9B)${returnCode!.toString()}....${returnCode.getValue()},,,,${output!.length}----${output.characters.length}>>>>${duration}');
      //  setState(() {
      logString += '\n✅ Processing completed!\n';
      logString += 'Return code: $returnCode\n';
      logString += 'Duration: ${duration}ms\n';
      logString += 'Output: $output\n';
      //  isProcessing = false;
      //});

      debugPrint('session: $output');
      print('(VC9C)${logString}');

      //  print('(VC5A)${ffMpegResponse.getReturnCode()}....${ffMpegResponse.getState()},,,,${videoPath}');
      int maxVideoVersion = await getMaxVersionNumber(
          bucketId: artTheopyAIRvideosRef.path!,
          fileId: currentSession!.reference!.path!);
      String videoStorageId =
          generateVideoStorageFilename(currentSession!, maxVideoVersion + 1);
      print('(VC9D)${maxVideoVersion}....${videoStorageId},,,,${videoPath}');
      // await storeStorageFile(
      //   bucketId: artTheopyAIRvideosRef.path,
      //   storageFileId: videoStorageId,
      //   localFilePath: videoPath,
      // );

      /*(Log log) {
          // setState(() {
          logString += log.getMessage();
          // });
          debugPrint('log: ${log.getMessage()}');
        },
        (Statistics statistics) {
          // setState(() {
          logString +=
              '\n📊 Progress: ${statistics.getSize()} bytes, ${statistics.getTime()}ms\n';
          // });
          debugPrint('statistics: ${statistics.getSize()}');
        },*/
    }
  }

  Widget displaySession(SessionsRecord session, int index) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 600.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 15.0,
              color: Color(0x1F000000),
              offset: Offset(0.0, 4.0),
            )
          ],
          border: Border.all(
            color: FlutterFlowTheme.of(context).lineColor,
            width: 1.0,
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
                  'Client: ${session.clientDisplayName}',
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
                  'Date: ${(DateFormat.yMMMd().format(session.$createdAt!))}',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // key: infoCount == 1
                  //     ? intro!.keys[4]
                  //     : UniqueKey(),
                  children: <Widget>[
                    Text(
                      '',
                      style: FlutterFlowTheme.of(context).bodyMedium,
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
                  buttonWidth: 150,
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    FFAppState().update(() {});
                    currentSession = session;
                    currentTherapist =
                        await getUser(document: session.therapistId);
                    currentClient = await getUser(document: session.clientId);

                    print('(S1)${session.clientId}');
                    Navigator.push(
                        context,
                        PageTransition(
                          type: kStandardPageTransitionType,
                          duration: kStandardTransitionTime,
                          reverseDuration: kStandardReverseTransitionTime,
                          child: SessionStepDisplayWidget(),
                        ));
                  },
                ),
              ]),
              SizedBox(height: kIconButtonGap),
              FlutterFlowIconButton(
                // showLoadingIndicator: true,
                caption: 'Make video',
                tooltipMessage: 'Speech to text',
                borderColor: Colors.transparent,
                borderRadius: 0.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                buttonWidth: kIconButtonWidth,
                icon: Icon(Icons.video_camera_back_outlined),
                onPressed: () async {
                  currentSession = sessions![index];
                  showAlertDialog(context);
                  sessionStepsList =
                      await listSessionStepList(justCurrentSession: true);
                  tempDirPath = await getTempDirPath();
                  print('(VC1A)${tempDirPath}');
                  utf8Encoder = utf8.encoder;
                  dir =
                      Directory.fromRawPath(utf8Encoder!.convert(tempDirPath!));

                  currentSession = session;

                  await for (var entity
                      in dir!.list(recursive: true, followLinks: false)) {
                    print('(VC1B)${entity.path}');
                    if (entity.path.contains('audio')) {
                      File file = File(entity.path);
                      print('(VC1CA)${entity.path}');
                      await file.delete();
                    }
                    if (entity.path.contains('photo')) {
                      File file = File(entity.path);
                      print('(VC1CB)${entity.path}');
                      await file.delete();
                    }
                    if (entity.path.contains('video')) {
                      File file = File(entity.path);
                      print('(VC1CC)${entity.path}');
                      await file.delete();
                    }
                  }
                  for (int i = 0; i < sessionStepsList!.length; i++) {
                    print('(QQ30)${sessionStepsList!.length}....${i}');
                    await generateStepVideo(i);
                  }
                  final String videoPath = tempDirPath!;
                  Directory videoDir = Directory(videoPath);
                  String concatList = '';
                  videoDir.listSync().forEach((e) {
                    final size = e.statSync().size;
                    print('(MV1)${size}....${e.path}');
                    if((e.path).contains('video')) {
                      concatList = concatList + "file '${e.path}'\n";
                    }
                  });
                  print('(MV2)${videoDir.path}....${concatList}');
                  final File concatFile = await File("${videoDir.path}/concat.txt").writeAsString(concatList);

                  final String concatedVideo = "${videoDir.path}/video.mp4";
                  final String concatCommand =
                  "-f concat -safe 0 -i ${videoDir.path}/concat.txt -c copy ${concatedVideo}";
                  print('(MV4)${concatedVideo}....${concatCommand}');
                  Session ffmpegSession2 = await FFmpegKit.execute(concatCommand);
                  print('(MV5)${concatCommand}');

                  final output = await ffmpegSession2.getOutput();
                  final returnCode = await ffmpegSession2.getReturnCode();
                  final duration = await ffmpegSession2.getDuration();
                  print(
                      '(MV6)${returnCode!.toString()}....${returnCode},,,,${output!.length}----${output.characters.length}>>>>${duration}');
                   videoDir.listSync().forEach((e) {
                     final size = e.statSync().size;
                     print('(MV7)${size}....${e.path}');
                   });
                  var response = await storeStorageFile(
                    bucketId: artTheopyAIRvideosRef.path!,
                    storageFileId: generateVideoStorageFilename(
                      session, 0,
                    ),
                    localFilePath: concatedVideo,
                  );
                  print('(MV8)${response}');

                  Navigator.pop(context);
                  // String  command =
                  // " -y -framerate 1 -pattern_type sequence -i $pictureFilenames -c:v libx264 -r 30 -pix_fmt yuv420p ${generatedFile.path}";
                },
              ),
              SizedBox(height: kIconButtonGap),
              FlutterFlowIconButton(
                  caption: 'Play video',
                  tooltipMessage: 'Play video',
                  borderColor: Colors.transparent,
                  borderRadius: 0.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  buttonWidth: kIconButtonWidth,
                  icon: Icon(Icons.video_camera_back_outlined),
                  onPressed: () async {
                    int maxVideoVersion = await getMaxVersionNumber(
                        bucketId: artTheopyAIRvideosRef.path!,
                        fileId: currentSession!.reference!.path!);
                    String videoStorageId = generateVideoStorageFilename(
                        currentSession!, maxVideoVersion);
                    String tempDirPath = await getTempDirPath();
                    String videoPlayPath = '${tempDirPath}/video_play.mp4';
                    print(
                        '(VC12)${maxVideoVersion}....${videoStorageId},,,,${videoPlayPath}');
                    bool okVideo = await copyStorageFiletoLocal(
                      bucketId: artTheopyAIRvideosRef.path,
                      fileId: videoStorageId,
                      localPath: videoPlayPath,
                      fileKind: FileKind.video,
                    );
                    print('(VC13)${maxVideoVersion}....${videoPlayPath}');
                    videoController =
                        VideoPlayerController.file(File(videoPlayPath))
                          ..initialize().then((_) {
                            //    Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                          });
                    // setState(() {
                    // });
                  }),
              // SizedBox(
              //   width: 300,
              //   height: 200,
              //   child:  Container(
              //     decoration: BoxDecoration(border: BoxBorder.all(width: 1, color: Colors.black)),
              //     child: FittedBox(
              //     fit: BoxFit.fill,
              //     child: SizedBox(
              //       width: 290/*videoController.value.size.width ?? 0*/,
              //       height: 190/*videoController.value.size.height ?? 0*/,
              //       child: VideoPlayer(videoController),
              //     ),
              //   ),
              //
              //     /*AspectRatio(
              //       aspectRatio: videoController.value.aspectRatio,
              //       child: VideoPlayer(videoController),
              //     ),*/
              //   )
              // )
              SizedBox(height: 100),
              Container(
                //color: Colors.amber,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 130,
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    child: SizedBox(
                      height: videoController.value.size.height,
                      width: videoController.value.size.width,
                      child: VideoPlayer(
                        videoController,
                      ),
                    ),
                  ),
                ),
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
  TemplatesRecord? chosenTemplate;
  UsersRecord? chosenClient;

  void createSessionPopUp() async {
    TextEditingController clientController = TextEditingController();
    List<TemplatesRecord> templatesList =
        await listOwnedPlusMasterTemplateList();
    if ((templatesList.length ?? 0) > 0) {
      chosenTemplate = templatesList.first;
    }
    List<UsersRecord> clientsList =
        await listUsersClientsOfUser(therapist: currentUser!.reference);
    if ((clientsList.length ?? 0) > 0) {
      chosenClient = clientsList.first;
    }
    showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          // currentCachedHyperbookIndex = getCurrentHyperbookIndex(widget.hyperbook!);
          //>print('(UM6)${message}');
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Create Session'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Please select client'),
                  (clientsList.length == 0)
                      ? Text('No clients available')
                      : DropdownButton<UsersRecord>(
                          //   key: ValueKey(widget),
                          value: chosenClient,
                          hint: const Text('Please select client'),
                          items: clientsList!
                              .map<DropdownMenuItem<UsersRecord>>(
                                  (UsersRecord item) {
                            return DropdownMenuItem<UsersRecord>(
                              value: item,
                              child: Text(
                                item.displayName!,
                                // style: FlutterFlowTheme.bodyText1,
                              ),
                            );
                          }).toList(),
                          elevation: 2,
                          onChanged: (UsersRecord? value) {
                            setState(() {
                              chosenClient = value;
                              // FFAppState().chosenModerator = chosenModerator!.reference;
                            });
                            //%//>//>print('(D352)chosenTemplate');
                          },
                          isExpanded: true,
                          focusColor: Colors.transparent,
                        ),
                  SizedBox(height: kIconButtonGap),
                  Text('Please select template'),
                  (templatesList.length == 0)
                      ? Text('No templates available')
                      : DropdownButton<TemplatesRecord>(
                          //  key: ValueKey(widget),
                          value: chosenTemplate,
                          hint: const Text('Please select template'),
                          items: templatesList!
                              .map<DropdownMenuItem<TemplatesRecord>>(
                                  (TemplatesRecord item) {
                            return DropdownMenuItem<TemplatesRecord>(
                              value: item,
                              child: Text(
                                item.name!,
                                // style: FlutterFlowTheme.bodyText1,
                              ),
                            );
                          }).toList(),
                          elevation: 2,
                          onChanged: (TemplatesRecord? value) {
                            setState(() {
                              chosenTemplate = value;
                              // FFAppState().chosenModerator = chosenModerator!.reference;
                            });
                            print('(D352)chosenTemplate');
                          },
                          isExpanded: true,
                          focusColor: Colors.transparent,
                        ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    print('(QQ4)${chosenTemplate!.reference!.path}');
                    SessionsRecord session = await createSession(
                        clientId: chosenClient!.reference,
                        therapistId: currentUser!.reference,
                        templateId: chosenTemplate!.reference);
                    print('(CC12)${session.reference}');

                    toast(context, 'Created session', ToastKind.success);
                    context.pop();
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    print('(AAT20)${currentUser}');
    print('(AAT21)${currentUser!.email}');
    String requestedRole = '';
    _hyperbookListRequesting.clear();
    _iHaveRequests = false;
    void showRoleRequestDialog() {}

    int infoCount = 0;
    MenuDetails sessionDisplayMenuDetails = MenuDetails(
      menuLabelList: [
        'Templates',
        'Clients',
        'Login',
      ],
      menuIconList: [
        Icon(Icons.list_alt),
        kIconProfile,
        kIconLogin,
      ],
      menuTargets: [
        (context) {
          Navigator.push(
              context,
              PageTransition(
                type: kStandardPageTransitionType,
                duration: kStandardTransitionTime,
                reverseDuration: kStandardReverseTransitionTime,
                child: TemplatesPageWidget(),
              ));
        },
        (context) {
          Navigator.push(
              context,
              PageTransition(
                type: kStandardPageTransitionType,
                duration: kStandardTransitionTime,
                reverseDuration: kStandardReverseTransitionTime,
                child: ClientsPageWidget(),
              ));
        },
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

    return FutureBuilder<List<SessionsRecord>>(
        future: listSessionList(justCurrentUserAsTherapist: true),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print('(AAT80)${snapshot}');
            sessions = snapshot.data;
            print('(AAT81)${sessions}');
            print('(AAT82)${sessions!.length}');

            return Title(
                title: 'session_display',
                color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
                child: Scaffold(
                    key: scaffoldKey,
                    backgroundColor: const Color(0xFFF5F5F5),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          videoController.value.isPlaying
                              ? videoController.pause()
                              : videoController.play();
                        });
                      },
                      child: Icon(
                        videoController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                    appBar: AppBar(
                      leading: BackButton(color: Colors.white),
                      backgroundColor: FlutterFlowTheme.of(context).primary,
                      automaticallyImplyLeading: false,
                      title: Text(
                        'Sessions',
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

                        FlutterFlowIconButton(
                          enabled: true,
                          fillColor: Colors.white,
                          tooltipMessage: 'Create Session',
                          borderColor: FlutterFlowTheme.of(context).primary,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 40,
                          onPressed: () {
                            createSessionPopUp();
                          },
                          icon: kIconAdd,
                        ),
                        SizedBox(width: kIconButtonGap),
                        insertMenu(
                            context, sessionDisplayMenuDetails, setState),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Wrap(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    /* Container(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('XXX1'),
                                    ),
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
                                          iconPadding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme
                                              .of(context)
                                              .primary,
                                          textStyle: FlutterFlowTheme
                                              .of(context)
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
                                    ),*/
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
                                  child: (sessions!.length < 1)
                                      ? Text('No sessions available',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium)
                                      : ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: sessions!.length,
                                          //#cachedHyperbookList.length,
                                          itemBuilder: (BuildContext context,
                                              int listViewIndex) {
                                            return displaySession(
                                                sessions![listViewIndex],
                                                listViewIndex);
                                          }),
                                ),
                              ),
                            ],
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
