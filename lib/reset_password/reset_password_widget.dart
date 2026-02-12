import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'reset_password_model.dart';
import 'package:hyperbook/appwrite_interface.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../custom_code/widgets/toast.dart';
import 'package:hyperbook/appwrite_interface.dart';
import 'package:window_location_href/window_location_href.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:hyperbook/login/login_widget.dart';

export 'reset_password_model.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({super.key});

  @override
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  late ResetPasswordModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResetPasswordModel());

    _model.emailAddressController ??=
        TextEditingController(text: currentUserEmail);
    // WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  String _savedHref = '';
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if ((href != null) && (href!.contains('userId'))){
      _savedHref = href!;
    }
    //>print('(HPR1A)${href}&&&&${_savedHref}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Hyperbook Reset Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/hyperbooklogosvg10.svg',
                    width: 100,
                    height: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Hyperbook\nReset Password',
                      overflow: TextOverflow.fade,
                      //   style: FlutterFlowTheme.of(context)
                      //      .headlineMedium,),
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: 300,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black),
              ),
              child: TextFormField(controller: controller),
            ),
          ),
          SizedBox(height: 5),
          Text('Enter new password'),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Reset Password'),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
              foregroundColor: WidgetStatePropertyAll<Color>(Colors.black),
              elevation: WidgetStatePropertyAll<double>(5.0),
            ),
            onPressed: () {
              //>print('(HPR1B)${client!.endPoint}||||${account}____${_savedHref}}');
              List<String> breakUserIdStart = _savedHref.split('userId=');
              //>print('(HPR2)${breakUserIdStart.length}++++');
              if (breakUserIdStart.length < 2) {
                toast(context, 'Error 1: illformed url', ToastKind.error);
                return;
              }
              List<String> breakUserIdEnd = breakUserIdStart[1].split('&');
              if (breakUserIdEnd.length < 2) {
                toast(context, 'Error 2: illformed url', ToastKind.error);
                return;
              }
              String userId = breakUserIdEnd[0];
              List<String> breakSecretStart = _savedHref.split('secret=');
              if (breakSecretStart.length < 2) {
                toast(context, 'Error 3: illformed url', ToastKind.error);
                return;
              }
              List<String> breakSecretEnd = breakSecretStart[1].split('&');
              if (breakSecretStart.length < 2) {
                toast(context, 'Error 4: illformed url', ToastKind.error);
                return;
              }
              String secret = breakSecretEnd[0];
              //>print('(HPR3)${_savedHref + '++++' + userId + '~~~~' + secret}');
              //>print('(HPR4)${userId}');
              //>print('(HPR5)${secret}');
              //>print('(HPR6)${controller.text}');
              try {
                account!
                    .updateRecovery(
                  userId: userId,
                  secret: secret,
                  password: controller.text,
                )
                    .then((x) {
                  //>print('(HPR9)${x}');
                  toast(context, 'Password changed', ToastKind.success);
                  Navigator.push(
                      context!,
                      PageTransition(
                        type: kStandardPageTransitionType,
                        duration:kStandardTransitionTime,
                        reverseDuration: kStandardReverseTransitionTime,
                        child: LoginWidget(
                        ),
                      ));

                })
                    .onError((e, f) {
                  print('(HPR10)${e}++++${f}');
                  // toast(context, 'Error 5: ${e}', ToastKind.error);
                });
              } on AppwriteException catch (e) {
                //>print('(HPR7)${e.message}');
                toast(context, 'Error 6: ${e.message}', ToastKind.error);
              } finally {
                Navigator.push(
                    context!,
                    PageTransition(
                      type: kStandardPageTransitionType,
                      duration:kStandardTransitionTime,
                      reverseDuration: kStandardReverseTransitionTime,
                      child: LoginWidget(
                      ),
                    ));
              }
              //>print('(HPR8)');
            },
          ),
          SizedBox(height: 100),
          Text(versionNumber.toString()),
        ],

      ),
    );
  }


  /*
  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    //>print('(IN2)');
    resetPasswordCommandRecived = false;
    return Title(
        title: 'resetPassword',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pop();
              },
              child: kIconBackArrow,
            ),
            title: Text(
              'Reset Password',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Lexend Deca',
                    color: const Color(0xFF14181B),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 0.0,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.95,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/images/hyperbooklogosvg10.svg',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text('Hyperbook\nReset Password',
                                        overflow: TextOverflow.fade,
                                        //   style: FlutterFlowTheme.of(context)
                                        //      .headlineMedium,),
                                        style: TextStyle(
                                          fontSize: 25,
                                        ))))
                          ])),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        20.0, 12.0, 20.0, 12.0),
                    child: TextFormField(
                      controller: _model.emailAddressController,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Lexend Deca',
                                  color: const Color(0xFF95A1AC),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintText: 'Your email..',
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Lexend Deca',
                                  color: const Color(0xFF95A1AC),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
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
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 0.0, 24.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Lexend Deca',
                            color: const Color(0xFF14181B),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                      validator: _model.emailAddressControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        20.0, 0.0, 20.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'We will send you an email with a link to reset your password, please enter the email associated with your account.',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.05),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 24.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        tooltipMessage:
                            'Click to request email to reset your password',
                        onPressed: () async {
                          if (_model.emailAddressController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Email required!',
                                ),
                              ),
                            );
                            return;
                          }

                          var token = account!
                              .createRecovery(
                                  email: _model.emailAddressController.text,
                                  url: 'https://hyperbook.co.uk?reset')
                              .then((ok) {
                            print(
                                '(SMTP1)${ok.userId}++++${ok.$id}===${ok.$createdAt}****${ok.phrase}^^^^${ok.secret}');
                            toast(context, 'Password changed', ToastKind.success);
                          }).onError((e, t) {
                            toast(context, 'Password Not changed: ${e}', ToastKind.error);
                            //>print('(SMTP2)${e}++++${t}');
                          });
                        },
                        text: 'Send Reset Link',
                        options: FFButtonOptions(
                          width: 340.0,
                          height: 60.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                          elevation: 2.0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        20.0, 0.0, 20.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'If you do not wish to change your password, please dismiss this screen.',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

   */
}
