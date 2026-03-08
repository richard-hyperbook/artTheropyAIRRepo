// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../appwrite_interface.dart';

class DisplayHyperbookModerator extends StatefulWidget {
  const DisplayHyperbookModerator({
    super.key,
    this.width,
    this.height,
    this.moderator,
  });

  final double? width;
  final double? height;
  final DocumentReference? moderator;

  @override
  _DisplayHyperbookModeratorState createState() =>
      _DisplayHyperbookModeratorState();
}

class _DisplayHyperbookModeratorState extends State<DisplayHyperbookModerator> {
  UsersRecord? moderatorRec;

  Future<void> populateModerator() async {
    //>//>print('(D211-2)${widget.moderator!.path}');
    moderatorRec = await getUser(document: widget.moderator!);
    //>//>print('(D211-3)$moderatorRec');
  }

  @override
  void initSate() async {
    await populateModerator();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: populateModerator(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasData) {
           // //%//>//>print('(D211-4)$snapshot@${widget.moderator}%$moderatorRec>');
            return Text(
              moderatorRec!.displayName!,
              style: FlutterFlowTheme.of(context).bodyText1,
            );
          } else {
            return Text(
              'Unknown',
              style: FlutterFlowTheme.of(context).bodyText1,
            );
          }
        });
  }
}
