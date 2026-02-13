import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '/auth/firebase_auth/auth_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:hyperbook/custom_code/widgets/permissions.dart';
import 'login_model.dart';
import '/appwrite_interface.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyperbook/custom_code/widgets/toast.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '../menu.dart';
import '../appwrite_interface.dart';
import '../localDB.dart';
import 'package:hyperbook/session_display/session_display_widget.dart';
import 'package:hyperbook/profile_page/profile_page_widget.dart';
// import 'package:hyperbook/map_display/map_display_widget.dart';
import 'package:hyperbook/change_password/change_password_widget.dart';
import 'package:hyperbook/paypal/paypal_widget.dart';
import 'package:hyperbook/sales/sales_widget.dart';
import 'package:hyperbook/conditional.dart';



export 'login_model.dart';


class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UsersRecord? user;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());
    _model.emailAddressController ??= TextEditingController();
    _model.passwordController ??= TextEditingController();
    listenForMessage();
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
    double logoSize = (MediaQuery.sizeOf(context).width < 1000) ? 50 : 100;

    MenuDetails loginMenuDetails = MenuDetails(menuLabelList: [
      'Sessions',
      'Profile',
      'Upgrade',
      'Sales'
    ], menuIconList: [
      kIconHyperbooks,
      kIconProfile,
      kIconUpgrade,
      kIconRequestsOutstanding
      // kIconChooseChapterState,
    ], menuColorList: [
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
    ], menuTargets: [
      (context) {
        //>print('<ME100>');
        Navigator.push(
            context!,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: SessionDisplayWidget(),
            ));
        // context.goNamedAuth('hyperbook_display', context.mounted);
      },
          (context) {
        // context.goNamedAuth('profilePage', context.mounted);
        Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: ProfilePageWidget(),
            ));
      },
          (context) {
        // context.goNamedAuth('profilePage', context.mounted);
            Navigator.push(
                context,
                PageTransition(
                  type: kStandardPageTransitionType,
                  duration: kStandardTransitionTime,
                  reverseDuration: kStandardReverseTransitionTime,
                  child: PayPalWidget(),
                ));
          },
          (context) {
        // context.goNamedAuth('profilePage', context.mounted);
        Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: SalesWidget(),
            ));
      },
    ]);

    return Title(
        title: 'login',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 1.0,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Container(
                  // width: MediaQuery.sizeOf(context).width * 1.0,
                  // height: MediaQuery.sizeOf(context).height * 1.0,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[Colors.amber, Colors.yellow],
                      stops: <double>[0.0, 1.0],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 30.0, 0.0, 0.0),
                          child: Row(children: []),
                        ),
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.95,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        /*#await loadCachedChaptersReadReferencesCachedHyperbookIndex(
                                            hyperbook: tutorialHyperbook,
                                            user: currentUser);
                                        */
                                        toast(
                                            context,
                                            'Please wait while Hyperbook Tutorial loads',
                                            ToastKind.success);
                                        /*context.pushNamed(
                                          'map_display',
                                          queryParameters: <String, String?>{
                                            'hyperbook': serializeParam(
                                              localDB
                                                  .getWorkingHyperbook()
                                                  .reference,
                                              ParamType.DocumentReference,
                                            ),
                                            'hyperbookTitle': serializeParam(
                                              localDB
                                                  .getWorkingHyperbook()
                                                  .title,
                                              ParamType.String,
                                            ),
                                            'hyperbookBlurb': serializeParam(
                                              localDB
                                                  .getWorkingHyperbook()
                                                  .blurb,
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                        );*/
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
                                      child:FittedBox(child: Container(color: Colors.amber, child: Text('ArtTheropyAIR App')),)
                                      /* SvgPicture.asset(
                                        'assets/images/brush4.svg',
                                        width: logoSize,
                                        height: logoSize,
                                      ),*/
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                              '\u2B05Click the\n\u2B05logo\n\u2B05to learn about\n\u2B05this app.',
                                              overflow: TextOverflow.fade,
                                              //   style: FlutterFlowTheme.of(context)
                                              //      .headlineMedium,),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    MediaQuery.sizeOf(context)
                                                                .width <
                                                            1000
                                                        ? (MediaQuery.sizeOf(
                                                                        context)
                                                                    .width <
                                                                500
                                                            ? 12
                                                            : 12)
                                                        : 20,
                                              )))),
                                  Expanded(child: Container(width: 50)),
                                  Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text('Art Theropy AIR\nApp',
                                                  overflow: TextOverflow.fade,
                                                  //   style: FlutterFlowTheme.of(context)
                                                  //      .headlineMedium,),
                                                  style: TextStyle(
                                                    fontSize: MediaQuery.sizeOf(
                                                                    context)
                                                                .width <
                                                            1000
                                                        ? (MediaQuery.sizeOf(
                                                                        context)
                                                                    .width <
                                                                500
                                                            ? 20
                                                            : 30)
                                                        : 55,
                                                  )))),
                                      insertMenu(
                                          context, loginMenuDetails, setState),
                                    ],
                                  ),
                                ])),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 36.0, 0.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 3.0, 0.0, 0.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 16.0, 20.0, 0.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'Login or Create Account',
                                            style: (MediaQuery.sizeOf(context)
                                                        .width >
                                                    2000)
                                                ? FlutterFlowTheme.of(context)
                                                    .displaySmall
                                                : FlutterFlowTheme.of(context)
                                                    .bodyLarge,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 16.0, 20.0, 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                _model.emailAddressController,
                                            decoration: InputDecoration(
                                              labelText: 'Email Address',
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color:
                                                        const Color(0xFF95A1AC),
                                                  ),
                                              hintText:
                                                  'Enter your email here...',
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color:
                                                        const Color(0xFF95A1AC),
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFDBE2E7),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .white,
                                              contentPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      16.0, 24.0, 0.0, 24.0),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Rubik',
                                                  color:
                                                      const Color(0xFF2B343A),
                                                ),
                                            validator: _model
                                                .emailAddressControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 16.0, 20.0, 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                _model.passwordController,
                                            obscureText:
                                                !_model.passwordVisibility,
                                            decoration: InputDecoration(
                                              labelText: 'Password',
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color:
                                                        const Color(0xFF95A1AC),
                                                  ),
                                              hintText:
                                                  'Enter your password here...',
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color:
                                                        const Color(0xFF95A1AC),
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFDBE2E7),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .white,
                                              contentPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      16.0, 24.0, 0.0, 24.0),
                                              suffixIcon: InkWell(
                                                onTap: () => setState(
                                                  () => _model
                                                          .passwordVisibility =
                                                      !_model
                                                          .passwordVisibility,
                                                ),
                                                focusNode: FocusNode(
                                                    skipTraversal: true),
                                                child: Icon(
                                                  _model.passwordVisibility
                                                      ? Icons
                                                          .visibility_outlined
                                                      : Icons
                                                          .visibility_off_outlined,
                                                  color:
                                                      const Color(0xFF95A1AC),
                                                  size: 22.0,
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Rubik',
                                                  color:
                                                      const Color(0xFF2B343A),
                                                ),
                                            validator: _model
                                                .passwordControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 12.0, 20.0, 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        FFButtonWidget(
                                          tooltipMessage:
                                              'Click to change password',
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: kStandardPageTransitionType,
                                                    duration:kStandardTransitionTime,
                                                    reverseDuration: kStandardReverseTransitionTime,
                                                    child:ChangePasswordWidget()));
                                            //context.pushNamed('changePassword');
                                          },
                                          text: 'Forgot Password?',
                                          options: FFButtonOptions(
                                            width: 170.0,
                                            height: (MediaQuery.sizeOf(context)
                                                        .width <
                                                    kPhonewWidthThreashold)
                                                ? 20.0
                                                : 40.0,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .white,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Rubik',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            // //>print('(N230-1)${currentReadReferences.length}');


                                            GoRouter.of(context)
                                                .prepareAuthEvent();
                                            // //>print('(N230-2)${currentReadReferences.length}');
                                            // BaseAuthUser? user =
                                            //     await authManager.signInWithEmail(
                                            //   context,
                                            //   _model.emailAddressController.text,
                                            //   _model.passwordController.text,
                                            // );
                                            String e = _model
                                                .emailAddressController.text;

                                            if ((e.length == 2) &&
                                                (e[0] == '#')) {
                                              if (e[1] == 'r') {
                                                _model.emailAddressController
                                                        .text =
                                                    'richard@hyperbook.co.uk';
                                              } else {
                                                if (e[1] == 's') {
                                                  _model.emailAddressController
                                                          .text =
                                                      'scafflife73@gmail.com';
                                                } else {
                                                  if (e[1] == 'd') {
                                                    _model.emailAddressController
                                                            .text =
                                                        'richard.dennis.spencer@gmail.com';
                                                  } else {
                                                    _model.emailAddressController
                                                            .text =
                                                        '${e[1]}@${e[1]}.com';
                                                  }
                                                }
                                              }
                                              _model.passwordController.text =
                                                  'aaaaaaaa';
                                            }
                                            models.User? appwriteUser;
                                            print(
                                                '(N91-A)${_model.emailAddressController.text}++++${_model.passwordController.text}');
                                            try {
                                              user = await appwriteLogin(
                                                context,
                                                _model.emailAddressController
                                                    .text,
                                                _model.passwordController.text,
                                              );
                                            } on AppwriteException catch (e) {
                                              print(
                                                  '(N91-B)${e.type}****${e.message}');
                                              //   toast(context, 'Login failure: ${e.message}', ToastKind.error);
                                            }
                                            // currentUser =
                                            // await getUser(document: user!.reference);
                                            print(
                                                '(N91-C)${user}....${loggedInUser}%%%%${_model.emailAddressController.text}++++${_model.passwordController.text}');
                                            // //>print('(N230-3B)${loggedInUser!.email}');
                                            print(
                                                '(N91-D)${user!.reference!.path}');
                                            print(
                                                '(N91-E)${user!.displayName}****${currentUser!.displayName}');

                                            /*         await actions.setupUserOnLogin(
                                              context,
                                              (currentUserDocument?.chapterColorsInts
                                                          .toList() ??
                                                      <int>[])
                                                  .toList(),
                                            );*/
                                            loggedIn = true;
                                            //#hyperbookCacheValid = false;
                                            //# coonectedUsersCacheValid = false;

                                            /*#await loadCachedHyperbookLists(
                                                DocumentReference(
                                                    path: loggedInUser!
                                                        .$id));*/
                                            // await setCurrentReadReferences();
                                            print(
                                                '(N230-7)${currentUser!.email}****${DocumentReference(path: '')}////');

                                            /*        models.DocumentList connctedUserList =
                                                await listDocumentsWithOneQueryString(
                                              collection: connectedUsersRef,
                                              attribute: 'status',
                                              value:'Editor',
                                                      // _model.emailAddressController.text,
                                              // attribute2: 'user',
                                              // value2: DocumentReference(path: ''),
                                            );*/
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: kStandardPageTransitionType,
                                                  duration: kStandardTransitionTime,
                                                  reverseDuration: kStandardReverseTransitionTime,
                                                  child: SessionDisplayWidget(),
                                                ));


                                          },
                                          text: 'Login',
                                          options: FFButtonOptions(
                                            width: 110.0,
                                            height: 50.0,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                                                      fontSize: 18.0,
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

                                        /*
                                        FFButtonWidget(
                                          onPressed: () async {

                                            authManager.signOut();
                                          },
                                          text: 'Logout',
                                          options: FFButtonOptions(
                                            width: 130.0,
                                            height: 50.0,
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                            color:
                                            FlutterFlowTheme.of(context).primary,
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

                                  */
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 2.0,
                                    thickness: 2.0,
                                    indent: 20.0,
                                    endIndent: 20.0,
                                    color: Color(0xFFDBE2E7),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          // width: 40,
                                          // height: 40,
                                          child: FlutterFlowIconButton(
                                            caption: 'Profile',
                                            enabled: true,
                                            fillColor: Colors.white,
                                            tooltipMessage: 'Change profile',
                                            // borderColor: FlutterFlowTheme.of(context)
                                            //   .primary,

                                            borderColor: Colors.transparent,
                                            borderRadius: 0.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,

                                            // borderRadius: 30,
                                            // borderWidth: 1,
                                            // buttonSize: 60,
                                            icon: kIconProfile,
                                            onPressed: () {
                                              // context.goNamedAuth('profilePage',
                                              //     context.mounted);
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type:
                                                        kStandardPageTransitionType,
                                                    duration:
                                                        kStandardTransitionTime,
                                                    reverseDuration:
                                                        kStandardReverseTransitionTime,
                                                    child: ProfilePageWidget(),
                                                  ));
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 12.0, 0.0, 12.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            context.pushNamed(
                                              'createAccount',
                                              // extra: <String, dynamic>{
                                              //   kTransitionInfoKey: const TransitionInfo(
                                              //     hasTransition: true,
                                              //     duration: Duration(milliseconds: 250),
                                              //   ),
                                              // },
                                            );
                                          },
                                          text: 'Create Account',
                                          options: FFButtonOptions(
                                            width: 170.0,
                                            height: 40.0,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .white,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Rubik',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 0.0, 12.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            /*        GoRouter.of(context).prepareAuthEvent();
                                            // final BaseAuthUser? user = await authManager
                                            // .signInAnonymously(context);
                                            //>print('(CA1)${loggedInUser}');
                                            try {
                                              await appwriteLogout();
                                            } on AppwriteException catch (e) {
                                              //>print('(CA1E)${e}');
                                            }
                                            //>print('(CA2)${loggedInUser}');
                                            final guestUser =
                                                await account!.createAnonymousSession();
                                            loggedInUser = await account!.get();
                                            //>print('(CA3)${guestUser}****${loggedInUser}');
                                            toast(context, 'Please create account',
                                                ToastKind.warning);
                                            if (guestUser == null) {
                                              return;
                                            } else {
                                              print(
                                                  '(CA4)${guestUser.clientName}%%%%${guestUser.clientType}');
                                              loggedIn = true;
                                              hyperbookCacheValid = false;
                                              coonectedUsersCacheValid = false;
                                              await loadCachedHyperbookLists(
                                                  DocumentReference(
                                                      path:
                                                          'Guest') */ /*, fromCache: false*/ /*);
                                              // await setCurrentReadReferences();

                                              print(
                                                  '(CA5)${guestUser.clientName}++++${cachedHyperbookList.length}');
                                            }
                                                                    */
                                            // context.goNamedAuth(
                                            //     'hyperbook_display',
                                            //     context.mounted);
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
                                                  SessionDisplayWidget(),
                                                ));
                                          },
                                          text: 'Continue as Guest',
                                          icon: const Icon(
                                            Icons.person_outline,
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: 220.0,
                                            height: 40.0,
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .white,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Rubik',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(0.95, 0.0),
                                    child: Text(
                                      '\u00a92025 Hyperbook Ltd.    ${versionNumber.toString()}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w100,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        /*
                        const SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: custom_widgets.SetIntroductionHyperbook(
                            width: 20.0,
                            height: 20.0,
                          ),
                        ),*/


                                                SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}


/*


*/
