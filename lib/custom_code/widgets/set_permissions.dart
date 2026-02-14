// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_util.dart';
import '../../appwrite_interface.dart';

// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'permissions.dart';

class SetPermissions extends StatefulWidget {
  const SetPermissions({
    super.key,
    this.width,
    this.height,
    this.requiresReaderApproval,
    this.requiresColaboratorApproval,
    this.visibility,
    this.maxRole,
    this.hyperbook,
    this.approvedHyperbookReads,
    this.approvedHyperbookCollabotates,
    this.index,
  });

  final double? width;
  final double? height;
  final String? requiresReaderApproval;
  final String? requiresColaboratorApproval;
  final String? visibility;
  final String? maxRole;
  final DocumentReference? hyperbook;
  final List<DocumentReference>? approvedHyperbookReads;
  final List<DocumentReference>? approvedHyperbookCollabotates;
  final int? index;

  @override
  _SetPermissionsState createState() => _SetPermissionsState();
}

class _SetPermissionsState extends State<SetPermissions> {
  @override
  Widget build(BuildContext context) {
    bool canRead = false;
    if (widget.requiresReaderApproval! == kRRA2) {
      canRead = true;
    }
    FFAppState().canRead[widget.index!] = canRead;
    FFAppState().canReadCurrentHyperbook = canRead;

    return const Text('X');
  }
}
