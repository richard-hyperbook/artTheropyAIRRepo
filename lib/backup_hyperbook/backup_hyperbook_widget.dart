import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '/auth/firebase_auth/auth_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'backup_hyperbook_model.dart';
import '../../appwrite_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

export 'backup_hyperbook_model.dart';

class BackupHyperbookWidget extends StatefulWidget {
  const BackupHyperbookWidget({
    super.key,
    this.hyperbook,
    this.hyperbookTitle,
  });

  final DocumentReference? hyperbook;
  final String? hyperbookTitle;

  @override
  _BackupHyperbookWidgetState createState() => _BackupHyperbookWidgetState();
}

class _BackupHyperbookWidgetState extends State<BackupHyperbookWidget> {
  late BackupHyperbookModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BackupHyperbookModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Title(
        title: 'backup_hyperbook',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              leading: BackButton(
                  color: Colors.white
              ),
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              title: Text(

                'Backup Hyperbook',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Rubik',
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 300.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: Text('BACKUP')
                        /*custom_widgets.GetChapters(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        drawMapWhenComplete: false,
                        hyperbookTitle: widget.hyperbookTitle,
                        editHtmlWhenComplete: false,
                        body: ' ',
                        chapterTitle: ' ',
                        isIntroductionMap: false,
                        hyperbook: widget.hyperbook,
                        user: currentUser!.reference,
                      )*/,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
