import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';

class HyperbookEditModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final FocusNode unfocusNode = FocusNode();
  // State field(s) for title widget.
  TextEditingController? titleController;
  String? Function(BuildContext, String?)? titleControllerValidator;
  // State field(s) for blurb widget.
  TextEditingController? blurbController;
  String? Function(BuildContext, String?)? blurbControllerValidator;
  // State field(s) for ChoiceChipsVisibility widget.
  String? choiceChipsVisibilityValue;
  FormFieldController<List<String>>? choiceChipsVisibilityValueController;
  // State field(s) for ChoiceChipsReader widget.
  String? choiceChipsReaderValue;
  FormFieldController<List<String>>? choiceChipsReaderValueController;
  // State field(s) for ChoiceChipsCollaborator widget.
  String? choiceChipsCollaboratorValue;
  FormFieldController<List<String>>? choiceChipsCollaboratorValueController;
  int? choiceHyperbookTypeNumber;
  /// // State field(s) for email widget.
     TextEditingController? emailController;
    // String? Function(BuildContext, String?)? titleControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    titleController?.dispose();
    blurbController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
