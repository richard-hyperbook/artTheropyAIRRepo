import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_util.dart';

class RegisterPageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for inputNormal widget.
  TextEditingController? inputNormalController;
  String? Function(BuildContext, String?)? inputNormalControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? passwordTextController;
  late bool passwordVisibility1;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? confirmPasswordTextController;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)?
      confirmPasswordTextControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    passwordVisibility1 = false;
    passwordVisibility2 = false;
  }

  @override
  void dispose() {
    inputNormalController?.dispose();
    passwordTextController?.dispose();
    confirmPasswordTextController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
