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
import 'hyperbook_display_model.dart';
import 'package:hyperbook/app_state.dart';
import '/app_state.dart';
// import 'package:flutter_intro/flutter_intro.dart';
import '/custom_code/widgets/permissions.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hyperbook/hyperbook_edit/hyperbook_edit_widget.dart';
export 'hyperbook_display_model.dart';
import 'dart:math';
import 'package:hyperbook/appwrite_interface.dart';
// import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as models;
import '/../custom_code/widgets/appwrite_realtime_subscribe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../menu.dart';
import '../../localDB.dart';
import 'package:hyperbook/login/login_widget.dart';
// import 'package:hyperbook/map_display/map_display_widget.dart';
import 'package:hyperbook/hyperbook_edit/hyperbook_edit_widget.dart';
import 'package:hyperbook/chapter_display/chapter_display_widget.dart';
import 'package:hyperbook/paypal/paypal_widget.dart';

int _count = 0;
bool _iHaveRequests = false;
List<DocumentReference?> _hyperbookListRequesting = [];

class HyperbookDisplayWidget extends StatefulWidget {
  const HyperbookDisplayWidget({super.key});

  @override
  _HyperbookDisplayWidgetState createState() => _HyperbookDisplayWidgetState();
}

class _HyperbookDisplayWidgetState extends State<HyperbookDisplayWidget> {
  late HyperbookDisplayModel _model;

  TextEditingController? enteredHyperbookTitleController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // Intro? intro;
  _HyperbookDisplayWidgetState() {
    //%//>print('(XI3)');
/*    intro = Intro(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      stepCount: 11,
      maskClosable: true,
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
        texts: [
          'Click to restore hyperbook from backup store',
          'Click to create new hyperbook',
          'Hyperbook title',
          'Hyperbook blurb (short description)',
          'Hyperbook moderator (creator and manager)',
          'Click to edit hyperbook details',
          'Click to see hyperbook map',
          'Click for list of chapters',
          'Click to delete hyperbook',
          'Click to respond to access requests for this hyperbook',
          'Click to request access to hyperbook'
        ],
        buttonTextBuilder: (currPage, totalPage) {
          //--//////%//>print('(XI1)${currPage}%${totalPage}');
          return currPage < totalPage - 1 ? 'Next' : 'Finish';
        },
      ),
    );
    intro!.setStepConfig(
      0,
      borderRadius: BorderRadius.circular(64),
    );*/
  }

  int? externalSetState() {
    //>print('(R10X)${context}');
    setState(() {});
    return null;
  }

  @override
  void initState() {
    print('(XXDI-1)${hyperbookDisplayIsSubscribed}');
    super.initState();
    _model = createModel(context, () => HyperbookDisplayModel());
    enteredHyperbookTitleController = TextEditingController();
    enteredHyperbookTitleController.text = '';
    // hyperbookDisplayscrollController = ScrollController();
    // WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    if (!hyperbookDisplayIsSubscribed) {
      //>print('(XXDI-2)${hyperbookDisplayIsSubscribed}');
      hyperbookDisplaySubscribe(externalSetState);
      hyperbookDisplayIsSubscribed = true;
    }

    //>print('(XXDI-3)${hyperbookDisplayIsSubscribed}');
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

  /*Future<void> getPushPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }
*/
  /* bool hyperbookTitleExists(String title) {
    bool foundExisitingHyperbookTitle = false;
    //>print('(NN3)${cachedHyperbookList.length}++++${cachedHyperbookList}');
    for (CachedHyperbook c in cachedHyperbookList) {
      if (c.hyperbook!.title == title) {
        foundExisitingHyperbookTitle = true;
        break;
      }
    }
    if (foundExisitingHyperbookTitle) {
      toast(context, 'Hyperbook exists, please choose alternative title',
          ToastKind.warning);
    }
    return foundExisitingHyperbookTitle;
  }*/
  bool hyperbookTitleExists(String title) {
    HyperbookLocalDB? h =
        localDB.selectHyperbookDB(hsp: kAttHyperbookTitle, param: title);
    bool found = (h != null);
    if (found) {
      toast(context, 'Hyperbook exists, please choose alternative title',
          ToastKind.warning);
    }
    return found;
  }

  BackupFileDetail? chosenFileDetail;

  Future<void> restoreHyperbookBackup({
    models.File? chosenHyperbookFile,
  }) async {
    Map<String, dynamic>? hyperbookMap;
    HyperbooksRecord? hyperbook;
    List<Map<String, dynamic>> connectedUsersMapList = [];
    List<Map<String, dynamic>> chaptersMapList = [];
    try {
      String? s = await getStorageFileDownload(
        file: chosenHyperbookFile,
      );
      //>print('(NW5)${chosenHyperbookFile!.name}++++${s}');
      var d = jsonDecode(s!);
      //>print('(XY11)${d}');
      Map<String, dynamic> backupMap = d as Map<String, dynamic>;
      //>print('(NW12)${backupMap}');
      Map<String, dynamic> cachedHyperbookMap =
          backupMap[kAttrBackupHyperbookLocalDB] as Map<String, dynamic>;
      //>print('(NW13)${cachedHyperbookMap}');
      hyperbookMap =
          cachedHyperbookMap[kAttrBackupHyperbook] as Map<String, dynamic>;
      //>print('(NW14)${hyperbookMap}');
      hyperbook = HyperbooksRecord.fromJson(hyperbookMap);

      //>print('(NW15A)${hyperbook.title}++++${hyperbook.startChapter!.path}');
      // if (hyperbookTitleExists(hyperbook.title!)) {
      //   return;
      // }

      /*await createHyperbook(
          moderator: hyperbook!.moderator,
          title: hyperbook.title,
          blurb: hyperbook.blurb,
          startChapter: hyperbook.startChapter,
          nonMemberRole: hyperbook.nonMemberRole,
          moderatorDisplayName: hyperbook.moderatorDisplayName,
          id: hyperbook.reference!.path!,
          createdTime: hyperbook.createdTime,
          modifiedTime: hyperbook.modifiedTime);
      */

      localDB.updateHyperbook(
          hp: kAttHyperbookStartChapter, value: hyperbook.startChapter!);
      /*#await updateDocument(
          collection: hyperbooksRef,
          document: hyperbook.reference,
          data: {'startChapter': hyperbook.startChapter!.path});
      */
      //>print('(NW15B)${hyperbook.title}');
      List<dynamic> connectedUsersListJSON =
          cachedHyperbookMap[kAttrBackupConnectedUserList] as List<dynamic>;
      //>print('(NW16A)${connectedUsersListJSON}');
      for (int i = 0; i < connectedUsersListJSON.length; i++) {
        ConnectedUsersRecord connectedUser = ConnectedUsersRecord.fromJson(
            connectedUsersListJSON[i] as Map<String, dynamic>);
        //>print('(NW16B)${i}++++${connectedUser}');
        if (connectedUser.nodeSize == null) {
          connectedUser.nodeSize = kDefaultNodeSize;
        }
        /*     await createConnectedUserX(
            user: connectedUser.user,
            status: connectedUser.status,
            displayName: connectedUser.displayName,
            requesting: connectedUser.requesting,
            parent: connectedUser.parent,
            id: connectedUser.reference!.path!,
            nodeSize: connectedUser.nodeSize);*/
        int connectedUserIndex =
            await localDB.createLocalDBConnectedUserReturnIndex(
                user: connectedUser.user,
                role: connectedUser.status,
                displayName: connectedUser.displayName,
                requesting: connectedUser.requesting,
                hyperbook: connectedUser.parent,
                reference: connectedUser.reference,
                nodeSize: connectedUser.nodeSize);
        //>print('(CU110)${i}....${connectedUserIndex};;;;${connectedUser.displayName}');
      }
      List<dynamic> chaptersListJSON =
          cachedHyperbookMap["chapterList"] as List<dynamic>;
      //>print('(NW17)${chaptersListJSON}');
      for (int i = 0; i < chaptersListJSON.length; i++) {
        ChaptersRecord chapter = ChaptersRecord.fromJson(
            chaptersListJSON[i] as Map<String, dynamic>);
        await createChapterX(
            title: chapter.title,
            body: chapter.body,
            author: chapter.author,
            xCoord: chapter.xCoord,
            yCoord: chapter.yCoord,
            createdTime: chapter.createdTime,
            modifiedTime: chapter.modifiedTime,
            parent: chapter.parent,
            authorDisplayName: chapter.authorDisplayName,
            id: chapter.reference!.path!);
      }
      toast(context, 'Hyperbook restored', ToastKind.success);
    } catch (e) {
      //>print('(NW2)${e}');
      toast(context, 'Error in restoring hyperbook', ToastKind.error);
    }
    //createDocument(collection: hyperbooksRef, data: hyperbookMap);
  }

  void gotoEditHyperbook(HyperbooksRecord listViewHyperbooksRecord) async {
    FFAppState().update(() {
      FFAppState().currentHyperbook = listViewHyperbooksRecord.reference;
    });
    //%print(
    //    '(N62)$listViewHyperbooksRecord');
    //#await loadCachedChaptersReadReferencesCachedHyperbookIndex(
    //#    hyperbook: listViewHyperbooksRecord!.reference, user: currentUser);
    await localDB.setWorkingHyperbookAndConnectedUser(
        hyperbook: listViewHyperbooksRecord.reference!,
        user: currentUser!.reference);
    Navigator.push(
        context,
        PageTransition(
            type: kStandardPageTransitionType,
            duration: kStandardTransitionTime,
            reverseDuration: kStandardReverseTransitionTime,
            child: HyperbookEditWidget()));

    /* context.pushNamed(
      'hyperbook_edit',
      queryParameters: <String, String?>{
        'hyperbook': serializeParam(
          listViewHyperbooksRecord.reference,
          ParamType.DocumentReference,
        ),
        'hyperbookTitle': serializeParam(
          listViewHyperbooksRecord.title,
          ParamType.String,
        ),
        'hyperbookBlurb': serializeParam(
          listViewHyperbooksRecord.blurb,
          ParamType.String,
        ),
        'nonMemberRole': serializeParam(
          listViewHyperbooksRecord.nonMemberRole,
          ParamType.String,
        ),
        'startChapter': serializeParam(
          listViewHyperbooksRecord.startChapter,
          ParamType.DocumentReference,
        ),
        'moderator': serializeParam(
          listViewHyperbooksRecord.moderator,
          ParamType.DocumentReference,
        ),
      }.withoutNulls,
    );*/
  }

  List<BackupFileDetail> backupFileDetailList = [];

  @override
  Widget build(BuildContext context) {
    print('(XXDB)${localDB.getWorkingHyperbook()}');
    // for(int i = 0; i < currentCachedConnectedUsers.length; i++){
    //   //>print('(MS6)${i}++++${currentCachedConnectedUsers[i].displayName}____${currentCachedConnectedUsers[i].reference!.path}');
    // }
    // String s = jsonEncode(cachedHyperbookList.first.toJson());
    // //>print('(XY2)${s}');
    context.watch<FFAppState>();
    // context.watch<FFAppState>();
    // getPushPermission();
/*    List<HyperbooksRecord> visiibleHyperbookList = [];
    for (HyperbooksRecord hyperbook in hyperbookList) {
      if (isHyperbookVisible(currentUserReference, hyperbook)) {
        visiibleHyperbookList.add(hyperbook);
      }
    }
*/
    String requestedRole = '';
    _hyperbookListRequesting.clear();
    _iHaveRequests = false;
    void showRoleRequestDialog(
        HyperbooksRecord listViewHyperbooksRecord, String currentRole) async {
      requestedRole = currentRole;
      localDB.setWorkingHyperbookAndConnectedUser(
          hyperbook: listViewHyperbooksRecord.reference,
          user: currentUser!.reference);
      // localDB.setWorkingConnectedUserFromHyperbook(hyperbook: listViewHyperbooksRecord.reference, user: currentUser!.reference);
      print('(N4100)${requestedRole}....${localDB.getWorkingConnectedUser()}');
      await showDialog<bool>(
          context: context,
          builder: (BuildContext alertDialogContext) {
            //>print('(N4101)${requestedRole}');
            return StatefulBuilder(
                builder: (context, StateSetter localSetState) {
              return AlertDialog(
                  title: const Text('Request role for this hyperbook'),
                  content: DropdownButton<String>(
                    key: ValueKey(widget),
                    value: requestedRole,
                    hint: const Text('Please select hyperbook role'),
                    items: kRoleListWithoutModerator
                        .map<DropdownMenuItem<String>>((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                        ),
                      );
                    }).toList(),
                    elevation: 2,
                    onChanged: (String? value) {
                      localSetState(() {
                        requestedRole = value!;
                      });
                    },
                    isExpanded: true,
                    focusColor: Colors.transparent,
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(alertDialogContext, false);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        // UsersRecord moderator = await UsersRecord.getDocumentOnce(
                        //     listViewHyperbooksRecord.moderator!);
                        //>print('(N3900A)${listViewHyperbooksRecord.moderator}');
                        UsersRecord moderator = await getUser(
                            document: listViewHyperbooksRecord.moderator!);
                        /*updateConnectedUsersWithRequestedRole(
                          context,
                          listViewHyperbooksRecord.reference,
                          chosenRole,
                          listViewHyperbooksRecord.title,
                          listViewHyperbooksRecord.moderator!,
                          moderator.displayName.toString());*/

                        /*#ConnectedUsersRecord currentConnectedUser =
                            await getRelevantConnectedUsersRecord(
                          hyperbook: listViewHyperbooksRecord,
                          user: currentUser!.reference,
                          displayName: currentUser!.displayName,
                        );*/

                        print(
                            '(N99)${localDB.workingHyperbookIndex}----${requestedRole}');
                        await localDB.updateConnectedUser(
                            cp: kAttConnectedUserRequesting,
                            value: requestedRole);
                        /*#await updateDocument(
                          collection: connectedUsersRef,
                          document: currentConnectedUser.reference,
                          data: {'requesting': requestedRole},
                        );*/
                        await sendEmail(
                            emailType: EmailType.roleRequest,
                            senderDisplayName: currentUser!.displayName!,
                            senderEmail: currentUser!.email!,
                            hyperbookName: listViewHyperbooksRecord.title!,
                            receiverEmail: moderator.email!,
                            receiverDisplayName: moderator.displayName!,
                            newRole: requestedRole);
                        setState(() {});
                        toast(context, 'Request send to hyperbook moderator',
                            ToastKind.success);
                        Navigator.pop(alertDialogContext, true);
                      },
                      child: const Text('Confirm'),
                    ),
                  ]);
            });
          });
    }

    int infoCount = 0;
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

    return Title(
        title: 'hyperbook_display',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: const Color(0xFFF5F5F5),
            appBar: AppBar(
              leading: BackButton(color: Colors.white),
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              title: Text(
                'Hyperbooks',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Rubik',
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
              ),
              actions: [
                insertOutstandingRequestsButton(context),
                insertMenu(context, hyperbookDisplayMenuDetails, setState),
                GestureDetector(
                  onTap: () async {
                    //# await loadCachedChaptersReadReferencesCachedHyperbookIndex(
                    //#     hyperbook: tutorialHyperbook, user: currentUser);
                    localDB.setTutorialAsWorkingHyperbook();
                    toast(context, 'Please wait while Hyperbook Tutorial loads',
                        ToastKind.success);

                    localDB.setTutorialAsWorkingHyperbook();
                    /* context.pushNamed(
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
                /*      InkWell(
                  onTap: () async {
                    intro!.start(context);
                    //%//>print('(XI5)');
                  },
                  child: kIconInfoStartWhite,
                ),*/
              ],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: SafeArea(
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
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
                            Container(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FFButtonWidget(
                                // key: intro!.keys[0],
                                tooltipMessage:
                                    'Click to restore a hyperbook from backup store',
                                onPressed: () async {
                                  models.FileList? fileList =
                                      await listStorageFiles(
                                          bucketId: backupStorageRef.path);
                                  List<HyperbooksRecord> hyperbookList =
                                      await listHyperbookList(
                                          justCurrentUserAsModerator: true);
                                  //>print('(RB1)${hyperbookList.length}');
                                  final bool confirmDialogResponse =
                                      await showDialog<bool>(
                                            context: context,
                                            builder: (BuildContext
                                                alertDialogContext) {
                                              List<models.File> listOfFiles =
                                                  fileList!.files;
                                              print(
                                                  '(RB2)${listOfFiles.length}');

                                              List<BackupFileDetail>
                                                  filletedListOfFiles = [];

                                              print(
                                                  '(RB3)${filletedListOfFiles.length}');

                                              for (int i = 0;
                                                  i < listOfFiles.length;
                                                  i++) {
                                                String filename =
                                                    listOfFiles[i].name;
                                                //>print('(RB4)${filename}');
                                                List<String> splitFilename =
                                                    filename.split('-');
                                                bool found = false;
                                                print(
                                                    '(RB5)${splitFilename.length}');

                                                for (int j = 0;
                                                    j < hyperbookList.length;
                                                    j++) {
                                                  print(
                                                      '(RB6)${j}****${hyperbookList[j].reference!.path}');
                                                  if (hyperbookList[j]
                                                          .reference!
                                                          .path ==
                                                      splitFilename.first) {
                                                    found = true;
                                                    List<String>
                                                        versionNumberSplit =
                                                        splitFilename.last
                                                            .split('.');
                                                    int versionNumber =
                                                        int.tryParse(
                                                                versionNumberSplit
                                                                    .first) ??
                                                            0;
                                                    print(
                                                        '(RB7)${splitFilename.first}****${hyperbookList[j].reference!.path}');
                                                    filletedListOfFiles.add(
                                                        BackupFileDetail(
                                                            hyperbookList[j]
                                                                .title,
                                                            versionNumber,
                                                            DocumentReference(
                                                                path:
                                                                    splitFilename
                                                                        .first),
                                                            listOfFiles[i]));
                                                    break;
                                                  }
                                                }
                                              }
                                              if (filletedListOfFiles
                                                  .isNotEmpty) {
                                                chosenFileDetail =
                                                    filletedListOfFiles.first;
                                              } else {
                                                return AlertDialog(
                                                    title: const Text(
                                                        'No backups available'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                    ]);
                                              }
                                              return StatefulBuilder(builder:
                                                  (context,
                                                      StateSetter
                                                          localSetState) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Restore hyperbook'),
                                                  content: (filletedListOfFiles
                                                              .length <
                                                          1)
                                                      ? Text(
                                                          'No hyperbook backups available')
                                                      : DropdownButton<
                                                          BackupFileDetail>(
                                                          key: ValueKey(widget),
                                                          value:
                                                              chosenFileDetail,
                                                          hint: const Text(
                                                              'Please select hyperbook backkup file'),
                                                          items: filletedListOfFiles.map<
                                                                  DropdownMenuItem<
                                                                      BackupFileDetail>>(
                                                              (BackupFileDetail
                                                                  item) {
                                                            return DropdownMenuItem<
                                                                BackupFileDetail>(
                                                              value: item,
                                                              child: Text(
                                                                  '${item.hyperbookName}, version: ${item.versionNumber.toString()}'),
                                                            );
                                                          }).toList(),
                                                          elevation: 2,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              chosenFileDetail =
                                                                  value;
                                                            });
                                                            localSetState(() {
                                                              chosenFileDetail =
                                                                  value;
                                                            });
                                                          },
                                                          isExpanded: true,
                                                          focusColor: Colors
                                                              .transparent,
                                                        ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        String hyperbookname =
                                                            chosenFileDetail!
                                                                .hyperbookName!;
                                                        print(
                                                            '(BU10)${hyperbookname}++++${chosenFileDetail!.hyperbookReference.path}////${chosenFileDetail!.file!.name}####${chosenFileDetail!.file!.bucketId}');

                                                        /*                List<String>
                                                            hyperbookFilenameSpit =
                                                            hyperbookFilename
                                                                .split('-');
                                                        DocumentReference
                                                            hyperbook =
                                                            DocumentReference(
                                                                path:
                                                                    hyperbookFilenameSpit
                                                                        .first);*/
                                                        // print(
                                                        //     '(RB20)${chosenFileDetail!.file}@@@@${chosenFileDetail!.versionNumber}____${chosenFileDetail!.hyperbookName}~~~~${chosenFileDetail!.hyperbookReference!.path}');
                                                        /*##            currentCachedHyperbookIndex =
                                                            getCurrentCachedHyperbookIndex(
                                                                hyperbook:
                                                                    chosenFileDetail!
                                                                        .hyperbookReference);*/
                                                        int hyperbookIndex = localDB
                                                            .getHyperbookIndex(
                                                                chosenFileDetail!
                                                                    .hyperbookReference)!;
                                                        if (localDB
                                                                .hyperbooklocalDBList[
                                                                    hyperbookIndex]
                                                                .hyperbook!
                                                                .startChapter!
                                                                .path ==
                                                            '') {
                                                          restoreHyperbookBackup(
                                                              chosenHyperbookFile:
                                                                  chosenFileDetail!
                                                                      .file);
                                                          //>print('(NW50)');
                                                        } else {
                                                          toast(
                                                              context,
                                                              'The current version of this hyperbook must be deleted before restoring backup',
                                                              ToastKind
                                                                  .warning);
                                                        }
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            true);
                                                      },
                                                      child:
                                                          const Text('Confirm'),
                                                    ),
                                                  ],
                                                );
                                              });
                                            },
                                          ) ??
                                          false;
                                },
                                text: 'Restore hyperbook',
                                options: FFButtonOptions(
                                  width: 200.0,
                                  height: 50.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Rubik',
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  elevation: 2.0,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FFButtonWidget(
                                // key: intro!.keys[1],
                                tooltipMessage:
                                    'Click to create a new hyperbook',
                                onPressed: () async {
                                  bool oKToProceed =
                                      await isOKToCreateHyperbook();
                                  if (oKToProceed) {
                                    List<HyperbooksRecord> listOfMyHyperbooks =
                                        await listHyperbookList(
                                            justCurrentUserAsModerator: true);
                                    List<String> proUserList =
                                        await getPayPalListOfActiveSubs();

                                    final bool confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (BuildContext
                                                  alertDialogContext) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Create new hyperbook'),
                                                  content: TextFormField(
                                                    // key: intro!.keys[0],
                                                    onChanged: (text) {
                                                      //>print('(N2020)${text}');
                                                    },
                                                    controller:
                                                        enteredHyperbookTitleController,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Hyperbook title',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Rubik',
                                                                color: const Color(
                                                                    0xFF95A1AC),
                                                              ),
                                                      hintText: 'Title',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Rubik',
                                                                color: const Color(
                                                                    0xFF95A1AC),
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color:
                                                              Color(0xFFDBE2E7),
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .white,
                                                      contentPadding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(16.0,
                                                              24.0, 0.0, 24.0),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Rubik',
                                                          color: const Color(
                                                              0xFF2B343A),
                                                        ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              true),
                                                      child:
                                                          const Text('Confirm'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ) ??
                                            false;
                                    if (confirmDialogResponse) {
                                      /*final DocumentReference
                                        hyperbooksRecordReference =
                                        HyperbooksRecord.collection.doc();*/
                                      //>print('CH10');
                                      String newTitle =
                                          enteredHyperbookTitleController.text;
                                      if (hyperbookTitleExists(newTitle)) {
                                        return;
                                      }
                                      if (newTitle == '') {
                                        newTitle = getRandomString(20);
                                      }

                                      HyperbookLocalDB createdLocalDBHyperbook =
                                          await localDB
                                              .createLocalDBHyperbook(newTitle);

                                      /*£    createReadReference(
                                      hyperbooksRecordReference,
                                      //   _model.createdIntroductionChapter!);

                                      _model
                                          .createdIntroductionChapter!.reference,
                                      _model.createdIntroductionChapter!.author,
                                      _model.createdIntroductionChapter!.xCoord,
                                      _model.createdIntroductionChapter!.yCoord,
                                    );*/
                                      // invalidateHyperbookCache();

                                      setState(() {});
                                      if ((createdLocalDBHyperbook
                                                  .hyperbook!.nonMemberRole ==
                                              null) ||
                                          (createdLocalDBHyperbook
                                                  .hyperbook!.nonMemberRole ==
                                              '')) {
                                        createdLocalDBHyperbook.hyperbook!
                                            .nonMemberRole = kRoleNone;
                                      }
                                      /*#  hyperbookCacheValid = false;
                                  await loadCachedHyperbookLists(
                                      currentUser!.reference!);*/
                                      await localDB
                                          .setWorkingHyperbookAndConnectedUser(
                                              // createdLocalDBHyperbook.hyperbook!.reference!);
                                              hyperbook: createdLocalDBHyperbook
                                                  .hyperbook!.reference!,
                                              user: currentUser!.reference);

                                      localDB.dumpLocalDB();
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: kStandardPageTransitionType,
                                              duration: kStandardTransitionTime,
                                              reverseDuration:
                                                  kStandardReverseTransitionTime,
                                              child: HyperbookEditWidget()));
                                    }
                                  } else {
                                    await showDialog<bool>(
                                        context: context,
                                        builder:
                                            (BuildContext alertDialogContext) {
                                          return AlertDialog(
                                            title:
                                                const Text('Upgrade to Pro?'),
                                            content: Text(
                                                'You have reached the limit of hyperbooks that you can create'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, false),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        type:
                                                            kStandardPageTransitionType,
                                                        duration:
                                                            kStandardTransitionTime,
                                                        reverseDuration:
                                                            kStandardReverseTransitionTime,
                                                        child: PayPalWidget(),
                                                      ));
                                                // context.pop();
                                                },
                                                child: const Text('Upgrade'),
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                },
                                text: 'Create hyperbook',
                                options: FFButtonOptions(
                                  width: 200.0,
                                  height: 50.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Rubik',
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  elevation: 2.0,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            (currentUser!.userLevel! >= kUserLevelSupervisor)
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
                                              builder: (BuildContext context) {
                                                // currentCachedHyperbookIndex = getCurrentHyperbookIndex(widget.hyperbook!);
                                                //>print('(UM6)${message}');
                                                return StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return AlertDialog(
                                                    title: Text('Message'),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [Text(message)],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, false),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
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

                                        /*            //>print('<TL1>${localDB.getWorkingHyperbook().title}');
                                        List<UsersRecord>  userList = await listUsersListWithEmail();
                                        //>print('<UM1>${userList.length}');
                                        for(int i = 0; i < userList.length; i++){
                                          String um = 'User Message ' + i.toString();
                                          await updateDocument(
                                            collection: usersRef,
                                            document: userList[i].reference,
                                            data: {kAttrUserUserMessage: um},
                                          );
                                        }
                                        //>print('<UM2>${userList.length}');
*/
                                        // _count++;
                                        // localDB.getWorkingHyperbook().title = localDB.getWorkingHyperbook().title! + _count.toString();

                                        /* models.DocumentList rrList =
                                            await listDocuments(
                                          collection: readReferencesRef,
                                        );
                                        cpList.clear();
                                        for (int i = 0;
                                            i < rrList.documents.length;
                                            i++) {
                                          findAndIncrementCP(
                                            rrList.documents[i].data['chapter']
                                                as String,
                                            rrList.documents[i].data['parent']
                                                as String,
                                          );
                                        }
                                        listCP();*/
                                      },
                                      options: FFButtonOptions(
                                        //width: 200.0,
                                        height: 30.0,
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10.0, 0.0, 10.0, 0.0),
                                        iconPadding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
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
                                  )
                                : Container(),
                            (currentUser!.userLevel! >= kUserLevelSupervisor)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FFButtonWidget(
                                      text: 'loadDB',
                                      onPressed: () async {
                                        await localDB.loadLocalDB(
                                            user: currentUser!.reference);
                                        await localDB.dumpLocalDB();
                                      },
                                      options: FFButtonOptions(
                                        //width: 200.0,
                                        height: 30.0,
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10.0, 0.0, 10.0, 0.0),
                                        iconPadding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
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
                            itemCount: localDB
                                .getHyperbookLocalDBlength(), //#cachedHyperbookList.length,
                            itemBuilder:
                                (BuildContext context, int listViewIndex) {
                              final HyperbooksRecord listViewHyperbooksRecord =
                                  localDB.hyperbookFromIndex(listViewIndex);
                              //#cachedHyperbookList[listViewIndex].hyperbook!;
                              bool ifUserCanSeeHyperbook = canUserSeeHyperbook(
                                  currentUser!.reference,
                                  listViewHyperbooksRecord);

                              String s =
                                  jsonEncode(listViewHyperbooksRecord.toJson());

                              print(
                                  '(N231)${ifUserCanSeeHyperbook}@@@@${localDB.getWorkingHyperbook().title}%%%${localDB.hyperbooklocalDBList.length}£££${listViewIndex}');

                              bool iHaveConnectedUser = false;
                              String? currentRole =
                                  listViewHyperbooksRecord.nonMemberRole;
                              String? currentRequesting = '';
                              String moderatorRoleRequestingString = '';
                              if (listViewHyperbooksRecord.moderator ==
                                  currentUser!.reference) {
                                iHaveConnectedUser = true;
                                moderatorRoleRequestingString =
                                    'Moderator: ${listViewHyperbooksRecord.moderatorDisplayName}';
                              } else {
                                for (ConnectedUsersRecord c
                                    in localDB.getConnectedUserList(
                                        listViewHyperbooksRecord
                                            .reference!) /*#cachedHyperbookList[listViewIndex]
                                        .connectedUserList*/
                                    ) {
                                  print(
                                      '(HD1)${c.user!.path}....${currentUser!.reference!.path},,,,${c.displayName}');
                                  if (c.user!.path ==
                                      currentUser!.reference!.path) {
                                    iHaveConnectedUser = true;
                                    currentRole = c.status;
                                    currentRequesting = c.requesting;
                                    moderatorRoleRequestingString =
                                        'Moderator: ${listViewHyperbooksRecord.moderatorDisplayName}, my role: ${currentRole}';
                                    if (currentRequesting != '') {
                                      moderatorRoleRequestingString =
                                          moderatorRoleRequestingString +
                                              ',requesting: ${currentRequesting}';
                                    }
                                    break;
                                  }
                                }
                              }
                              bool iAmModerator =
                                  (listViewHyperbooksRecord.moderator!.path ==
                                      currentUser!.reference!.path);
                              List<ConnectedUsersRecord> connectedUserList = [];
                              print(
                                  '(N3100)${iAmModerator}%%%%${listViewHyperbooksRecord.reference}');
                              if (iAmModerator) {
                                for (HyperbookLocalDB /*#CachedHyperbook*/ v
                                    in localDB
                                        .hyperbooklocalDBList /*#cachedHyperbookList*/) {
                                  if (v.hyperbook!.reference ==
                                      listViewHyperbooksRecord.reference) {
                                    //>print('(N3110)${v.hyperbook!.title}');
                                    connectedUserList = v.connectedUserList!;
                                    //>  print(
                                    //> '(N3120)${v.connectedUserList!.length}////${v.connectedUserList}');
                                    for (ConnectedUsersRecord c
                                        in v.connectedUserList!) {
                                      print(
                                          '(N3130)${c.status}%%%${c.requesting}¤¤¤¤${c}');
                                      if (c.requesting != '') {
                                        _iHaveRequests = true;
                                        _hyperbookListRequesting
                                            .add(v.hyperbook!.reference);
                                        break;
                                      }
                                    }
                                  }
                                }
                              }

                              infoCount++;
                              if (true /*iHaveConnectedUser*/) {
                                return ifUserCanSeeHyperbook
                                    ? Material(
                                        color: Colors.transparent,
                                        elevation: 5.0,
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(5),
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 165.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: FlutterFlowTheme.of(context)
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  // key: infoCount == 1
                                                  // ? intro!.keys[2]
                                                  // : UniqueKey(),
                                                  child: Text(
                                                    'Title: ${listViewHyperbooksRecord.title!}',
                                                    softWrap: false,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium,
                                                  ),
                                                ),
                                                SingleChildScrollView(
                                                  // key: infoCount == 1
                                                  //     ? intro!.keys[3]
                                                  //     : UniqueKey(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Text(
                                                    softWrap: false,
                                                    'Blurb: ${listViewHyperbooksRecord.blurb}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium,
                                                  ),
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    // key: infoCount == 1
                                                    //     ? intro!.keys[4]
                                                    //     : UniqueKey(),
                                                    children: <Widget>[
                                                      Text(
                                                        moderatorRoleRequestingString,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),

                                                      /*custom_widgets
                                                      .DisplayHyperbookModerator(
                                                    moderator:
                                                        listViewHyperbooksRecord
                                                            .moderator,
                                                  ),*/
                                                    ],
                                                  ),
                                                ),
                                                Row(children: [
                                                  FlutterFlowIconButton(
                                                    caption: 'Map',
                                                    enabled: (canUserReadHyperbook(
                                                        currentUser!.reference,
                                                        listViewHyperbooksRecord)),
                                                    // key: infoCount == 1
                                                    //     ? intro!.keys[6]
                                                    //     : UniqueKey(),
                                                    tooltipMessage:
                                                        'Go to hyperbook map',
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderRadius: 0.0,
                                                    borderWidth: 1.0,
                                                    buttonSize: 40.0,
                                                    icon: kIconHyperbookMap,
                                                    onPressed: () async {
                                                      FFAppState().update(() {
                                                        FFAppState()
                                                                .currentHyperbook =
                                                            listViewHyperbooksRecord
                                                                .reference;
                                                      });
                                                      /*£await createMissingReadReferences(
                                                                listViewHyperbooksRecord,
                                                                false,
                                                                false);*/
                                                      for (int i = 0;
                                                          i <
                                                              /*cachedHyperbookList[
                                                                      listViewIndex]*/
                                                              localDB
                                                                  .hyperbooklocalDBList[
                                                                      listViewIndex]
                                                                  .connectedUserList
                                                                  .length;
                                                          i++) {}
                                                      /*#  await loadCachedChaptersReadReferencesCachedHyperbookIndex(
                                                          hyperbook:
                                                              listViewHyperbooksRecord
                                                                  .reference,
                                                          user: currentUser);

                                                      int? index =
                                                          await getCurrentConnectedUserIndexOrCreate(
                                                              listViewHyperbooksRecord
                                                                  .reference!);
                                                      for (int i = 0;
                                                          i <
                                                              cachedHyperbookList[
                                                                      listViewIndex]
                                                                  .connectedUserList
                                                                  .length;
                                                          i++) {
                                                        print(
                                                            '(MS8)${i}++++${cachedHyperbookList[listViewIndex].connectedUserList[i].displayName}____${cachedHyperbookList[listViewIndex].connectedUserList[i].reference!.path}');
                                                      }*/
                                                      await localDB
                                                          .setWorkingHyperbookAndConnectedUser(
                                                              //listViewHyperbooksRecord.reference!);
                                                              hyperbook:
                                                                  listViewHyperbooksRecord
                                                                      .reference!,
                                                              user: currentUser!
                                                                  .reference);

                                                      localDB.setWorkingConnectedUserFromHyperbook(
                                                          hyperbook:
                                                              listViewHyperbooksRecord
                                                                  .reference,
                                                          user: currentUser!
                                                              .reference);
                                                      print(
                                                          '<LD60A>${listViewHyperbooksRecord.reference!.path}****${localDB.workingHyperbookIndex}');
                                                      print(
                                                          '<LD60B>${localDB.getWorkingConnectedUser()}');
                                                      /* context.pushNamed(
                                                        'map_display',
                                                        queryParameters:
                                                            <String, String?>{
                                                          'hyperbook':
                                                              serializeParam(
                                                            listViewHyperbooksRecord
                                                                .reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                          'hyperbookTitle':
                                                              serializeParam(
                                                            listViewHyperbooksRecord
                                                                .title,
                                                            ParamType.String,
                                                          ),
                                                          'startChapter':
                                                              serializeParam(
                                                            listViewHyperbooksRecord
                                                                .startChapter,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                          'hyperbookBlurb':
                                                              serializeParam(
                                                            listViewHyperbooksRecord
                                                                .blurb,
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                      );*/
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                            type:
                                                                kStandardPageTransitionType,
                                                            duration:
                                                                kStandardTransitionTime,
                                                            reverseDuration:
                                                                kStandardReverseTransitionTime,
                                                            child:
                                                                LoginWidget(),
                                                          ));
                                                    },
                                                  ),
                                                  FlutterFlowIconButton(
                                                    caption: 'List',
                                                    enabled: canUserReadHyperbook(
                                                        currentUser!.reference,
                                                        listViewHyperbooksRecord),
                                                    // key: infoCount == 1
                                                    //     ? intro!.keys[7]
                                                    //     : UniqueKey(),
                                                    tooltipMessage:
                                                        'Go to list of chapters of this hyperbook',
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderRadius: 0.0,
                                                    borderWidth: 1.0,
                                                    buttonSize: 40.0,
                                                    icon: kIconList,
                                                    onPressed: () async {
                                                      FFAppState().update(() {
                                                        FFAppState()
                                                                .currentHyperbook =
                                                            listViewHyperbooksRecord
                                                                .reference;
                                                      });
                                                      /*£      await createMissingReadReferences(
                                                                listViewHyperbooksRecord,
                                                                false,
                                                                false);*/
                                                      /*# await loadCachedChaptersReadReferencesCachedHyperbookIndex(
                                                          hyperbook:
                                                              listViewHyperbooksRecord!
                                                                  .reference,
                                                          user: currentUser);*/
                                                      /*#int? index =*/
                                                      /*# await getCurrentConnectedUserIndexOrCreate(
                                                              listViewHyperbooksRecord!
                                                                  .reference!);*/
                                                      await localDB
                                                          .setWorkingHyperbookAndConnectedUser(
                                                              //listViewHyperbooksRecord.reference!);
                                                              hyperbook:
                                                                  listViewHyperbooksRecord
                                                                      .reference!,
                                                              user: currentUser!
                                                                  .reference);

                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  kStandardPageTransitionType,
                                                              duration:
                                                                  kStandardTransitionTime,
                                                              reverseDuration:
                                                                  kStandardReverseTransitionTime,
                                                              child:
                                                                  ChapterDisplayWidget()));
                                                      /*context.pushNamed(
                                                        'chapter_display',
                                                        queryParameters:
                                                            <String, String?>{
                                                          'hyperbook':
                                                              serializeParam(
                                                            listViewHyperbooksRecord
                                                                .reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                          'hyperbookTitle':
                                                              serializeParam(
                                                            listViewHyperbooksRecord
                                                                .title,
                                                            ParamType.String,
                                                          ),
                                                          'authorDisplayName':
                                                              serializeParam(
                                                            listViewHyperbooksRecord
                                                                .moderatorDisplayName,
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                      );*/
                                                    },
                                                  ),
                                                  FlutterFlowIconButton(
                                                    caption: 'Settings',
                                                    enabled: (isUserTheModerator(
                                                        currentUser!.reference!,
                                                        listViewHyperbooksRecord)),
                                                    // key: infoCount == 1
                                                    //     ? intro!.keys[5]
                                                    //     : UniqueKey(),
                                                    tooltipMessage:
                                                        'Hyperbook settings',
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderRadius: 30.0,
                                                    borderWidth: 1.0,
                                                    buttonSize: 40.0,
                                                    icon: kIconSettings,
                                                    onPressed: () async {
                                                      gotoEditHyperbook(
                                                          listViewHyperbooksRecord);
                                                    },
                                                  ),
                                                ]),
                                                Row(
                                                  children: <Widget>[
                                                    /*isUserTheModerator(
                                                          currentUser!.reference!,
                                                          listViewHyperbooksRecord)
                                                      ? */

                                                    FlutterFlowIconButton(
                                                      caption: 'Delete',
                                                      enabled: iAmModerator,
                                                      // key: infoCount == 1
                                                      //     ? intro!.keys[8]
                                                      //     : UniqueKey(),
                                                      tooltipMessage:
                                                          'Delete this hyperbook',
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 0.0,
                                                      borderWidth: 1.0,
                                                      buttonSize: 40.0,
                                                      icon: kIconDelete,
                                                      onPressed: () async {
                                                        final bool
                                                            confirmDialogResponse =
                                                            await showDialog<
                                                                    bool>(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          alertDialogContext) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          'Delete Hyperbook?'),
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          onPressed: () => Navigator.pop(
                                                                              alertDialogContext,
                                                                              false),
                                                                          child:
                                                                              const Text('Cancel'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed: () =>
                                                                              gotoEditHyperbook(listViewHyperbooksRecord),
                                                                          child:
                                                                              const Text('Create backup'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            print('(DD1)');
                                                                            Navigator.pop(
                                                                              alertDialogContext,
                                                                              true);},
                                                                          child:
                                                                              const Text('Confirm'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ) ??
                                                                false;
                                                        if (confirmDialogResponse) {
                                                          /*#                       List<DocumentReference>
                                                              chapterList = [];
                                                          List<DocumentReference>
                                                              conectedUserList =
                                                              [];
                                                          (
                                                            chapterList,
                                                            conectedUserList
                                                          ) = getCachedChapterListConnectedUserListFromHyperbook(
                                                              hyperbook:
                                                                  listViewHyperbooksRecord
                                                                      .reference!);
                                                          print(
                                                              '(ND2)${listViewHyperbooksRecord.title}++++${chapterList.length}****${conectedUserList.length}');
                                                          for (DocumentReference c
                                                              in chapterList) {
                                                            await deleteDocument(
                                                                collection:
                                                                    chaptersRef,
                                                                document: c);
                                                          }
                                                          for (DocumentReference c
                                                              in conectedUserList) {
                                                            await deleteDocument(
                                                                collection:
                                                                    connectedUsersRef,
                                                                document: c);
                                                          }*/

                                                          // await deleteDocument(
                                                          //     collection:
                                                          //         hyperbooksRef,
                                                          //     document:
                                                          //         listViewHyperbooksRecord
                                                          //             .reference!);

                                                          /*#updateDocument(
                                                              collection:
                                                                  hyperbooksRef,
                                                              document:
                                                                  listViewHyperbooksRecord
                                                                      .reference!,
                                                              data: {
                                                                'startChapter':
                                                                    ''
                                                              });*/
                                                          localDB.setWorkingHyperbookAndConnectedUser(
                                                              hyperbook:
                                                                  listViewHyperbooksRecord
                                                                      .reference,
                                                              user: currentUser!
                                                                  .reference);
                                                          localDB
                                                              .updateHyperbook(
                                                            hyperbookIndex: localDB
                                                                .getHyperbookIndex(
                                                                    listViewHyperbooksRecord
                                                                        .reference!),
                                                            hp: kAttHyperbookStartChapter,
                                                            value: '',
                                                          );
                                                          for (int i = 0;
                                                              i <
                                                                  localDB
                                                                      .getConnectedUserList(
                                                                          listViewHyperbooksRecord
                                                                              .reference!)
                                                                      .length;
                                                              i++) {
                                                            deleteDocument(
                                                                collection:
                                                                    connectedUsersRef,
                                                                document: localDB
                                                                    .getConnectedUserList(
                                                                        listViewHyperbooksRecord
                                                                            .reference!)[
                                                                        i]
                                                                    .reference);
                                                          }
                                                          for (int i = 0;
                                                              i <
                                                                  localDB
                                                                      .getConnectedUserList(
                                                                          listViewHyperbooksRecord
                                                                              .reference!)
                                                                      .length;
                                                              i++) {
                                                            await deleteDocument(
                                                                collection:
                                                                    connectedUsersRef,
                                                                document: localDB
                                                                    .getConnectedUserList(
                                                                        listViewHyperbooksRecord
                                                                            .reference!)[
                                                                        i]
                                                                    .reference);
                                                          }
                                                          for (int i = 0;
                                                              i <
                                                                  localDB
                                                                      .getChapterList(
                                                                          listViewHyperbooksRecord
                                                                              .reference!)
                                                                      .length;
                                                              i++) {
                                                            await deleteDocument(
                                                                collection:
                                                                    chaptersRef,
                                                                document: localDB
                                                                    .getChapterList(
                                                                        listViewHyperbooksRecord
                                                                            .reference!)[
                                                                        i]
                                                                    .reference);
                                                          }

                                                          List<UsersRecord>
                                                              userList =
                                                              await listUsersListWithEmail(
                                                                  email: null);
                                                          for (int i = 0;
                                                              i <
                                                                  userList
                                                                      .length;
                                                              i++) {
                                                            List<ReadReferencesRecord>
                                                                readReferenceList =
                                                                await listReadReferencsList(
                                                                    parent: userList[
                                                                            i]
                                                                        .reference,
                                                                    hyperbook:
                                                                        listViewHyperbooksRecord
                                                                            .reference);
                                                            for (int j = 0;
                                                                j <
                                                                    readReferenceList
                                                                        .length;
                                                                j++) {
                                                              await deleteDocument(
                                                                  collection:
                                                                      readReferencesRef,
                                                                  document:
                                                                      readReferenceList[
                                                                              j]
                                                                          .reference);
                                                              setState(() {

                                                              });
                                                              print(
                                                                  '(DH1)${i}....${j}++++${readReferenceList[j].reference!.path}');
                                                            }
                                                          }
                                                          /* for (int i = 0;
                                                              i <
                                                                  localDB
                                                                      .getReadReferenceList(
                                                                          listViewHyperbooksRecord
                                                                              .reference!)
                                                                      .length;
                                                              i++) {
                                                            await deleteDocument(
                                                                collection:
                                                                    readReferencesRef,
                                                                document: localDB
                                                                    .getReadReferenceList(
                                                                        listViewHyperbooksRecord
                                                                            .reference!)[
                                                                        i]
                                                                    .reference);
                                                          }*/
                                                          // .reference!)])
                                                          toast(
                                                              context,
                                                              'Hyperbook deleted',
                                                              ToastKind
                                                                  .success);
                                                          //# invalidateHyperbookCache();
                                                        }
                                                      },
                                                    ),
                                                    FlutterFlowIconButton(
                                                      caption: 'Notice',
                                                      enabled: (_iHaveRequests &&
                                                          (_hyperbookListRequesting
                                                              .contains(
                                                                  listViewHyperbooksRecord
                                                                      .reference))),
                                                      colorIfEnabled:
                                                          Colors.yellow,
                                                      // key: infoCount == 1
                                                      //     ? intro!.keys[9]
                                                      //     : UniqueKey(),
                                                      tooltipMessage:
                                                          'Enabled if you need to respond to requests',
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 0.0,
                                                      borderWidth: 1.0,
                                                      buttonSize: 40.0,
                                                      icon:
                                                          kIconRequestsOutstanding,
                                                      onPressed: () async {
                                                        gotoEditHyperbook(
                                                            listViewHyperbooksRecord);
                                                        /*await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  HyperbookEditWidget(
                                                                hyperbook:
                                                                    listViewHyperbooksRecord
                                                                        .reference,
                                                                hyperbookTitle:
                                                                    listViewHyperbooksRecord
                                                                        .title,
                                                                hyperbookBlurb:
                                                                    listViewHyperbooksRecord
                                                                        .blurb,
                                                                */ /*                                        hyperbookTypeNumber:
                                                                        listViewHyperbooksRecord
                                                                            .type,*/ /*
                                                                startChapter:
                                                                    listViewHyperbooksRecord
                                                                        .startChapter,
                                                                moderator:
                                                                    listViewHyperbooksRecord
                                                                        .moderator,
                                                                nonMemberRole:
                                                                    listViewHyperbooksRecord
                                                                        .nonMemberRole,
                                                              ),
                                                            ));*/
                                                      },
                                                    ),
                                                    FlutterFlowIconButton(
                                                      caption: 'Request',
                                                      tooltipMessage:
                                                          'Click to request access to this hyperbook',
                                                      enabled:
                                                          (canUserRequestHyperbook(
                                                              currentUser!
                                                                  .reference,
                                                              listViewHyperbooksRecord)),
                                                      // key: infoCount == 1
                                                      //     ? intro!.keys[10]
                                                      //     : UniqueKey(),
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 0.0,
                                                      borderWidth: 1.0,
                                                      buttonSize: 40.0,
                                                      icon: kIconRequest,
                                                      onPressed: () async {
                                                        //  showReadWriteDialogs(listViewHyperbooksRecord);
                                                        print(
                                                            '(N41XX)${currentRole}');
                                                        showRoleRequestDialog(
                                                            listViewHyperbooksRecord,
                                                            currentRole!);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ),
                                      )
                                    : Container();
                                //  } else {
                                //    return Container();
                                //  }
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
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
