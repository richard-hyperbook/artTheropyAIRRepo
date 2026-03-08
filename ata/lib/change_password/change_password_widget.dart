import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'change_password_model.dart';
import '../../appwrite_interface.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../custom_code/widgets/toast.dart';

export 'change_password_model.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({super.key});

  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  late ChangePasswordModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangePasswordModel());

    _model.emailAddressController ??=
        TextEditingController(text: '' /*currentUserEmail*/);
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
        title: 'changePassword',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: BackButton(color: Colors.white),
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            title: Text(
              'Hyperbook Change Password',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Rubik',
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
            ),
            actions: [
              // InkWell(
              //   onTap: () async {
              //     intro!.start(context);
              //     //%//>print('(XI5)');
              //   },
              //   child: kIconInfoStartWhite,
              // ),
            ],
            centerTitle: false,
            elevation: 2.0,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                                    child: Text('Hyperbook\nChange Password',
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
                                  url:
                                      'https://tin.syi.mybluehost.me/hyperbook?reset')
                              .then((ok) {
                            toast(context, 'Reset password email sent',
                                ToastKind.success);
                            print(
                                '(SMTP1)${ok.userId}++++${ok.$id}===${ok.$createdAt}****${ok.phrase}^^^^${ok.secret}');
                          }).onError((e, t) {
                            toast(context, 'Email not sent: ${e}',
                                ToastKind.error);
                            //>print('(SMTP2)${e}++++${t}');
                          });
                          context.pop();
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
                ],
              ),
            ),
          ),
        ));
  }
}
