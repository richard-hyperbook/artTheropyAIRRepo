// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:hyperbook/appwrite_interface.dart';


class DisplayChapterAuthor extends StatefulWidget {
  const DisplayChapterAuthor({
    super.key,
    this.width,
    this.height,
    this.author,
  });

  final double? width;
  final double? height;
  final DocumentReference? author;

  @override
  _DisplayChapterAuthorState createState() => _DisplayChapterAuthorState();
}

class _DisplayChapterAuthorState extends State<DisplayChapterAuthor> {
  UsersRecord? authorRec;


  Future<UsersRecord> populateAuthor() async {
    //>//>print('(D111-2)${widget.author!.path}');
    authorRec = await getUser(
      document: widget.author
    );
    //>//>print('(D111-3)$authorRec');
    return authorRec!;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: populateAuthor(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasData) {
            //>//>print('(D111-4)$snapshot@${widget.author}%$authorRec>');
            return Text(
              authorRec!.displayName!,
              style: FlutterFlowTheme.of(context).bodyText1,
            );
          } else {
            //>//>print('(D111-5)${widget.author}%$authorRec');
            return Text(
              'Unknown',
              style: FlutterFlowTheme.of(context).bodyText1,
            );
          }
        });
  }
}
