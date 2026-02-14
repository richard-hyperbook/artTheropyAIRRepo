// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

// import '../../auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
import '../../localDB.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../chapter_edit/chapter_edit_widget.dart';
//import '../../auth/auth_util.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/random_data_util.dart' as random_data;
import 'permissions.dart';
import '../../appwrite_interface.dart';

TextEditingController? titleController;

void showCommentDialog(
  BuildContext context,
  DocumentReference hyperbook,
  DocumentReference chapter,
  String body,
  Function setState,
  String hyperbookTitle,
  String hyperbookBlurb,
) {
  Widget titleEntry() {
    if(titleController == null){
      titleController = TextEditingController();
    }
    return TextFormField(
      controller: titleController,
      decoration: InputDecoration(
        labelText: 'Title of new Chapter',
        labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Rubik',
              color: const Color(0xFF95A1AC),
            ),
        hintText: 'Enter your title here...',
        hintStyle: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Rubik',
              color: const Color(0xFF95A1AC),
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFDBE2E7),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFDBE2E7),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: FlutterFlowTheme.of(context).white,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
      ),
      style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Rubik',
            color: const Color(0xFF2B343A),
          ),
    );
  }

  Future addLinkFromChapter(
    DocumentReference? sourceChapter,
    String? sourceChapterBody,
    DocumentReference? targetChapter,
    DocumentReference? hyperbook,
    String? title,
  ) async {
    //const String before = '<br><a href="#';
    //const String after = '" target="_blank">LINK</a>';
    //<br><a href="#hyperbooks/CT3ZqDTUNj0xgTWmTqWL/chapters/K5bXnfKhWPa9s1FddmFE" target="_blank">TITLE</a>
    final String h = targetChapter!.path!;
    final String currentUserDisplay = (currentUser == null)
        ? ''
        : (currentUser!.displayName == null)
            ? ''
            : currentUser!.displayName!;
    final String hyperlink = before +
        h +
        middle +
        'Comment by ' +
        currentUserDisplay +
        ': ' +
        title! +
        after;
    final String newBody = sourceChapterBody! + hyperlink;
    /*final Map<String, dynamic> chaptersUpdateData = createChaptersRecordData(
      body: newBody,
    );
    await sourceChapter!.update(chaptersUpdateData);*/

    //);

   /*# updateDocument(
      collection: chaptersRef,
      document: sourceChapter,
      data: {'body': newBody},
    );*/
  }

  //>//>print('(SD1)');
  showDialog<bool>(
        context: context,
        builder: (BuildContext alertDialogContext) {
          return AlertDialog(
            title: const Text('Add comment?'),
            content: titleEntry(),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  // //>//>print('(N85)${titleController!.text}');




                  //>//>print('(R3)${chapter!.path}++++${body}');
                  //%print(
                  //  '(N94)${chapterJustCreated.title}=${chaptersCreateData}');

                 //invalidateHyperbookCache();
                  //>//>print('(CH80)${chapterJustCreated.title}++++${localDB.getWorkingHyperbookLocalDB().workingChapterIndex}');
                  // localDB.setWorkingChapter(chapterJustCreated.reference!);
                  //>//>print('(CH81)${chapterJustCreated.title}++++${localDB.getWorkingHyperbookLocalDB().workingChapterIndex}');
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: kStandardPageTransitionType,
                      duration: kStandardTransitionTime,
                      reverseDuration: kStandardReverseTransitionTime,
                      child: ChapterEditWidget(
                        chapter: null,//chapterJustCreated.reference,
                        title: titleController!.text,
                        body: ' ',
                        hyperbook: hyperbook,
                        hyperbookTitle: hyperbookTitle,
                        user: currentUser!.reference,
                        authorDisplayName: currentUser!.displayName,
                        hyperbookBlurb: hyperbookBlurb,
                      ),
                    ),
                  );

                  Navigator.pop(alertDialogContext, true);
                },
                child: const Text('Confirm'),
              ),
            ],
          );
        },
      ) ??
      false;

  setState(() {});
}

class ButtonCreateChapterWithLinkTitle extends StatefulWidget {
  const ButtonCreateChapterWithLinkTitle({
    super.key,
    this.width,
    this.height,
    this.hyperbook,
    this.chapter,
    this.body,
    this.icon,
    this.tooltipMessage,
    this.hyperbookTitle,
    this.hyperbookBlurb,
  });

  final double? width;
  final double? height;
  final DocumentReference? hyperbook;
  final DocumentReference? chapter;
  final String? body;
  final Widget? icon;
  final String? tooltipMessage;
  final String? hyperbookTitle;
  final String? hyperbookBlurb;

  @override
  _ButtonCreateChapterWithLinkTitleState createState() =>
      _ButtonCreateChapterWithLinkTitleState();
}

class _ButtonCreateChapterWithLinkTitleState
    extends State<ButtonCreateChapterWithLinkTitle> {
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    //>//>print('(R2A)${localDB.getWorkingChapter()!.reference!.path}++++${localDB.getWorkingChapter()!.body}');
    return FlutterFlowIconButton(
        tooltipMessage: widget.tooltipMessage,
        borderColor: Colors.white,
        //FlutterFlowTheme.of(context).cultured,
        borderRadius: 30,
        borderWidth: 1,
        buttonSize: 60,
        icon: widget.icon!,
        onPressed: () {
          showCommentDialog(
            context,
            widget.hyperbook!,
            widget.chapter!,
            widget.body!,
            setState,
            widget.hyperbookTitle!,
            widget.hyperbookBlurb!,
          );
        });
  }
}
