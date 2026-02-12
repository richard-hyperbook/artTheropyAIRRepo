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

    return false;
  }

  BackupFileDetail? chosenFileDetail;

  Future<void> restoreHyperbookBackup({
    models.File? chosenHyperbookFile,
  }) async {
 /*   Map<String, dynamic>? hyperbookMap;
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

      *//*await createHyperbook(
          moderator: hyperbook!.moderator,
          title: hyperbook.title,
          blurb: hyperbook.blurb,
          startChapter: hyperbook.startChapter,
          nonMemberRole: hyperbook.nonMemberRole,
          moderatorDisplayName: hyperbook.moderatorDisplayName,
          id: hyperbook.reference!.path!,
          createdTime: hyperbook.createdTime,
          modifiedTime: hyperbook.modifiedTime);
      *//*

      localDB.updateHyperbook(
          hp: kAttHyperbookStartChapter, value: hyperbook.startChapter!);
      *//*#await updateDocument(
          collection: hyperbooksRef,
          document: hyperbook.reference,
          data: {'startChapter': hyperbook.startChapter!.path});
      *//*
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
        *//*     await createConnectedUserX(
            user: connectedUser.user,
            status: connectedUser.status,
            displayName: connectedUser.displayName,
            requesting: connectedUser.requesting,
            parent: connectedUser.parent,
            id: connectedUser.reference!.path!,
            nodeSize: connectedUser.nodeSize);*//*
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
    }*/
    //createDocument(collection: hyperbooksRef, data: hyperbookMap);
  }


  List<BackupFileDetail> backupFileDetailList = [];

  @override
  Widget build(BuildContext context) {

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
    void showRoleRequestDialog(){
  /*      HyperbooksRecord listViewHyperbooksRecord, String currentRole) async {
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
                        *//*updateConnectedUsersWithRequestedRole(
                          context,
                          listViewHyperbooksRecord.reference,
                          chosenRole,
                          listViewHyperbooksRecord.title,
                          listViewHyperbooksRecord.moderator!,
                          moderator.displayName.toString());*//*

                        *//*#ConnectedUsersRecord currentConnectedUser =
                            await getRelevantConnectedUsersRecord(
                          hyperbook: listViewHyperbooksRecord,
                          user: currentUser!.reference,
                          displayName: currentUser!.displayName,
                        );*//*

                        print(
                            '(N99)${localDB.workingHyperbookIndex}----${requestedRole}');
                        await localDB.updateConnectedUser(
                            cp: kAttConnectedUserRequesting,
                            value: requestedRole);
                        *//*#await updateDocument(
                          collection: connectedUsersRef,
                          document: currentConnectedUser.reference,
                          data: {'requesting': requestedRole},
                        );*//*
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
          });*/
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
                // insertOutstandingRequestsButton(context),
                insertMenu(context, hyperbookDisplayMenuDetails, setState),
                GestureDetector(
                  onTap: () async {
                    //# await loadCachedChaptersReadReferencesCachedHyperbookIndex(
                    //#     hyperbook: tutorialHyperbook, user: currentUser);
                    // localDB.setTutorialAsWorkingHyperbook();
                    toast(context, 'Please wait while Hyperbook Tutorial loads',
                        ToastKind.success);

                    // localDB.setTutorialAsWorkingHyperbook();
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
                                text: 'Create hyperbook',
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
                            itemCount: 2, //#cachedHyperbookList.length,
                            itemBuilder:
                                (BuildContext context, int listViewIndex) {
                     /*         final HyperbooksRecord listViewHyperbooksRecord =
                                  localDB.hyperbookFromIndex(listViewIndex);*/
                              //#cachedHyperbookList[listViewIndex].hyperbook!;
                          /*    bool ifUserCanSeeHyperbook = canUserSeeHyperbook(
                                  currentUser!.reference,
                                  listViewHyperbooksRecord);*/

                             /* String s =
                                  jsonEncode(listViewHyperbooksRecord.toJson());
*/


                              // infoCount++;

                                return Container(child:Text('XXX2'));
                              }
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
