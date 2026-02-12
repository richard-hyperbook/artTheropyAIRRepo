import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_util.dart';

class PhoneSignInModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for inputNormal widget.
  TextEditingController? inputNormalController;
  String? Function(BuildContext, String?)? inputNormalControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    inputNormalController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
