// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

// import '../../auth/base_auth_user_provider.dart';
// import '../../auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'permissions.dart';
import 'package:hyperbook/hyperbook_display/hyperbook_display_widget.dart';
import 'package:hyperbook/appwrite_interface.dart';

// List<ChaptersRecord> chapterList1 = [];
//List<ReadReferencesRecord> readReferenceList1 = [];

class GetHyperbooks extends StatefulWidget {
  const GetHyperbooks({
    super.key,
  //  this.width,
  //  this.height,
   // this.hyperbook,
 //  this.user,
  //  this.drawMapWhenComplete,
  //  this.hyperbookTitle,
  //  this.editHtmlWhenComplete,
  //  this.body,
  //  this.chapter,
  //  this.chapterTitle,
  //  this.isIntroductionMap,
    // this.approvedHyperbookReads,
    // this.approvedHyperbookCollaborates,
  //  this.moderator,
  });

  //final double? width;
  //final double? height;
 // final DocumentReference? hyperbook;
  //final DocumentReference? user;
 // final bool? drawMapWhenComplete;
 // final String? hyperbookTitle;
 // final bool? editHtmlWhenComplete;
 // final String? body;
 // final DocumentReference? chapter;
 // final String? chapterTitle;
 // final bool? isIntroductionMap;
  // final List<DocumentReference>? approvedHyperbookReads;
  // final List<DocumentReference>? approvedHyperbookCollaborates;
  //final DocumentReference? moderator;

  @override
  _GetHyperbooksState createState() => _GetHyperbooksState();
}
/*£*/
List<ReadReferencesRecord> readReferenceList = [];
/*£*/

Future<List<HyperbooksRecord>> populateHyperbooksAndReadReferences(
    DocumentReference? user) async {
  //UsersRecord currentUser= await UsersRecord.getDocumentOnce(user!);

  hyperbookList.clear();
 //~ cachedHyperbookList.clear();

  //£hyperbookList = await queryHyperbooksRecordOnce();

  for (HyperbooksRecord hyperbook in hyperbookList){
     List<ConnectedUsersRecord> connectedUsers = [];
    /*£await queryConnectedUsersRecordOnce(
      parent: hyperbook.reference,
    //  queryBuilder: (Query<Object?> ConnectedUsersRecord) =>
    //      ConnectedUsersRecord.where('user', isEqualTo: currentUserReference),
    );*/
   /*£ if(connectedUsers.length > 0){
      cachedHyperbookList.add(CachedHyperbook(hyperbook, connectedUsers.first, connectedUsers));
    } else {
      cachedHyperbookList.add(CachedHyperbook(hyperbook, null, []));
    }*/

  }
  //updateReadReferences(hyperbook, chapterList, true);
  readReferenceList.clear();
  //£readReferenceList = await queryReadReferencesRecordOnce(parent: user);

  //%//>//>print('(N87A-0)$hyperbookList');
  //%//>//>print('(N87A-1)$readReferenceList');
  return hyperbookList;
}

class _GetHyperbooksState extends State<GetHyperbooks> {
  @override
  Widget build(BuildContext context) {
   //%//>//>print('(N800)${currentUser}');
//    //%//>//>print('(D200-2)%${widget.hyperbook}&$currentHyperbook+$kRWA1@');
//    //%//>//>print('(D502-1)${widget.chapter}');
    return FutureBuilder<void>(
        future:
        populateHyperbooksAndReadReferences(currentUser!.reference),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          //>//>print('(NB1)');
          if (snapshot.hasData) {
                //%//>//>print('(N600-1)${currentUserReference}');
                return HyperbookDisplayWidget();
         } else {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            );
          }
        });
  }
}
