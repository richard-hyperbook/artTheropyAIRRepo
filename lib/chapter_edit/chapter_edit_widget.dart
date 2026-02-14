import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/firebase_storage/storage.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'chapter_edit_model.dart';
import '../../appwrite_interface.dart';
import '../../custom_code/widgets/html_editor_class.dart';
import '../../custom_code/widgets/toast.dart';
// import '../../custom_code/widgets/quill_editor_class.dart';

export 'chapter_edit_model.dart';

class ChapterEditWidget extends StatefulWidget {
  const ChapterEditWidget({
    super.key,
    this.chapter,
    this.title,
    this.body,
    this.hyperbook,
    this.user,
    this.hyperbookTitle,
    this.authorDisplayName,
    this.hyperbookBlurb,
  });

  final DocumentReference? chapter;
  final String? title;
  final String? body;
  final DocumentReference? hyperbook;
  final DocumentReference? user;
  final String? hyperbookTitle;
  final String? authorDisplayName;
  final String? hyperbookBlurb;

  @override
  _ChapterEditWidgetState createState() => _ChapterEditWidgetState();
}

class _ChapterEditWidgetState extends State<ChapterEditWidget> {
  late ChapterEditModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChapterEditModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    //>print('<LD30>${localDB.getWorkingChapter()!.body}');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    /*#setCurrentCachedChapterIndex(chapter: widget.chapter!);*/
    //localDB.setWorkingChapter( widget.chapter!);
    //>print('(N1103A)${localDB.getWorkingChapter()!.reference!.path}****${localDB.getWorkingChapter()!.body}');
    // //>print('(N1103B)${widget.chapter!.path}');
    // //>print('(N1103C)${currentCachedChapterList[currentCachedChapterIndex!].body}');

    return SizedBox(
        width: MediaQuery
            .sizeOf(context)
            .width * 1.0,
        height: MediaQuery
            .sizeOf(context)
            .height * 0.95,
        child: //
        HtmlEditorClass(
          // QuillEditor(
          width: MediaQuery
              .sizeOf(context)
              .width * 1.0,
          height: MediaQuery
              .sizeOf(context)
              .height * 0.95,
        ));
  }
}
