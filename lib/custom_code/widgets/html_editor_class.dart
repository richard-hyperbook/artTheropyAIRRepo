// Automatic FlutterFlow imports
import 'dart:convert';

//import 'package:file_picker/file_picker.dart';
// import '../../flutter_flow/upload_media.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import '../html_editor.dart';
// import '../../editor_git/lib/html_editor.dart';

// import '/backend/backend.dart';
import '/chapter_edit/chapter_edit_model.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
// import '../../backend/firebase_storage/storage.dart';
import 'permissions.dart';
// import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:html_editor_enhanced/html_editor.dart';

export '/chapter_edit/chapter_edit_model.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
// import 'package:hyperbook/backend/push_notifications/push_notifications_util.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_intro/flutter_intro.dart';
import 'package:hyperbook/custom_code/widgets/toast.dart';
import 'package:hyperbook/appwrite_interface.dart';
// import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart'
//     if (dart.library.html) 'dart:ui' as ui;

// import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:clipboard/clipboard.dart';
// import 'package:platform_file/platform_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:chiclet/chiclet.dart';
import '../../menu.dart';
import '../../localDB.dart';
import 'package:hyperbook/login/login_widget.dart';
import 'package:hyperbook/hyperbook_display/hyperbook_display_widget.dart';
import 'package:hyperbook/chapter_display/chapter_display_widget.dart';
// import 'package:hyperbook/map_display/map_display_widget.dart';

class HtmlEditorClass extends StatefulWidget {
  const HtmlEditorClass({
    super.key,
    this.width,
    this.height,
    this.title, //unused
    this.chapter,
    this.body, //unused
    this.hyperbook,
    this.hyperbookTitle,
    this.authorDisplayName,
    required this.hyperbookBlurb,
  });

  final double? width;
  final double? height;
  final String? title;
  final DocumentReference? chapter;
  final String? body;
  final DocumentReference? hyperbook;
  final String? hyperbookTitle;
  final String? authorDisplayName;
  final String? hyperbookBlurb;

  @override
  _HtmlEditorClassState createState() => _HtmlEditorClassState();
}

class _HtmlEditorClassState extends State<HtmlEditorClass> {
  String result = '';
  final HtmlEditorController hTMLController = HtmlEditorController();
  final TextEditingController newLinkTitleController = TextEditingController();
  String? dropDownValue;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isMediaUploading = false;
  String uploadedFileUrl = '';
  late ChapterEditModel _model;
  bool hasChanged = false;

  List<Widget> imageWidgetList = [];
  List<String> imageFilenameList = [];
  List<void Function(int imageNumber)> imageWidthChange = [];
  // List<TextEditingController> imageWidthTextEditingController = [];
  // List<TextEditingController> imageHeightTextEditingController = [];
  static const String kImageTag = '<img';
  List<ImageHtmlValues> imageHtmlList = [];
  String preImageHtml = '';

  String? output = 'XXX';

  // Intro? intro;
  _HtmlEditorClassState() {
    //%//>//>print('(XI3)');
    /* intro = Intro(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      stepCount: 8,
      maskClosable: true,
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
        texts: [
          '\nClick to see list of chapters',
          '\nClick to see hyperbook map',
          'Edit text of chapter',
          'Click to save chapter',
          'Click to change title of chapter',
          'Click to insert a link here to another existing chapter',
          'Click to create a new chapter and insert a link here',
          'Click to insert an image here',
        ],
        buttonTextBuilder: (currPage, totalPage) {
          //%//>//>print('(XI1)${currPage}%${totalPage}');
          return currPage < totalPage - 1 ? 'Next' : 'Finish';
        },
      ),
    );
    intro!.setStepConfig(
      0,
      borderRadius: BorderRadius.circular(64),
    );*/
  }

  bool hasJustLoaded = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChapterEditModel());
    // quillController = QuillEditorController();
    hasChanged = false;
    hasJustLoaded = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

/*  @override
  void dispose() {
    _model.dispose();
    //>//>print('<LD31>${localDB.getWorkingChapter().body}');
    // if (hasChanged)
    // saveText();x
    super.dispose();
  }
  */

  Future<void> getOutput() async {
    output = await hTMLController.getText();
  }

  Future<void> saveText() async {
    FFAppState().currentBody = await hTMLController.getText();
    FFAppState().currentChapterTitle = titleController.text;
    // localDB.setWorkingChapter(widget.chapter!);
    /*#  int? currentHyperbookIndex;
    if (currentCachedChapterIndex != null) {
      cachedHyperbookList[currentCachedHyperbookIndex!].chapterList[currentCachedChapterIndex!].body =
          FFAppState().currentBody;
      currentHyperbookIndex = getCurrentHyperbookIndex(widget.hyperbook!);
      if (currentHyperbookIndex != null) {
        cachedHyperbookList[currentHyperbookIndex]
            .chapterList[currentCachedChapterIndex!]
            .body = FFAppState().currentBody;
      }
    }
    //>//>print('(D999)${currentCachedChapterIndex}++++${currentHyperbookIndex}');
  */ // //>//>print('(D720A)${FFAppState().currentBody}');
    //await FFAppState().currentChapter!.update(chaptersUpdateData);
    //>//>print('(CH100)${localDB.getWorkingChapter()!.reference!.path}');
    // //>//>print('(CH101)${chapterToLinkTo!.reference!.path!}++++${FFAppState().currentBody}');

    setState(() {});
    /*# await updateDocument(
        collection: chaptersRef,
        document: widget.chapter,
        data: {
          'body': FFAppState().currentBody,
          'modifiedTime': DateTime.now().toIso8601String(),
          'title': FFAppState().currentChapterTitle,
        });*/
    hasChanged = false;
    chapterHasBeenEdited = true;
    toast(
        context,
      'XX3',//  'Chapter "${FFAppState().currentChapterTitle}" of hyperbook "${localDB.getWorkingChapter()!.title}" saved',
        ToastKind.success);
    //£ String? token = await FirebaseMessaging.instance.getToken();
    //%//>//>print('(N401)${token}');
    // dV9wq9m2SC6NrV9Bz4P2rc:APA91bHWAukGfNCjwSrTT43G5iRw0r4QzwlhnjmglHF_Yk8r5WdeAELAp_kKpTeuZKTaM5abnbuk9WRRxsV_XqfkqC-4h5debTT916UNc7ciBpEagtdNkG4
  }

  Widget insertSavveButton() {
    return Padding(
      // key: intro!.keys[3],
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: FlutterFlowTheme.of(context).alternate),
        onPressed: () async {
          await saveText();
        },
        child: Text('Save',
            style: TextStyle(color: FlutterFlowTheme.of(context).primaryColor)),
      ),
    );
  }


  Widget insertNewChapter() {
    //>//>print('(102A)${localDB.getWorkingChapter()!.authorDisplayName}');
    return Padding(
        // key: intro!.keys[6],
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 150,
              child: insertFormField(linkNewChapterControllerC, 'Link caption',
                  'If blank, the chapter title will be used'),
/*              textInputField(
                  context,
                  'Link caption',
                  'If blank, the chapter title will be used',
                  linkNewChapterController),*/
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 150,
                child: insertFormField(linkTonewChapterTitleControllerD,
                    'Title of new chapter', 'Enter title of new chapter')
                /* textInputField(context, 'Title of new chapter', 'Unknown',
                  newChapterTitleController),*/
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: FlutterFlowTheme.of(context).primaryColor),
                onPressed: () async {
                  if (linkTonewChapterTitleControllerD.text.length == 0){
                    toast(context, 'Please enter title for new chapter', ToastKind.warning);
                    return;
                  }
                        /*Map<String, dynamic> chaptersCreateData =
                      createChaptersRecordData(
                    title: newTitleController.text,
                    body: '',
                    author: currentUserReference,
                    xCoord:  random_data.randomDouble(kMinRandomXCoord, kMaxRandomXCoord),
                     yCoord: random_data.randomDouble(kMinRandomYCoord, kMaxRandomXCoord),
                    chapterSymbol: ' ',
                    awaitingApproval: false,
                    isStartChapter: false,
                    createdTime: DateTime.now(),
                    modifiedTime: DateTime.now(),
                  );*/
                        /*chapterToLinkTo = await createChapterX(
                    title: linkNewChapterController.text,
                    body: '',
                    author: currentUser!.reference,
                    xCoord: random_data.randomDouble(
                        kMinRandomXCoord, kMaxRandomXCoord),
                    yCoord: random_data.randomDouble(
                        kMinRandomYCoord, kMaxRandomXCoord),
                    createdTime: DateTime.now(),
                    modifiedTime: DateTime.now(),
                    parent: localDB.getWorkingHyperbook().reference,
                    authorDisplayName: currentUser!.displayName,
                  );*/

                        /*            await createReadReferenceX(
                      chapter: chapterToLinkTo!.reference,
                      hyperbook: localDB.getWorkingHyperbook().reference,
                      readStateIndex: kNotVisitedIndex,
                      xCoord: chapterToLinkTo!.xCoord,
                      yCoord: chapterToLinkTo!.yCoord,
                      parent: currentUser!.reference);*/
                        /*  DocumentReference doc =
                      ChaptersRecord.createDoc(FFAppState().currentHyperbook!);
                  await doc.set(chaptersCreateData);*/

                        /*#await updateDocument(
                      collection: chaptersRef,
                      document: widget.chapter,
                      data: {
                        'body': await hTMLController.getText(),
                        'modifiedTime': DateTime.now().toIso8601String(),
                        'title': FFAppState().currentChapterTitle,
                      });*/
                        //# invalidateHyperbookCache();
                        setState(() {});
                        context.pop();
                      },
                child: Text('Insert link to new chapter',
                    style: TextStyle(color: Colors.white))),
          ),
        ]));
  }

  Widget insertFormField(
      TextEditingController controller, String labelText, String hintText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Rubik',
              color: const Color(0xFF95A1AC),
            ),
        hintText: hintText,
        hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Rubik',
              color: const Color(0xFF95A1AC),
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFDBE2E7),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: FlutterFlowTheme.of(context).white,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Rubik',
            color: const Color(0xFF2B343A),
          ),
    );
  }

  Widget insertChangeTitle(String currentChapterTitle) {
    return Padding(
      // key: intro!.keys[4],
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 150,
                child: insertFormField(
                  newChapterTitleControllerA,
                  'New title',
                  currentChapterTitle,
                )
                // textInputField(context, 'New chapter title',
                //     FFAppState().currentChapterTitle, newChapterTitleController),
                ),
          ),
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: FlutterFlowTheme.of(context).primaryColor),
              //   FFButtonWidget(

              onPressed: () async {
                if (newChapterTitleControllerA.text.length == 0){
                  toast(context, 'Please enter new title for chapter', ToastKind.warning);
                  return;
                }
                //%//>//>print('(N80)${FFAppState().currentChapter}');
                FFAppState().currentChapterTitle =
                    newChapterTitleControllerA.text;
                /* final Map<String, dynamic> chaptersUpdateData =
                    createChaptersRecordData(
                  title: newTitleController.text,
                  // blurb: newBlurbControlle
                );*/
                print(
                    '(N81)${FFAppState().currentChapterTitle}%%%%%${FFAppState().currentChapter}');
                //await FFAppState().currentChapter!.update(chaptersUpdateData);


/*                await updateDocument(
                    collection: chaptersRef,
                    document: FFAppState().currentChapter,
                    data: {'title': newChapterTitleController.text});*/
                toast(
                    context,
                    'xx4',//'Chapter ${FFAppState().currentChapterTitle} of hyperbook ${localDB.getWorkingHyperbook().title} saved',
                    ToastKind.success);
                setState(() {});
                //%//>//>print('(N33)${controller.getText()}');
                context.pop();
              },
              child: Text('Change chapter title',
                  style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }

  Widget insertExistingChapterDropdown() {
    return Padding(
        // key: intro!.keys[5],
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
              width: 150,
              child: insertFormField(linkExistingChapterControllerB,
                  'Link caption', 'If blank, the chapter title will be used')
/*
            textInputField(
                context,
                'Link caption',
                'If blank, the chapter title will be used',
                linkExistingChapterController),*/
              ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: dropdownWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: FlutterFlowTheme.of(context).primaryColor),
              onPressed: () async {

                String linkText = linkExistingChapterControllerB.text;

                context.pop();
              },
              child: const Text('Insert link to existing chapter',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ]));
  }

  Widget insertImageButton() {
    return Padding(
        // key: intro!.keys[7],
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: FlutterFlowTheme.of(context).primaryColor),
          //   FFButtonWidget(
          onPressed: () async {
            const selectedMedia = null;
            if (selectedMedia != null) {
              final List<String> downloadUrls = <String>[];
              try {} finally {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                isMediaUploading = false;
              }
              if (downloadUrls.length == selectedMedia.length) {
                setState(() => uploadedFileUrl = downloadUrls.first);
              } else {
                setState(() {});
                return;
              }
            }

            /*£final Map<String, dynamic> usersUpdateData = createUsersRecordData(
            photoUrl: uploadedFileUrl,
          );*/
            //%//>//>print('(D700)$uploadedFileUrl');
            hTMLController.insertNetworkImage(uploadedFileUrl,
                filename: 'IMAGE');
          },
          child: const Text(
            'Insert Image',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController linkNewChapterControllerC = TextEditingController();
  TextEditingController linkExistingChapterControllerB =
      TextEditingController();
  TextEditingController newChapterTitleControllerA = TextEditingController();
  TextEditingController newBlurbController = TextEditingController();
  TextEditingController linkTonewChapterTitleControllerD =
      TextEditingController();

  Widget dropdownWidget() {
    List<DropdownMenuEntry<String>> listOfEntries = [];
    return PointerInterceptor(
        child: DropdownMenu(
      inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          constraints: BoxConstraints.tight(const Size.fromHeight(40)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
      //key: GlobalKey(),
      dropdownMenuEntries: listOfEntries,
      onSelected: ( value) {
        setState(() {
          print('AAT3');
        });
      },
    ));
  }

  Widget insertImageList(String chapterBody, Function setState) {
    imageWidgetList.clear();
    for (int i = 0; i < imageHtmlList.length; i++) {
      //>//>print('(MI70)${i}++++${imageHtmlList[i].float}');
      imageWidgetList.add(Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(imageHtmlList[i].filename ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textInputField(context, 'Width', '',
                          imageHtmlList[i].imageWidthTextEditingController!,
                          width: 70, height: 30),
                      textInputField(context, 'Height', '',
                          imageHtmlList[i].imageHeightTextEditingController!,
                          width: 70, height: 30),
                    ]),
                Text('Float'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ChoiceChip(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      showCheckmark: false,
                      selectedColor: FlutterFlowTheme.of(context).tertiary,
                      selected: (imageHtmlList[i].float == FloatEnum.none),
                      // height: kChickletHeight,
                      onSelected: (ok) {
                        imageHtmlList[i].float = FloatEnum.none;
                        setState(() {});
                      },
                      label: Text('Inline'),
                    ),
                    ChoiceChip(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      showCheckmark: false,
                      selectedColor: FlutterFlowTheme.of(context).tertiary,
                      selected: (imageHtmlList[i].float == FloatEnum.left),
                      // height: kChickletHeight,
                      onSelected: (ok) {
                        imageHtmlList[i].float = FloatEnum.left;
                        setState(() {});
                      },
                      label: Text('Left'),
                    ),
                    ChoiceChip(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      showCheckmark: false,
                      selectedColor: FlutterFlowTheme.of(context).tertiary,
                      selected: (imageHtmlList[i].float == FloatEnum.right),
                      // height: kChickletHeight,
                      onSelected: (ok) {
                        imageHtmlList[i].float = FloatEnum.right;
                        setState(() {});
                      },
                      label: Text('Right'),
                    ),
                  ],
                ),
              ]),
        ),
        Divider(height: 3, thickness: 3, color: Colors.black),
      ]));
    }
    //>//>print('(MI50)${imageWidgetList.length}');
    return Column(children: imageWidgetList);
  }

  printTemp() async {
    String t = await hTMLController.getText();
  }

  Widget insertInsertIcon() {
    List<DropdownMenuEntry<String>> listOfEntries = [];
    for (var key in kIconMapStandard.keys) {
      listOfEntries.add(DropdownMenuEntry(
        value: key,
        label: key,
      ));
    }
    return PointerInterceptor(
        child: DropdownMenu<String>(
      inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          constraints: BoxConstraints.tight(const Size.fromHeight(40)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
      //key: GlobalKey(),
      dropdownMenuEntries: listOfEntries,
      onSelected: (value) {
        setState(() {
          const String before =
              "<span style=\"font-family:'material-icons';font-size:30px;\">";
          const String after = "</span>";
          String iconString = before + value! + after;
          //>//>print('(N3930A)${iconString}');
          try {
            hTMLController.insertHtml(iconString);
          } on Exception catch (e) {
            //>//>print('(N3930B)${e}');
          }
          hTMLController.getText().then((text) {
            //>//>print('(N3930C)${text}');
          });
          //>//>print('(N3930D)');
        });
      },
    ));
  }

  Widget insertInsertRawHTMLFromCliboard() {
    return FFButtonWidget(
      tooltipMessage: 'Enter raw HTML',
      onPressed: () async {
        String rawHTML = '';
        rawHTML = await FlutterClipboard.paste();
        //>//>print('(CB1)${rawHTML}');
        hTMLController.insertHtml(rawHTML);
      },
      text: 'Enter HTML from clipboard',
      options: FFButtonOptions(
        width: 200.0,
        height: 50.0,
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: FlutterFlowTheme.of(context).primary,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Rubik',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
        elevation: 2.0,
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget textInputField(BuildContext context, String label, String hint,
      TextEditingController controller,
      {double width = 200, double height = 40}) {
    //%//>//>print('(D20)$label');
    return Container(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Overpass',
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
          hintText: hint,
          hintStyle: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Overpass',
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).warning,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: FlutterFlowTheme.of(context).white,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(
              5, 0, 10, 0) /*(16, 24, 0, 24)*/,
        ),
        style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Overpass',
              color: const Color(0xFF2B343A),
            ),
      ),
    );
  }

  Widget insertCancel() {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: FlutterFlowTheme.of(context).alternate),
        onPressed: () async {
          context.pop();
        },
        child: Text('Cancel',
            style:
                TextStyle(color: FlutterFlowTheme.of(context).primaryColor)));
  }

  void showSettingsDialog(String currentChapterTitle) async {
    String chapterBody = await hTMLController.getText();
    showDialog<String>(
        context: context,
        builder: (context) {
          bool chapterCreateRequested = false;
          //  return StatefulBuilder(builder: (context, setState) {
          return PointerInterceptor(
              child: AlertDialog(
                  title: Row(
                    children: [
                      Text('Editor controls'),
                      FlutterFlowIconButton(
                        tooltipMessage: 'Exit',
                        borderColor:
                            FlutterFlowTheme.of(context).primaryBtnText,
                        borderRadius: kAbbBarButtonSize / 2.0,
                        borderWidth: 1,
                        buttonSize: kAbbBarButtonSize,
                        icon: kIconCancel,
                        onPressed: () async {
                          context.pop();
                        },
                      ),
                    ],
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          insertChangeTitle(currentChapterTitle),
                          Divider(height: 3, thickness: 3, color: Colors.black),
                          insertExistingChapterDropdown(),

                          Divider(height: 3, thickness: 3, color: Colors.black),
                          // insertImageList(chapterBody),
                          insertNewChapter(),
                          Divider(height: 3, thickness: 3, color: Colors.black),

                          currentUser!.userLevel == kUserLevelSupervisor
                              ? insertInsertIcon()
                              : Container(),
                          currentUser!.userLevel == kUserLevelSupervisor
                              ? Divider(
                                  height: 3, thickness: 3, color: Colors.black)
                              : Container(),
                          currentUser!.userLevel == kUserLevelSupervisor
                              ? insertInsertRawHTMLFromCliboard()
                              : Container(),
                          currentUser!.userLevel == kUserLevelSupervisor
                              ? Divider(
                                  height: 3, thickness: 3, color: Colors.black)
                              : Container(),
                          insertCancel()
                          //  insertImageButton(),
                        ]),
                  )));
        });
  }

  Widget insertSettingsButton(String currentChapterTitle) {
    return FlutterFlowIconButton(
      tooltipMessage: 'Chapter settings',
      borderColor: FlutterFlowTheme.of(context).primaryBtnText,
      borderRadius: kAbbBarButtonSize / 2.0,
      borderWidth: 1,
      buttonSize: kAbbBarButtonSize,
      icon: kIconSettingsWhite,
      onPressed: () async {
        //%//>//>print('(D10-1)');
        showSettingsDialog(currentChapterTitle);
      },
    );
  }

  Widget insertImageEditorButton() {
    return FlutterFlowIconButton(
      tooltipMessage: 'Set width, height, etc. for images',
      borderColor: FlutterFlowTheme.of(context).primaryBtnText,
      borderRadius: kAbbBarButtonSize / 2.0,
      borderWidth: 1,
      buttonSize: kAbbBarButtonSize,
      icon: kIconImageWhite,
      onPressed: () async {
        //%//>//>print('(D10-1)');

        await populateImageHTMLList();

        String chapterBody = await hTMLController.getText();

        showDialog<String>(
            context: context,
            builder: (context) {
              bool chapterCreateRequested = false;
              return StatefulBuilder(builder: (context, setState) {
                //   child:
                return PointerInterceptor(
                  child: AlertDialog(
                      title: Text('Images editor'),
                      content: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FFButtonWidget(
                                  tooltipMessage: 'Change',
                                  onPressed: () async {
                                    //>//>print('(MI40)');
                                    bool changed = false;
                                    for (int i = 0;
                                        i < imageHtmlList.length;
                                        i++) {
                                      //  String imageString = imageHtmlList[i].htmlSegment!;
                                      double? newWidth = double.tryParse(
                                          imageHtmlList[i]
                                              .imageWidthTextEditingController
                                              .text);
                                      //>//>print('(MI41)${newWidth}');
                                      if (newWidth != null) {
                                        String newWidthString = newWidth
                                            .floor()
                                            .toDouble()
                                            .toString()
                                            .padLeft(4);
                                        //>//>print('(MI42)${newWidthString}%');

                                        imageHtmlList[i].htmlSegment =
                                            imageHtmlList[i]
                                                .htmlSegment!
                                                .replaceRange(
                                                    imageHtmlList[i]
                                                            .widthStartPos +
                                                        6,
                                                    imageHtmlList[i]
                                                            .widthStartPos +
                                                        10,
                                                    newWidthString);
                                        print(
                                            '(MI43)${imageHtmlList[i].widthStartPos}****${imageHtmlList[i].heightStartPos}++++${imageHtmlList[i].htmlSegment}');

                                        changed = true;
                                      }
                                      double? newHeight = double.tryParse(
                                          imageHtmlList[i]
                                              .imageHeightTextEditingController
                                              .text);
                                      if (newHeight != null) {
                                        String newHeightString = newHeight
                                            .floor()
                                            .toDouble()
                                            .toString()
                                            .padLeft(4);
                                        imageHtmlList[i].htmlSegment =
                                            imageHtmlList[i]
                                                .htmlSegment!
                                                .replaceRange(
                                                    imageHtmlList[i]
                                                            .heightStartPos +
                                                        7,
                                                    imageHtmlList[i]
                                                            .heightStartPos +
                                                        11,
                                                    newHeightString);
                                        changed = true;
                                      }
                                      FloatEnum float = imageHtmlList[i].float;
                                      int floatPos = imageHtmlList[i].floatPos;
                                      print(
                                          'MI90${floatPos}++++${float}----${floatPos}');
                                      /* if (floatPos != -1) {
                                        String floatString = imageHtmlList[i]
                                            .htmlSegment!
                                            .substring(floatPos, floatPos + 5);
                                        FloatEnum oldFloatValue =
                                            FloatEnum.none;
                                     */
                                      print(
                                          'MI91${floatPos}----${imageHtmlList[i].htmlSegment}');
                                      /*   switch (floatString) {
                                          case ' none':
                                          case '     ':
                                            oldFloatValue = FloatEnum.none;
                                            break;
                                          case ' left':
                                            oldFloatValue = FloatEnum.left;
                                            break;
                                          case ' right':
                                            oldFloatValue = FloatEnum.right;
                                            break;
                                          default:
                                            oldFloatValue = FloatEnum.none;
                                            break;
                                        }
                                     */
                                      // if (oldFloatValue !=
                                      //     imageHtmlList[i].float) {
                                      String newFloatString = ' none';
                                      switch (float) {
                                        case FloatEnum.none:
                                          newFloatString = ' none';
                                          break;
                                        case FloatEnum.left:
                                          newFloatString = ' left';
                                          break;
                                        case FloatEnum.right:
                                          newFloatString = 'right';
                                          break;
                                      }
                                      imageHtmlList[i].htmlSegment =
                                          imageHtmlList[i]
                                              .htmlSegment!
                                              .replaceRange(
                                                  imageHtmlList[i].floatPos + 6,
                                                  imageHtmlList[i].floatPos +
                                                      11,
                                                  newFloatString);
                                      changed = true;

                                      print(
                                          '(MI80)${float}++++${floatPos}&&&&${imageHtmlList[i].htmlSegment}');
                                    }
                                    String newEditorText = preImageHtml;
                                    for (int i = 0;
                                        i < imageHtmlList.length;
                                        i++) {
                                      newEditorText = newEditorText +
                                          kImageTag +
                                          imageHtmlList[i].htmlSegment!;
                                      //>//>print('(MI45)${newEditorText}}');
                                    }
                                    hTMLController.clear();
                                    hTMLController.insertHtml(newEditorText);
                                    setState(() {});
                                    //>//>print('(MI46)${newEditorText}}');
                                    context.pop();
                                  },
                                  text: 'Change',
                                  options: FFButtonOptions(
                                    width: 100.0,
                                    height: 50.0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8.0, 8.0, 8.0, 8.0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Rubik',
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    elevation: 2.0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              Divider(
                                  height: 3, thickness: 3, color: Colors.black),
                              insertImageList(chapterBody, setState),
                              insertCancel()
                              //  insertImageButton(),
                            ]),
                      )),
                );
              });
            });
      },
    );
  }

  bool _hasFocus = false;
  void setHtmlText(String text) async {
    // await quillController.setText(text);
  }

  Future<void> populateImageHTMLList() async {
    String chapterBody = await hTMLController.getText();
    List<String> imageStrings = chapterBody.split(kImageTag);
    preImageHtml = imageStrings[0];
    imageHtmlList.clear();
    for (int i = 1; i < imageStrings.length; i++) {
      String imageString = imageStrings[i];
      //>//>print('(MI12)${imageString}');
      final int startFilenamePos =
          imageString.indexOf(kStorageFilenameStartString);
      //>//>print('(MI13)${startFilenamePos}');
      final int endFilenamePos = imageString.indexOf(kStorageFilenameEndString);
      //>//>print('(MI14)${endFilenamePos}');
      final String filename =
          imageString.substring(startFilenamePos + 2, endFilenamePos);
      //>//>print('(MI15)${filename}');
      imageFilenameList.add(filename);
      final int widthStartPos = imageString.indexOf('width:');
      String widthString = '';
      int widthEndPos = -1;
      if (widthStartPos != -1) {
        widthEndPos = widthStartPos + 10;
        widthString = imageString.substring(widthStartPos + 6, widthEndPos);
        //>//>print('(MI16)$widthStartPos&$widthEndPos+$widthString?');
      }
      final int heightStartPos = imageString.indexOf('height:');
      String heightString = '';
      int heightEndPos = -1;
      if (heightStartPos != -1) {
        heightEndPos = heightStartPos + 11;
        heightString = imageString.substring(heightStartPos + 7, heightEndPos);
        //>//>print('(MI16)$heightStartPos+$heightString?');
      }
      final int floatPos = imageString.indexOf('float:');
      String floatString = imageString.substring(floatPos + 6, floatPos + 11);
      FloatEnum float = FloatEnum.none;
      switch (floatString) {
        case ' none':
        case '     ':
          float = FloatEnum.none;
          break;
        case ' left':
          float = FloatEnum.left;
          break;
        case 'right':
          float = FloatEnum.right;
          break;
        default:
          float = FloatEnum.none;
          break;
      }
      imageHtmlList.add(ImageHtmlValues(
        widthStartPos: widthStartPos,
        // widthEndPos: widthEndPos,
        width: double.tryParse(widthString),
        imageWidthTextEditingController: TextEditingController(),
        heightStartPos: heightStartPos,
        // heightEndPos: heightEndPos,
        height: double.tryParse(heightString),
        imageHeightTextEditingController: TextEditingController(),
        filename: filename,
        htmlSegment: imageString,
        float: float,
        floatPos: floatPos,
      ));
      imageHtmlList.last.imageWidthTextEditingController.text = widthString;
      imageHtmlList.last.imageHeightTextEditingController.text = heightString;
      //>//>print('(MI99A)${floatPos}++++${floatString}^^^^${float}');
    }
    for (var x in imageHtmlList)
      print(
          '(MI60)${x.filename}****${x.widthStartPos}++++${x.widthStartPos + 4}====${x.width}@@@@${x.floatPos}');
  }

/*  FutureOr<bool> imageCaptor(*/ /*PlatformFile*/ /* PlatformFile, String insertFileType) async {
    //>//>print('(IC1)${PlatformFile.runtimeType}++++${insertFileType}');
    //String? url = await createStorageImageFile(user: currentUser!.reference, path: PlatformFile.path,  name: platformFile.name, bytes: platformFile.bytes! );
    ////>//>print('(IC2)${url}');
    return false;
  }*/

  // QuillEditorController quillController = QuillEditorController();

  late HtmlToolbarOptions smallScreenHtmlToolbarOptions = HtmlToolbarOptions(
    toolbarPosition: ToolbarPosition.aboveEditor,
    toolbarType: ToolbarType.nativeScrollable,
    defaultToolbarButtons: [
      StyleButtons(style: true),
      FontSettingButtons(
        fontName: false,
        fontSize: true,
        fontSizeUnit: false,
      ),
      ColorButtons(foregroundColor: true, highlightColor: true),
      ListButtons(
        ul: false,
        ol: false,
        listStyles: false,
      ),
      ParagraphButtons(
        caseConverter: false,
        alignCenter: false,
        alignJustify: false,
        alignLeft: false,
        alignRight: false,
        increaseIndent: false,
        decreaseIndent: false,
        textDirection: false,
        lineHeight: false,
      ),
      InsertButtons(
        picture: true,
        hr: false,
        table: true,
        link: false,
        audio: false,
        video: false,
        otherFile: false,
      ),
      OtherButtons(
        codeview: false,
        undo: false,
        redo: false,
        help: false,
        fullscreen: false,
      ),
    ],
    mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
      //>//>print('(MI1A)');
      print(file.name); //filename
      print(file.size); //size in bytes
      print(file.extension); //file extension (eg jpeg or mp4)
      //#setCurrentCachedChapterIndex(chapter: widget.chapter!);
      // DocumentReference chapter = localDB.getWorkingChapter()!.reference!;
      /*#   cachedHyperbookList[currentCachedHyperbookIndex!]
              .chapterList[currentCachedChapterIndex!]
              .reference!;*/
      String? url = await createStorageImageFile(
          chapter: null,
          user: currentUser!.reference,
          path: '',
          name: file.name,
          bytes: file.bytes!);
      //>//>print('(MI2)${url}');
      final String imageHTML =
          //        '<img style="width:    px;height:    px;float:     ;border:10px solid grey;border-radius:20px;padding: 10px;/*${file.name}*/" src="${url}">';
          '<img style="width: 50%; border: 2px solid; box-shadow: black 5px 5px 8px, grey 10px 10px 8px, grey 15px 15px 8px; margin: 20px 10px 20px 20px; padding: 0px;;/*${file.name}*/" src="${url}">';
      hTMLController.insertHtml(imageHTML);
      //>//>print('(MI3)${imageHTML}');
      return false;
    },
  );
//<h1>Hello</h1>
  late HtmlToolbarOptions largeScreenHtmlToolbarOptions = HtmlToolbarOptions(
    toolbarPosition: ToolbarPosition.aboveEditor,
    toolbarType: ToolbarType.nativeGrid,
    defaultToolbarButtons: [
      StyleButtons(style: true),
      FontSettingButtons(
        fontName: true,
        fontSize: true,
        fontSizeUnit: false,
      ),
      ColorButtons(foregroundColor: true, highlightColor: true),
      ListButtons(
        ul: true,
        ol: true,
        listStyles: false,
      ),
      ParagraphButtons(
        caseConverter: false,
      ),
      InsertButtons(
        table: true,
        link: false,
        audio: false,
        video: false,
        otherFile: false,
      ),
      OtherButtons(
        help: false,
        fullscreen: false,
      )
    ],
    mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
      //>//>print('(MI1A)');
      print(file.name); //filename
      print(file.size); //size in bytes
      print(file.extension); //file extension (eg jpeg or mp4)
      //# setCurrentCachedChapterIndex(chapter: widget.chapter!);

      // DocumentReference chapter = localDB.getWorkingChapter()!.reference!;
      /*cachedHyperbookList[currentCachedHyperbookIndex!]
              .chapterList[currentCachedChapterIndex!]
              .reference!;*/
      String? url = await createStorageImageFile(
          chapter: null,
          user: currentUser!.reference,
          path: '',
          name: file.name,
          bytes: file.bytes!);
      //>//>print('(MI2)${url}');
      final String imageHTML =
          '<img style="width:    px;height:    px;float:     ;border:10px solid grey;border-radius:20px;padding: 10px;/*${file.name}*/" src="${url}">';
      hTMLController.insertHtml(imageHTML);
      //>//>print('(MI3)${imageHTML}');
      return false;
    },
  );

  @override
  Widget build(BuildContext context) {
    /*#currentCachedHyperbookIndex =
        getCurrentCachedHyperbookIndex(hyperbook: widget.hyperbook!);
    */ //# setCurrentCachedChapterIndex(chapter: widget.chapter!);
    // //>//>print('(CC1)${currentCachedChapterIndex}....${localDB.getWorkingChapter().body}');
    MenuDetails chapterEditMenuDetails = MenuDetails(menuLabelList: [
      'Login',
      'Hyperbook list',
      'Map',
      'Editor controls',
      'Chapter list',
      'Save',
    ], menuIconList: [
      kIconLogin,
      kIconHyperbooks,
      kIconHyperbookMap,
      kIconSettings,
      kIconList,
      kIconSave,
    ], menuColorList: [
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
      kDefaultColor,
    ], menuTargets: [
      (context) {
        // context.goNamedAuth('login', context.mounted);
        Navigator.push(
            context,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: LoginWidget(),
            ));
      },
      (context) {
        // context.goNamedAuth('hyperbook_display', context.mounted);
        Navigator.push(
            context!,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: HyperbookDisplayWidget(),
            ));
      },
      (context) {
        /*context.pushNamed(
          'map_display',
          queryParameters: <String, String?>{
            'hyperbook': serializeParam(
              widget.hyperbook,
              ParamType.DocumentReference,
            ),
            'hyperbookTitle': serializeParam(
              widget.hyperbookTitle,
              ParamType.String,
            ),
            'hyperbookBlurb': serializeParam(
              widget.hyperbookBlurb,
              ParamType.String,
            ),
          }.withoutNulls,
        );*/
        Navigator.push(
            context!,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: LoginWidget(),
            ));
      },
      (context) {
        showSettingsDialog(titleController.text);
      },
      (context) {
        //>//>print('(PN1)');
/*        context.pushNamed(
          'chapter_display',
          queryParameters: <String, String?>{
            'hyperbook': serializeParam(
              widget.hyperbook,
              ParamType.DocumentReference,
            ),
            'hyperbookTitle': serializeParam(
              widget.hyperbookTitle,
              ParamType.String,
            ),
            'hyperbookBlurb': serializeParam(
              widget.hyperbookBlurb,
              ParamType.String,
            ),
          }.withoutNulls,
        );*/
        Navigator.push(
            context!,
            PageTransition(
              type: kStandardPageTransitionType,
              duration: kStandardTransitionTime,
              reverseDuration: kStandardReverseTransitionTime,
              child: ChapterDisplayWidget(),
            ));
      },
      (context) async {
        //>//>print('(PN2)');
        await saveText();
      }
    ]);

    AppBar appBar = AppBar(
      leading: BackButton(
          color: Colors.white,
          onPressed: () async {
            if (hasChanged) {
              //>//>print('(PH2)');
              bool? confirmDialogResponse = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext alertDialogContext) {
                    return StatefulBuilder(builder: (context, setState) {
                      return PointerInterceptor(
                          child: AlertDialog(
                              title: Text('Save modified text?'),
                              content: Text(''),
                              actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, true),
                              child: const Text('Confirm'),
                            ),
                          ]));
                    });
                  });
              if (confirmDialogResponse!) {
                //>//>print('(PH3)');
                await saveText();
              }
              //Navigator.pop(context, true);
            }
            Navigator.pop(context, true);
          }),
      backgroundColor: FlutterFlowTheme.of(context).primary,
      title: Text(
        'Edit: ' +
            /*# cachedHyperbookList[currentCachedHyperbookIndex!]
                .chapterList[currentCachedChapterIndex!]
                .title!,*/
            'XXX6',
        style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Rubik',
              color: Colors.white,
              fontSize: 22.0,
              fontStyle: FontStyle.italic,
            ),
      ),
      actions: <Widget>[
        /*  IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              if (kIsWeb) {
                hTMLController.reloadWeb();
              } else {
                hTMLController.editorController!.reload();
              }
            }),*/
/*
        FlutterFlowIconButton(
          key: intro!.keys[0],
          tooltipMessage: 'Click to see list of chapters',
          borderColor: FlutterFlowTheme.of(context).primaryBtnText,
          borderRadius: kAbbBarButtonSize / 2.0,
          borderWidth: 1,
          buttonSize: kAbbBarButtonSize,
          //icon: kIconHyperbookMapWhite,
          icon: kIconListWhite,
          onPressed: () async {
            context.pushNamed(
              'chapter_display',
              queryParameters: <String, String?>{
                'hyperbook': serializeParam(
                  widget.hyperbook,
                  ParamType.DocumentReference,
                ),
                'hyperbookTitle': serializeParam(
                  widget.hyperbookTitle,
                  ParamType.String,
                ),
                'hyperbookBlurb': serializeParam(
                  widget.hyperbookBlurb,
                  ParamType.String,
                ),
              }.withoutNulls,
            );
          },
        ),
        FlutterFlowIconButton(
          key: intro!.keys[1],
          tooltipMessage: 'Click to see hyperbook map',
          borderColor: FlutterFlowTheme.of(context).primaryBtnText,
          borderRadius: kAbbBarButtonSize / 2.0,
          borderWidth: 1,
          buttonSize: kAbbBarButtonSize,
          icon: kIconHyperbookMapWhite,
          onPressed: () async {
            //%//>//>print('(N1101)${widget.hyperbookTitle}');
            context.pushNamed(
              'map_display',
              queryParameters: <String, String?>{
                'hyperbook': serializeParam(
                  widget.hyperbook,
                  ParamType.DocumentReference,
                ),
                'hyperbookTitle': serializeParam(
                  widget.hyperbookTitle,
                  ParamType.String,
                ),
                'hyperbookBlurb': serializeParam(
                  widget.hyperbookBlurb,
                  ParamType.String,
                ),
              }.withoutNulls,
            );
          },
        ),
        insertSettingsButton(
            currentCachedChapterList[currentCachedChapterIndex!].title!),
        // insertImageEditorButton(),
*/
        insertMenu(context, chapterEditMenuDetails, setState),
        //insertSaveButton(),
/*        InkWell(
          onTap: () async {
            //  //%//>//>print('(XI5)${intro!.stepCount}');
            intro!.start(context);
          },
          child: kIconInfoStartWhite,
        ),*/
      ],
      centerTitle: false,
      elevation: 2.0,
    );

    //>//>print('(D1)');
    // setHtmlText('This is some text');
    // FFAppState().currentChapter = localDB.getWorkingChapter()!.reference;
    // setCurrentCachedChapterIndex(chapter: widget.chapter!);
    // titleController.text = localDB.getWorkingChapter()!.title!;

    /*#cachedHyperbookList[currentCachedHyperbookIndex!]
        .chapterList[currentCachedChapterIndex!]
        .title!;*/
    //currentVisibleChapter = widget.chapter;
    double screenWidth = MediaQuery.sizeOf(context).width;
    // WidgetsBinding
    // .instance.platformDispatcher.views.first.physicalSize.width;
    // print(
    //     '(NE100)${screenWidth}||||${currentCachedChapterIndex};;;;${cachedHyperbookList[currentCachedHyperbookIndex!].chapterList[currentCachedChapterIndex!].title}????${cachedHyperbookList[currentCachedHyperbookIndex!].chapterList[currentCachedChapterIndex!].body}');

    //>//>print('(CH111)${hasJustLoaded}');
    // hTMLController.getText().then((value) {//>//>print('(CH112)${value}');});
   /* if (localDB.getWorkingChapter() == null) {
      toast(context, 'Error in Chapter selection', ToastKind.error);
    }*/
    return Title(
        title: 'chapterEdit',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
            onTap: () =>
                FocusScope.of(context).requestFocus(_model.unfocusNode),
            child: Scaffold(
                //  key: scaffoldKey,
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     //>//>print('(FAB1)');
                //     hTMLController.toggleCodeView();
                //   },
                //   child: Text(r'<\>',
                //       style:
                //           TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                // ),
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                appBar: appBar,
                body:
                    /*GestureDetector(
                  onTap: () {
                    if (!kIsWeb) {
                      controller.clearFocus();
                    }
                  },
                  child: */
                    SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                      HtmlEditor(
                        controller: hTMLController,
                        htmlEditorOptions: HtmlEditorOptions(
                          hint: 'Your text here...',
                          shouldEnsureVisible: true,
                          initialText:
                              /*# cachedHyperbookList[currentCachedHyperbookIndex!]
                                  .chapterList[currentCachedChapterIndex!]
                                  .body,*/
                           'XXX7',//   localDB.getWorkingChapter()!.body!,
                          autoAdjustHeight: true,
                          spellCheck: true,
                          // filePath: "assets/summernote.html",
                        ),
                        htmlToolbarOptions:
                            (screenWidth < kPhonewWidthThreashold)
                                ? smallScreenHtmlToolbarOptions
                                : largeScreenHtmlToolbarOptions,

                        /* HtmlToolbarOptions(
                          toolbarPosition: ToolbarPosition.aboveEditor,
                          toolbarType: ToolbarType.nativeGrid,
                          defaultToolbarButtons: [
                            StyleButtons(style: true),
                            FontSettingButtons(
                              fontName: true,
                              fontSize: true,
                              fontSizeUnit: false,
                            ),
                            ColorButtons(
                                foregroundColor: true, highlightColor: true),
                            ListButtons(
                              ul: true,
                              ol: true,
                              listStyles: false,
                            ),
                            ParagraphButtons(
                              caseConverter: false,
                            ),
                            InsertButtons(
                              table: false,
                              link: false,
                              audio: false,
                              video: false,
                              otherFile: false,
                            ),
                            OtherButtons(
                              help: false,
                              fullscreen: false,
                            )
                          ],*/

                        otherOptions: OtherOptions(
                            height: MediaQuery.of(context).size.height -
                                appBar.preferredSize.height),
                        callbacks: Callbacks(
                          onEnter: () {
                            if (hasJustLoaded) {
                              hTMLController.clear();
                             /* hTMLController.insertHtml(
                                  localDB.getWorkingChapter()!.body!);*/
                              hasJustLoaded = false;
                            }
                            //>//>print('(CH114)${hasJustLoaded}');
                          },
                          onBeforeCommand: (String? currentHtml) {
                            //%//>//>print('html before change is $currentHtml');
                          },
                          onChangeContent: (String? changed) async {
                            // if (await hTMLController.getText() !=
                                /*#    cachedHyperbookList[
                                        currentCachedHyperbookIndex!]
                                    .chapterList[currentCachedChapterIndex!]
                                    .body*/
                         /*       localDB.getWorkingChapter()!.body!) {
                              // print(
                              //     '(PH1)$changed****${await hTMLController.getText()}++++${currentCachedChapterList[currentCachedChapterIndex!].body}');
                              hasChanged = true;
                              print('(IU9)${changed}');
                            }*/
                          },

                            onImageLinkInsert:(String? link){
                             print('(IU6)${link}');
                            },
                            onImageUpload: (FileUpload? file){
                              if (file != null) {
                                print('(IU2)${file.name}');
                                print('(IU3)${file.size}');
                                print('(IU4)${file.type}');
                              } else {
                                print('(IU5)');
                              }
                            },
                          onImageUploadError: (FileUpload? file,
                              String? base64Str, UploadError error) {
                            print('(IU1)${describeEnum(error)}');
                            print(base64Str ?? '');
                            if (file != null) {
                              //%print(file.name);
                              //%print(file.size);
                              //%print(file.type);
                            }
                          },
                          onNavigationRequestMobile: (String url) {
                            //%print(url);
                            return NavigationActionPolicy.ALLOW;
                          },
                        ),
                      ),
                    ])))));
  }
}

enum FloatEnum { none, left, right }

class ImageHtmlValues {
  int widthStartPos;
  // int widthEndPos = -1;
  double? width;
  TextEditingController? imageWidthTextEditingController;
  int heightStartPos;
  // int heightEndPos = -1;
  double? height;
  TextEditingController? imageHeightTextEditingController;
  String? filename;
  String? htmlSegment;
  FloatEnum float;
  int floatPos;

  ImageHtmlValues({
    this.widthStartPos = -1,
    // this.widthEndPos = -1,
    this.width,
    this.imageWidthTextEditingController,
    this.heightStartPos = -1,
    // this.heightEndPos = -1,
    this.height,
    this.imageHeightTextEditingController,
    this.filename,
    this.htmlSegment,
    this.float = FloatEnum.none,
    this.floatPos = -1,
  });
}
