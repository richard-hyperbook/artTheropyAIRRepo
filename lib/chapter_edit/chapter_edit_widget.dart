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
import 'package:hyperbook/appwrite_interface.dart';
import 'package:hyperbook/custom_code/widgets/html_editor_class.dart';
import '../../custom_code/widgets/toast.dart';
// import 'package:hyperbook/custom_code/widgets/quill_editor_class.dart';

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
    if (localDB.getWorkingChapter() == null){
     // toast(context, 'Error in Chapter selection', ToastKind.error);
      context.pop();
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 0.95,
      child: //
       HtmlEditorClass(
      // QuillEditor(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 0.95,
        chapter: localDB.getWorkingChapter()!.reference, //#widget.chapter,
        hyperbook: localDB.getWorkingHyperbook().reference, //#widget.hyperbook,
        hyperbookTitle: localDB.getWorkingHyperbook().title,//#widget.hyperbookTitle,
        title: /*#currentCachedChapterList[currentCachedChapterIndex ?? 0].title,*/
        localDB.getWorkingChapter()!.title,
        body: /*currentCachedChapterList[currentCachedChapterIndex ?? 0].body*/
        localDB.getWorkingChapter()!.body,
        authorDisplayName: localDB.getWorkingChapter()!.authorDisplayName,//widget.authorDisplayName,
         hyperbookBlurb: localDB.getWorkingHyperbook().blurb,//#widget.hyperbookBlurb,
      )

      /*custom_widgets.GetChapters(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 0.95,
        drawMapWhenComplete: functions.returnFalse(),
        hyperbookTitle: widget.hyperbookTitle,
        editHtmlWhenComplete: functions.returnTrue(),
        body: widget.body,
        hyperbook: widget.hyperbook,
        user: currentUser!.reference,
        chapter: widget.chapter,
        chapterTitle: widget.title,
      )*/,

      /*
                    FFButtonWidget(
                      onPressed: () async {
                        final List<SelectedFile>? selectedMedia =
                            await selectMediaWithSourceBottomSheet(
                          context: context,
                          allowPhoto: true,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((SelectedFile m) =>
                                validateFileFormat(m.storagePath, context))) {
                          setState(() => _model.isDataUploading = true);
                          List<FFUploadedFile> selectedUploadedFiles = <FFUploadedFile>[];

                          List<String> downloadUrls = <String>[];
                          try {
                            selectedUploadedFiles = selectedMedia
                                .map((SelectedFile m) => FFUploadedFile(
                                      name: m.storagePath.split('/').last,
                                      bytes: m.bytes,
                                      height: m.dimensions?.height,
                                      width: m.dimensions?.width,
                                      blurHash: m.blurHash,
                                    ))
                                .toList();

                            downloadUrls = (await Future.wait(
                              selectedMedia.map(
                                (SelectedFile m) async =>
                                    uploadData(m.storagePath, m.bytes),
                              ),
                            ))
                                .where((String? u) => u != null)
                                .map((String? u) => u!)
                                .toList();
                          } finally {
                            _model.isDataUploading = false;
                          }
                          if (selectedUploadedFiles.length ==
                                  selectedMedia.length &&
                              downloadUrls.length == selectedMedia.length) {
                            setState(() {
                              _model.uploadedLocalFile =
                                  selectedUploadedFiles.first;
                              _model.uploadedFileUrl = downloadUrls.first;
                            });
                          } else {
                            setState(() {});
                            return;
                          }
                        }
                      },
                      text: 'Button',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                ),
                        elevation: 3.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),

                    */
    );
  }
}
