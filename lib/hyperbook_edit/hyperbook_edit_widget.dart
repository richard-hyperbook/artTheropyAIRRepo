import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../custom_code/widgets/permissions.dart';
// import '/auth/firebase_auth/auth_util.dart';
//import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'hyperbook_edit_model.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/app_state.dart';
// import 'package:flutter_intro/flutter_intro.dart';
import 'package:hyperbook/custom_code/widgets/toast.dart';
import 'package:hyperbook/appwrite_interface.dart';
import 'package:hyperbook/app_state.dart';
import 'package:hyperbook/appwrite_interface.dart';
// import '../custom_code/widgets/appwrite_realtime_subscribe.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:appwrite/models.dart' as models;
import 'package:hyperbook/custom_code/widgets/email_sender.dart';
import '../menu.dart';
import '../appwrite_interface.dart';
import '../localDB.dart';
import 'package:hyperbook/login/login_widget.dart';
import 'package:hyperbook/session_display/session_display_widget.dart';
// import 'package:hyperbook/map_display/map_display_widget.dart';
import 'package:hyperbook/paypal/paypal_widget.dart';
export 'hyperbook_edit_model.dart';

String _enteredEmail = '';
String _chosenRoleForNonMembers = kRoleNotLoggedIn;

class HyperbookEditWidget extends StatefulWidget {
  const HyperbookEditWidget({
    super.key,
    this.hyperbook,
    this.hyperbookTitle,
    this.hyperbookBlurb,
    this.startChapter,
    this.moderator,
    this.nonMemberRole,
  });

  final DocumentReference? hyperbook;
  final String? hyperbookTitle;
  final String? hyperbookBlurb;

  final DocumentReference? startChapter;
  final DocumentReference? moderator;
  final String? nonMemberRole;

  @override
  _HyperbookEditWidgetState createState() => _HyperbookEditWidgetState();
}

class _HyperbookEditWidgetState extends State<HyperbookEditWidget> {
  late HyperbookEditModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String emailAddress = '';
  TextEditingController roleController = TextEditingController();
  TextEditingController numberInputTextController = TextEditingController();
  String chosenRole = kRoleNotLoggedIn;

  // Intro? intro;
  _HyperbookEditWidgetState() {
    //%//>print('(XI3)');
    /*intro = Intro(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      stepCount: 8,
      maskClosable: true,
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
        texts: [
          'Enter hyperbook title',
          'Enter hyperbook blurb (short description)',
          'Choose hyperbook type',
          'Click to cancel changes',
          'Click to save changes',
          'Click to backup hyperbook',
          'Click to add user or change role for this hyperbook',
          'List of readers and writers, including approval requests',
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

  void externalSetState() {
    //>print('(RE10X)${context}');
    setState(() {});
  }

/*#  HyperbooksRecord getCurrentHyperbook() {
    int? currenthyperbookIndex =
        getCurrentCachedHyperbookIndex(hyperbook: widget.hyperbook!);
    CachedHyperbook currentCachedHyperbook =
        cachedHyperbookList[currenthyperbookIndex!];
    HyperbooksRecord currentHyperbook = currentCachedHyperbook.hyperbook!;
    return currentHyperbook;
  }*/

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HyperbookEditModel());

    // _model.titleController ??= TextEditingController(
    //     text: localDB.getWorkingHyperbook() /*getCurrentHyperbook()*/ .title);
    // _model.blurbController ??=
        // TextEditingController(text: localDB.getWorkingHyperbook().blurb);
    // _chosenRoleForNonMembers = localDB.getWorkingHyperbook().nonMemberRole!;
    // roleController.text = _chosenRoleForNonMembers;
    //>print('(XXEI)${hyperbookDisplayIsSubscribed}');
    if (!hyperbookEditIsSubscribed) {
      /*#    currentCachedHyperbookIndex = getCurrentCachedHyperbookIndex(
          hyperbook: getCurrentHyperbook().reference!);*/
      // hyperbookEditSubscribe(externalSetState);
      hyperbookEditIsSubscribed = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    //>print('(XXED)${hyperbookDisplayIsSubscribed}');
    if (hyperbookEditIsSubscribed) {
      // hyperbookEditSubscription!.close();
      hyperbookEditIsSubscribed = false;
    }
    super.dispose();
  }

  Widget showHyperbookTypeDropdown() {
    //%//>print('(N351)&$_model');

    return SizedBox(
        // key: intro!.keys[2],
        width: 250,
        child: Form(
//key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Row(children: <Widget>[
              Text(
                'Hyperbook type: ',
                style: FlutterFlowTheme.of(context).bodyText2.override(
                      fontFamily: 'Rubik',
                      color: const Color(0xFF323B45),
                    ),
              ),
              Expanded(flex: 5, child: Container()),
              const SizedBox(
                width: 16,
              ),
            ])));
  }

  Future<void> handleAddUserToThisHyperbook() async {
    bool confirmDialogResponse = await showDialog<bool>(
            context: context,
            builder: (BuildContext alertDialogContext) {
              return StatefulBuilder(
                builder: (context, StateSetter localSetState) {
                  return AlertDialog(
                    title: const Text('Invite user'),
                    content: Container(
                      height: 220,
                      child: Column(
                        children: [
                          TextFormField(
                            // key: intro!.keys[0],
                            onChanged: (text) {
                              //%//>print('(N2020)${text}');
                              _enteredEmail = text;
                            },
                            controller: _model.emailController,
                            decoration: InputDecoration(
                              labelText: 'Email address of user',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Rubik',
                                    color: const Color(0xFF95A1AC),
                                  ),
                              hintText: 'Enter email address',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Rubik',
                                    color: const Color(0xFF95A1AC),
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFDBE2E7),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context).white,
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 24.0, 0.0, 24.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  color: const Color(0xFF2B343A),
                                ),
                            validator: _model.titleControllerValidator
                                .asValidator(context),
                          ),
                          Text('Select new role for user:'),
                          DropdownButton<String>(
                            key: ValueKey(widget),
                            value: chosenRole,
                            hint: const Text('Please select hyperbook role'),
                            items: kRoleListWithoutAdministrator
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
                                chosenRole = value!;
                              });

                              //%//>print('(N4402)$chosenRole');
                            },
                            isExpanded: true,
                            focusColor: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(alertDialogContext, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(alertDialogContext, true);
                        },
                        child: const Text('Confirm'),
                      ),
                    ],
                  );
                },
              );
            }) ??
        false;
    //%//>print('(N2010)${confirmDialogResponse}¤${_model.emailController.text}%');
    if (confirmDialogResponse) {
      List<UsersRecord> userList = <UsersRecord>[];
      userList = await listUsersListWithEmail(email: _enteredEmail);
      //%//>print('(N2011)${userList}&${getCurrentHyperbook()}');
      if (userList.isEmpty) {
        //%//>print('(N2012)${currentHyperbook!.reference}');
        sendEmail(
            emailType: EmailType.inviteUser,
            senderDisplayName: currentUser!.displayName!,
            senderEmail: currentUser!.email!,
            hyperbookName:
               'REPLACE WITH SESSION', //#widget.hyperbookTitle!,
            receiverEmail: _enteredEmail);
        /*createConnectedUserX(
              user: DocumentReference(path: ''),
              status: chosenRole,
              displayName: _enteredEmail,
              requesting: '',
              parent:
                  localDB.getWorkingHyperbook().reference, //#widget.hyperbook,
              nodeSize: kDefaultNodeSize);*/

        setState(() {});
        toast(context, 'Email sent to invite new user', ToastKind.success);
      } else {
        //%print(
        //    '(N2013)${_enteredEmail}%%%%${userList[0].reference}????${chosenRole}');
        /* DocumentReference invitedConnectedUser =
            await getOrCreateConnectedUsersRecord(
          role: chosenRole,
          hyperbook: getCurrentHyperbook().reference,
          user: userList[0].reference,
          displayName: userList[0].displayName,
        )
                await invitedConnectedUser.update(createConnectedUsersRecordData(
          requesting: '',
          status: chosenRole,
        ));
        */
        //>print('(NY8)${userList[0].reference!.path}');
        // ConnectedUsersRecord? invitedConnectedUserRecord;/* =
        /*  await getOrCreateConnectedUser(
          user: userList[0].reference,
          status: chosenRole,
          requesting: '',
          parent: localDB.getWorkingHyperbook().reference,
          displayName: userList[0].displayName,
          nodeSize: kDefaultNodeSize,
        );*/



        /*    DocumentReference invitedConnectedUser =
            invitedConnectedUserRecord.reference!;*/
        //£ await createReadReferences(getCurrentHyperbook().hyperbook!);
        toast(
            context,
            'User ${userList[0].displayName} given role ${chosenRole}',
            ToastKind.success);
        //%//>print('(N2014)${invitedConnectedUser}');
        //# invalidateHyperbookCache();
      }
    }
/*£    getOrCreateConnectedUsersRecord(
      role: chosenRole,
      hyperbook: currentHyperbook!.reference,
      user: currentUserReference,
      displayName: currentUserDisplayName,
    );*/
  }
/*

  Widget insertRoleGrantDialog() {
    // chosenRole = currentRole;
    //%//>print('(N4400)${chosenRole}');
    return */ /*DropdownButton<String>(
      key: ValueKey(widget),
      value: chosenRole,
      hint: const Text('Please select hyperbook role'),
      items: kRoleList.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
          ),
        );
      }).toList(),
      elevation: 2,
      onChanged: (String? value) {
        setState(() {
          chosenRole = value!;
        });

        //%//>print('(N4402)$chosenRole');
      },
      isExpanded: true,
      focusColor: Colors.transparent,
    );*/
  /* }*/

  Widget insertRoleGrantDialogForNonMembersOLD() {
    // chosenRole = currentRole;
    //>print('(N4400)${_chosenRoleForNonMembers}&&&&${kRoleList}');
    return DropdownButton<String>(
      key: ValueKey(widget),
      value: _chosenRoleForNonMembers,
      hint: const Text('Please select hyperbook role'),
      items: kRoleList.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
          ),
        );
      }).toList(),
      elevation: 2,
      onChanged: (String? value) {
        setState(() {
          _chosenRoleForNonMembers = value!;
          //>print('(N6000)${_chosenRoleForNonMembers}');
        });
      },
      isExpanded: true,
      focusColor: Colors.transparent,
    );
  }

  Widget insertRoleGrantDialogForNonMembers() {
    // chosenRole = currentRole;
    //>print('(N4400)${_chosenRoleForNonMembers}&&&&${kRoleList}');
    List<DropdownMenuEntry<String>> listOfEntries = [];
    for (String role in kRoleListWithoutAdministrator) {
      listOfEntries.add(DropdownMenuEntry(
        value: role,
        label: role,
      ));
    }
    return DropdownMenu<String>(
      controller: roleController,
      inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          constraints: BoxConstraints.tight(const Size.fromHeight(40)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
      //key: GlobalKey(),
      dropdownMenuEntries: listOfEntries,
      onSelected: (value) {
        setState(() {
          _chosenRoleForNonMembers = value!;
          //>print('(N6030)${_chosenRoleForNonMembers}');
        });
      },
    );
  }

  int versionNumber = 1;

  void updateNumber(int value) {
    //%//>print('(N2100)${_previousDaysToHighlight}&&&&${value}');
    versionNumber = value;
  }

  backupHyperbook() async {
    models.FileList? backupFileList =
        await listStorageFiles(bucketId: backupStorageRef.path);
    int maxVersion = 0;
    for (models.File file in backupFileList!.files) {
      String filename = file.name;
      //>print('(BI1)${filename}&&&&');
      // String hyperbookRef = localDB
      //     .getWorkingHyperbook()
      //     .reference!
      //     .path!; //#widget.hyperbook!.path!;
      // if (filename.contains(hyperbookRef)) {
      //   int hyphenPos = filename.indexOf('-');
      //   int dotPos = filename.indexOf('.');
      //   String versionString = '';
      //
      //   if ((dotPos != -1) && (hyphenPos != -1)) {
      //     versionString = filename.substring(hyphenPos + 1, dotPos);
      //   }
      //   int? version = int.tryParse(versionString) ?? 1;
      //   print(
      //       '(BI2)${dotPos}&&&&${hyphenPos}++++${versionString}!!!!${version}????${maxVersion}');
      //   if (version > maxVersion) {
      //     maxVersion = version;
        }


    await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          //# currentCachedHyperbookIndex = getCurrentHyperbookIndex(widget.hyperbook!);
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Backup Hyperbook now?'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Version number:'),
                  SizedBox(
                    width: 100,
                    child: NumberInputPrefabbed.directionalButtons(
                      initialValue: maxVersion + 1,
                      onChanged: (value) {
                        updateNumber(value.toInt());
                      },
                      onIncrement: (value) {
                        updateNumber(value.toInt());
                      },
                      onDecrement: (value) {
                        updateNumber(value.toInt());
                      },
                      isInt: true,
                      scaleHeight: 0.8,
                      controller: numberInputTextController,
                    ),
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
                    // int?
                    //     hyperbookIndex = /*#getCurrentCachedHyperbookIndex(
                    //     hyperbook: widget.hyperbook!);*/
                    //     localDB.workingHyperbookIndex;
                    // HyperbookUsers hyperbookUsers = HyperbookUsers(
                    //   userList: [currentUser!],
                    //   readReferenceList: localDB
                    //       .getWorkingHyperbookLocalDB() /*cachedHyperbookList[currentCachedHyperbookIndex!]*/
                    //       .readReferenceList,
                    // );
                    // HyperbookArchive hyperbookArchive = HyperbookArchive(
                    //   hyperbookLocalDB: localDB.getWorkingHyperbookLocalDB(),
                    //   hyperbookUsers: hyperbookUsers,
                    // );
                    // String hyperbookJson =
                    //     jsonEncode(hyperbookArchive.toJson());
                    // >print('(XY4)${hyperbookIndex}++++${hyperbookJson}');
                    // await createBackupStorageFile(
                    //   hyperbook: localDB.getWorkingHyperbook(),
                    //   body: hyperbookJson,
                    //   versionNumber:
                    //       int.tryParse(numberInputTextController.text) ?? 1,
                    // );
                    // toast(
                    //     context,
                    //     'Backup (Version: ${int.tryParse(numberInputTextController.text) ?? 1}) of ${localDB.getWorkingHyperbook().title} created',
                    //     ToastKind.success);
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
    context.watch<FFAppState>();

    MenuDetails hyperbookEditMenuDetails = MenuDetails(menuLabelList: [
      'Login',
      'Hyperbook list',
      'Map',
      //'Chapter state',
    ], menuIconList: [
      kIconLogin,
      kIconHyperbooks,
      kIconHyperbookMap,
      // kIconChooseChapterState,
    ], menuColorList: [
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
    ], menuTargets: [
      (context) {
        // context.goNamedAuth('login', context.mounted);
        Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: LoginWidget(),
            ));
      },
      (context) {
        // context.goNamedAuth('hyperbook_display', context.mounted);
        Navigator.push(
            context!,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: SessionDisplayWidget(),
            ));
      },
      (context) {
        /*context.pushNamed(
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
              '',
              ParamType.String,
            ),
          }.withoutNulls,
        );*/
        Navigator.push(
            context!,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child:LoginWidget(),
            ));
      },
    ]);

    //_chosenRoleForNonMembers = getCurrentHyperbook().nonMemberRole!;
    print('(XXEB)${hyperbookDisplayIsSubscribed}');
    //# setCachedHyperbookAndChapterList(getCurrentHyperbook().reference!);
    //# setCachedConnectedUsersList(getCurrentHyperbook().reference!);
    ////>print('(N3200)${currentCachedConnectedUsers.length}');
    // currentCachedHyperbookIndex = getCurrentHyperbookIndex(widget.hyperbook!);
    //> print(
    //>    '(HS1)${localDB.getWorkingHyperbookLocalDB().connectedUserList.length}');
    return Title(
      title: 'Hyperbook Edit',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            leading: BackButton(color: Colors.white),
            backgroundColor: FlutterFlowTheme.of(context).primary,
            title: Text(
              'Hyperbook',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Rubik',
                    color: FlutterFlowTheme.of(context).white,
                  ),
            ),
            actions: [
              insertMenu(context, hyperbookEditMenuDetails, setState),
              /*InkWell(
                onTap: () async {
                  intro!.start(context);
                  //--//////%//>print('(XI5)');
                },
                child: Icon(
                  Icons.help_center_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),*/
            ],
            centerTitle: false,
            elevation: 2.0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 16.0, 20.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                // key: intro!.keys[0],
                                controller: _model.titleController,
                                decoration: InputDecoration(
                                  labelText: 'Title',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Rubik',
                                        color: const Color(0xFF95A1AC),
                                      ),
                                  hintText: 'Enter hyperbook title...',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Rubik',
                                        color: const Color(0xFF95A1AC),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).white,
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 24.0, 0.0, 24.0),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Rubik',
                                      color: const Color(0xFF2B343A),
                                    ),
                                validator: _model.titleControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 16.0, 20.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                // key: intro!.keys[1],
                                controller: _model.blurbController,
                                decoration: InputDecoration(
                                  labelText: 'Blurb',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Rubik',
                                        color: const Color(0xFF95A1AC),
                                      ),
                                  hintText: 'Enter hyperbook blurb...',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Rubik',
                                        color: const Color(0xFF95A1AC),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).white,
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 24.0, 0.0, 24.0),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Rubik',
                                      color: const Color(0xFF2B343A),
                                    ),
                                validator: _model.blurbControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Role of all non-members:'),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: insertRoleGrantDialogForNonMembers(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      20.0, 12.0, 20.0, 16.0),
                  child: Wrap(
                    // mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FFButtonWidget(
                          // key: intro!.keys[3],
                          tooltipMessage: 'Click to cancel',
                          onPressed: () async {
                            context.pop();
                          },
                          text: 'Cancel',
                          options: FFButtonOptions(
                            width: 170.0,
                            height: 50.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5.0, 5.0, 5.0, 5.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).alternate,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Rubik',
                                  color: FlutterFlowTheme.of(context).secondary,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FFButtonWidget(
                          // key: intro!.keys[4],
                          onPressed: () async {
                            bool foundExisitingHyperbookTitle = false;
                            /*#  for (CachedHyperbook c in cachedHyperbookList) {
                              if (c.hyperbook!.title ==
                                  _model.titleController.text) {
                                foundExisitingHyperbookTitle = true;
                                break;
                              }
                            }*/
                           /* for (HyperbookLocalDB c in localDB
                                .hyperbooklocalDBList *//*#cachedHyperbookList*//*) {
                              if (c.hyperbook!.title ==
                                  _model.titleController.text) {
                                foundExisitingHyperbookTitle = true;
                                break;
                              }
                            }
                           */
                            /*List<String> titleList = localDB
                                .getHyperbookStringList(kAttHyperbookTitle);
                            if ((foundExisitingHyperbookTitle) &&
                                (_model.titleController.text !=
                                    localDB.getWorkingHyperbook().title)) {
                              toast(
                                  context,
                                  'Hyperbook exists, please choose alternative title',
                                  ToastKind.warning);
                              return;
                            }*/
                            //>print('(N6010)${_chosenRoleForNonMembers}');
                            /*£                  await currentCachedHyperbook!.hyperbook!.reference
                                .update(createHyperbooksRecordData(
                              title: _model.titleController.text,
                              blurb: _model.blurbController.text,
                              moderator: currentUserReference,
                              type: _model.choiceHyperbookTypeNumber,
                              nonMemberRole: _chosenRoleForNonMembers,
                            ));*/
                            /*  await FFAppState()
                                .currentHyperbook!
                                .update(createHyperbooksRecordData(
                                  title: _model.titleController.text,
                                  blurb: _model.blurbController.text,
                                  moderator: currentUserReference,
                                  type: _model.choiceHyperbookTypeNumber,
                                )); */
                            /*£                  setCachedHyperbookAndChapterList(
                                currentCachedHyperbook!.hyperbook!.reference);*/
                          /*  localDB.updateHyperbook(
                                hp: kAttHyperbookTitle,
                                value: _model.titleController.text);
                            localDB.updateHyperbook(
                                hp: kAttHyperbookBlurb,
                                value: _model.blurbController.text);
                            localDB.updateHyperbook(
                                hp: kAttHyperbookNonMemberRole,
                                value: _chosenRoleForNonMembers);*/
                            /*#updateDocument(
                                collection: hyperbooksRef,
                                document: getCurrentHyperbook().reference,
                                data: {
                                  'title': _model.titleController.text,
                                  'blurb': _model.blurbController.text,
                                  'nonMemberRole': _chosenRoleForNonMembers,
                                });
                            invalidateHyperbookCache();*/
                            toast(context, 'Hyperbook updated',
                                ToastKind.success);
                            context.pop();
                          },
                          text: 'Save',
                          options: FFButtonOptions(
                            width: 170.0,
                            height: 50.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5.0, 5.0, 5.0, 5.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FFButtonWidget(
                          // key: intro!.keys[5],
                          onPressed: () async {
                            await backupHyperbook();
                          },
                          text: 'Backup',
                          options: FFButtonOptions(
                            width: 170.0,
                            height: 50.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5.0, 5.0, 5.0, 5.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FFButtonWidget(
                          // key: intro!.keys[6],
                          onPressed: () async {
                            //>print('(N6040)${_chosenRoleForNonMembers}');
                            // bool oKToProceed = await isOKToAddUserToSession();
                            if (true) {
                              handleAddUserToThisHyperbook();
                            } else {
                              await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text('Upgrade to Pro?'),
                                      content: Text(
                                          'You have reached the limit of users for this hyperbook that you can invite'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
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

                          text: 'Add user to hyperbook',
                          options: FFButtonOptions(
                            width: 170.0,
                            height: 50.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5.0, 5.0, 5.0, 5.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
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
                      // TextButton(
                      //   onPressed: () async {
                      //     await sendEmail(
                      //         emailType: EmailType.inviteUser,
                      //         senderDisplayName: currentUser!.displayName!,
                      //         senderEmail: 'no_reply@hyperbook.co.uk',
                      //         hyperbookName: widget.hyperbookTitle!,
                      //         receiverEmail: 'scafflife73@gmail.com',
                      //         receiverDisplayName: 'Fred Bloggs',
                      //         newRole: 'Editor');
                      //   },
                      //   child: const Text('Email'),
                      // ),
                    ],
                  ),
                ),

              ]),
            ),
          ),
        ),
      ),
    );

    ;
  }
}

bool _checkRoleLegal({required String item, required String currentRole}) {

  return false;
}
