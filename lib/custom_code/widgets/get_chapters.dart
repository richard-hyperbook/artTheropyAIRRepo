// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

// import '../../auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'permissions.dart';
import 'package:hyperbook/appwrite_interface.dart';
// import 'package:hyperbook/custom_code/widgets/draw_map3.dart';

// List<ChaptersRecord> chapterList1 = [];
// List<ReadReferencesRecord> readReferenceList1 = [];

class GetChaptersOLD extends StatefulWidget {
  const GetChaptersOLD({
    super.key,
    this.width,
    this.height,
    this.hyperbook,
    this.user,
    this.drawMapWhenComplete,
    this.hyperbookTitle,
    this.editHtmlWhenComplete,
    this.body,
    this.chapter,
    this.chapterTitle,
    this.isIntroductionMap,
    // this.approvedHyperbookReads,
    // this.approvedHyperbookCollaborates,
    this.moderator,
    required this.hyperbookBlurb,
  });

  final double? width;
  final double? height;
  final DocumentReference? hyperbook;
  final DocumentReference? user;
  final bool? drawMapWhenComplete;
  final String? hyperbookTitle;
  final bool? editHtmlWhenComplete;
  final String? body;
  final DocumentReference? chapter;
  final String? chapterTitle;
  final bool? isIntroductionMap;
  // final List<DocumentReference>? approvedHyperbookReads;
  // final List<DocumentReference>? approvedHyperbookCollaborates;
  final DocumentReference? moderator;
  final String? hyperbookBlurb;

  @override
  _GetChaptersStateOLD createState() => _GetChaptersStateOLD();
}

Future<List<ChaptersRecord>> populateChaptersAndReadReferences(
    DocumentReference? hyperbook, DocumentReference? user) async {

  HyperbooksRecord currentHyperbook = await getHyperbook(document: hyperbook!);
//  setCachedHyperbookAndChapterList(hyperbook);
  chapterList.clear();
  //%//>//>print('(D210-1)$hyperbook%${FFAppState().introductionHyperbook}');
  chapterList = await listChaptersList(parent: hyperbook);

  // updateReadReferences(hyperbook, chapterList, true);
  // readReferenceList.clear();
  // readReferenceList = await queryReadReferencesRecordOnce(parent: user);
  // connectedUsersList.clear();
  // readReferenceList = await queryReadReferencesRecordOnce(parent: user);
  connectedUsersList.clear();
  // connectedUsersList = await queryConnectedUsersRecordOnce(parent: hyperbook);
  currentConnectedUsersRecord = null;
  for(ConnectedUsersRecord connectedUser in connectedUsersList){
    // if(connectedUser.user == currentUserReference){
    //   currentConnectedUsersRecord = connectedUser;
    //   break;
    // }
  }

  //+//%//>//>print('(C87A-0)$chapterList');
  //+//%//>//>print('(C87A-1)$readReferenceList');
  return chapterList;
  return [];
}
/*
const kVH0 = 'No';
const kVH1 = 'Yes';
const kRRA0 = 'No readers';
const kRRA1 = 'Yes';
const kRRA2 = 'No';
const kCRA0 = 'No collaborators';
const kCRA1 = 'Each chapter';
const kCRA2 = 'Yes';
const kCRA3 = 'No';
*/

class _GetChaptersStateOLD extends State<GetChaptersOLD> {
  @override
  Widget build(BuildContext context) {
    //%print(
    //  '(D200)${widget.hyperbook}%${widget.drawMapWhenComplete}+${widget.editHtmlWhenComplete}');
    //%//>//>print('(D200-2)%${widget.hyperbook}&$currentHyperbook+$kRWA1@');
    //%//>//>print('(D502-1)${widget.chapter}');
    return FutureBuilder<void>(
        future:
            populateChaptersAndReadReferences(localDB.getWorkingHyperbook().reference,/*#widget.hyperbook*/ currentUser!.reference/*#widget.user*/),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          bool approvedToRead = false;
          //%//>//>print('(D876-0)$connectedUsersList^${connectedUsersList.length}');
          if (connectedUsersList.isNotEmpty) {
            for (int i = 0; i < connectedUsersList.length; i++) {
              //  //%//>//>print('(D876-0A)$connectedUsersList^$i');
              if (connectedUsersList[i].user == widget.user) {
                if (connectedUsersList[i].status != '') {
                  approvedToRead = true;
                  break;
                }
              }
            }
          } else {
           /*£ createConnectedUsersRecord(
              role: kRoleReader,
              hyperbook: widget.hyperbook,
              user: currentUserReference,
              displayName: currentUserDisplayName,
            );*/
          }
          // //%//>//>print('(D876-1)$currentHyperbook^$widget*${widget.user}');
          bool okToRead = true;
          /*£if ((currentHyperbook != null) &&
              (currentHyperbook!.requiresReaderApproval != null) &&
              (widget.moderator != null) &&
              (widget.user != null)) {
            //    //%//>//>print('(D876-1A)$currentHyperbook^$widget*${widget.user}');
            okToRead = (approvedToRead &&
                        (currentHyperbook!.requiresReaderApproval == kRRA1) ||
                    (currentHyperbook!.requiresReaderApproval == kRRA2)) ||
                (widget.user == widget.moderator);
          }*/
          const bool approvedToWrite = true;
          // if (true /*widget.approvedHyperbookReads != null*/) {
          //   approvedToCollaborate = widget.approvedHyperbookCollaborates!
          //       .contains(widget.hyperbook);
          // }
          //   //%//>//>print('(D876-2)$currentHyperbook^$widget*${widget.user}');
          bool okToWrite = true;
          /*£if ((currentHyperbook != null) &&
              (currentHyperbook!.requiresWriterApproval != null) &&
              (widget.moderator != null) &&
              (widget.user != null)) {
            //   //%//>//>print('(D876-2A)$currentHyperbook^$widget*${widget.user}');
            okToWrite = (approvedToWrite &&
                        (currentHyperbook!.requiresWriterApproval == kRWA1) ||
                    (currentHyperbook!.requiresWriterApproval == kRWA2)) ||
                (widget.user == widget.moderator);
          }*/
          //   //%//>//>print('(D876-3)$currentHyperbook^$widget*${widget.user}');
          if (snapshot.hasData) {
            areChaptersLoaded = true;
            if (widget.drawMapWhenComplete!) {
              if (okToRead) {
                //>//>print('(D200-1)${widget.hyperbook}');
                return Text('REMOVED');
              } else {
                return const Center(child: Text('Access denied'));
              }
            }
            //%//>//>print('(D502-2)${widget.hyperbookTitle}');
            if (widget.editHtmlWhenComplete!) {
              if (okToWrite) {
                return HtmlEditorClass(
                  title: widget.chapterTitle,
                  chapter: widget.chapter,
                  body: widget.body,
                  hyperbook: widget.hyperbook,
                  hyperbookTitle: widget.hyperbookTitle,
                  hyperbookBlurb: widget.hyperbookBlurb,

                );
              }
              //%//>//>print('(D502-3)${widget.hyperbook}@${widget.hyperbookTitle}');
            } else {
              return const Center(child: Text('Access denied'));
            }
            // Backup hyperbook
            /*£return BackupHyperbookClass(
                hyperbook: widget.hyperbook,
                hyperbookTitle: widget.hyperbookTitle);*/
          } else {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            );
          }
        });
  }
}
