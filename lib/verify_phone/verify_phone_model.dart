import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_util.dart';

class VerifyPhoneModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for SmsCodeTextField widget.
  TextEditingController? smsCodeTextFieldController;
  String? Function(BuildContext, String?)? smsCodeTextFieldControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    smsCodeTextFieldController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
