import 'appwrite_interface.dart';
import 'app_state.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'custom_code/widgets/permissions.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:hyperbook/appwrite_interface.dart';

/*
class HyperbookLocalDB {
  HyperbookLocalDB({this.hyperbook});

  HyperbooksRecord? hyperbook;
  List<ChaptersRecord> chapterList = [];
  List<ReadReferencesRecord> readReferenceList = [];
  List<ConnectedUsersRecord> connectedUserList = [];
  int? workingChapterIndex;
  int? workingReadReferenceIndex;
  int? workingConnectedUserIndex;
}
*/

/*
class LocalDB {
  List<HyperbookLocalDB> hyperbooklocalDBList = [];
  int? workingHyperbookIndex;
  bool hyperbooklocalDBValid = false;

  int getHyperbookLocalDBlength() {
    return hyperbooklocalDBList.length;
  }

  List<HyperbooksRecord> getHyperbookList() {
    List<HyperbooksRecord> hList = [];
    for (int i = 0; i < getHyperbookLocalDBlength(); i++) {
      hList.add(hyperbooklocalDBList[i].hyperbook!);
    }
    return hList;
  }

  Future<void> loadLocalDB({required DocumentReference? user}) async {
    // if (hyperbooklocalDBValid) return;
    hyperbooklocalDBList.clear();
    print('(N13A)${workingHyperbookIndex}');
    // appwriteDatabases = Databases(client!);

    List<HyperbooksRecord> hh = await listHyperbookList();
    //>print('(N13B)${hh.length}');
    for (int i = 0; i < hh.length; i++) {
      hyperbooklocalDBList.add(HyperbookLocalDB(hyperbook: hh[i]));
      hyperbooklocalDBList[i].chapterList =
          await listChaptersList(parent: hh[i].reference);
      hyperbooklocalDBList[i].readReferenceList =
          await listReadReferencsList(hyperbook: hh[i].reference, parent: user);
      hyperbooklocalDBList[i].connectedUserList =
          await listConnectedUsersList(parent: hh[i].reference, user: null);

      //>print('(N71P)${hyperbooklocalDBList.length}');
    }
    if (hyperbooklocalDBList.isNotEmpty) {
      workingHyperbookIndex = 0;
      hyperbooklocalDBValid = true;
    }
  }

  int? getHyperbookIndex(DocumentReference hyperbook) {
    for (int i = 0; i < hyperbooklocalDBList.length; i++) {
      if (hyperbooklocalDBList[i].hyperbook!.reference!.path ==
          hyperbook.path) {
        return i;
      }
    }
    return null;
  }
*/

/*
  HyperbookLocalDB getHyperbookLocalDBFromHyperbook(
      DocumentReference hyperbook) {
    return localDB.hyperbooklocalDBList[localDB.getHyperbookIndex(hyperbook)!];
  }

  HyperbooksRecord getHyperbooksRecordFromReference(
      DocumentReference hyperbook) {
    int? hyperbookIndex = getHyperbookIndex(hyperbook);
    return hyperbooklocalDBList[hyperbookIndex!].hyperbook!;
  }

  Future<void> setWorkingHyperbookAndConnectedUser(
      {required DocumentReference? hyperbook,
      required DocumentReference? user}) async {
    workingHyperbookIndex = getHyperbookIndex(hyperbook!);
    hyperbooklocalDBList[workingHyperbookIndex!].workingConnectedUserIndex =
        null;
    for (int i = 0;
        i <
            hyperbooklocalDBList[workingHyperbookIndex!]
                .connectedUserList
                .length;
        i++) {
      if ((hyperbooklocalDBList[workingHyperbookIndex!]
                  .connectedUserList[i]
                  .parent!
                  .path ==
              hyperbook!.path) &&
          (hyperbooklocalDBList[workingHyperbookIndex!]
                  .connectedUserList[i]
                  .user!
                  .path ==
              user!.path)) {
        hyperbooklocalDBList[workingHyperbookIndex!].workingConnectedUserIndex =
            i;
      }
    }
    if (hyperbooklocalDBList[workingHyperbookIndex!]
            .workingConnectedUserIndex ==
        null) {
      HyperbooksRecord h = getWorkingHyperbook();
      int connectedUserIndex = await createLocalDBConnectedUserReturnIndex(
        hyperbook: hyperbook,
        user: currentUser!.reference,
        role: h.nonMemberRole,
        displayName: currentUser!.displayName,
        requesting: '',
        nodeSize: kDefaultNodeSize,
      );
      hyperbooklocalDBList[workingHyperbookIndex!].workingConnectedUserIndex =
          connectedUserIndex;
      //>print('(CU210)${workingHyperbookIndex}....${connectedUserIndex}');
    }
  }

  HyperbookLocalDB getWorkingHyperbookLocalDB() {
    return hyperbooklocalDBList[workingHyperbookIndex!];
  }

  HyperbooksRecord getWorkingHyperbook() {
    return hyperbooklocalDBList[workingHyperbookIndex!].hyperbook!;
  }

  Future<void> setTutorialAsWorkingHyperbook() async {
    for (int i = 0; i < hyperbooklocalDBList.length; i++) {
      //>print('<SU2>${hyperbooklocalDBList[i].hyperbook!.title}');
      if (hyperbooklocalDBList[i].hyperbook!.title == 'Hyperbook Tutorial') {
        // workingHyperbookIndex = i;
        await setWorkingHyperbookAndConnectedUser(
            hyperbook: hyperbooklocalDBList[i].hyperbook!.reference,
            user: currentUser!.reference);
        //>print(
        //> '<SU3>${i}++++${hyperbooklocalDBList[i].hyperbook!.reference!.path}');
        break;
      }
    }
  }

  HyperbooksRecord hyperbookFromIndex(int? i) {
    return hyperbooklocalDBList[i!].hyperbook!;
  }

  HyperbooksRecord workingHyperbook() {
    return hyperbookFromIndex(workingHyperbookIndex);
  }

  List<ChaptersRecord> getChapterList(DocumentReference hyperbook) {
    return hyperbooklocalDBList[getHyperbookIndex(hyperbook)!].chapterList;
  }

  List<ChaptersRecord> workingChapterList() {
    return hyperbooklocalDBList[workingHyperbookIndex!].chapterList;
  }

  Future<void> setWorkingChapter(DocumentReference? chapter) async {
    if (chapter == null) {
      getWorkingHyperbookLocalDB().workingChapterIndex = null;
      return;
    }

    for (int i = 0; i < getWorkingHyperbookLocalDB().chapterList.length; i++) {
      //>   print(
      //>   '<WC1>${chapter.path}????${i}....${getWorkingHyperbookLocalDB().chapterList.length}====${workingHyperbookIndex}');
      if (getWorkingHyperbookLocalDB().chapterList[i].reference!.path! ==
          chapter.path) {
        getWorkingHyperbookLocalDB().workingChapterIndex = i;
        getReadReferenceFromChapter(
            chapter: chapter, user: currentUser!.reference);
        return;
      }
    }
  }

  int? getWorkingChapterIndex() {
    return localDB.getWorkingHyperbookLocalDB().workingChapterIndex;
  }

  ChaptersRecord? getWorkingChapter() {
    ChaptersRecord? c;
    try {
      c = hyperbooklocalDBList[workingHyperbookIndex!].chapterList[
          hyperbooklocalDBList[workingHyperbookIndex!].workingChapterIndex!];
    } catch (e) {
      //>print('(EE1)${e}');
     // throw(e);
      return null;
    }
    return c;
  }

  List<ChaptersRecord> getWorkingChapterList() {
    return hyperbooklocalDBList[workingHyperbookIndex!].chapterList;
  }

  List<ReadReferencesRecord> getReadReferenceList(DocumentReference hyperbook) {
    return hyperbooklocalDBList[getHyperbookIndex(hyperbook)!]
        .readReferenceList;
  }

  Future<void> setWorkingReadReference(DocumentReference? readReference) async {
    //>print('(WC100)${readReference}');
    DocumentReference? localReadReference = readReference;
    if (readReference == null) {
      */
/* localReadReference = await localDB.createLocalDBReadReference(chapter: localDB.getWorkingChapter()!.reference,
          hyperbook: localDB.getWorkingHyperbook().reference,
          readStateIndex: kNotVisitedIndex,
          xCoord: localDB.getWorkingChapter()!.xCoord,
          yCoord: localDB.getWorkingChapter()!.yCoord,
          parent: currentUser!.reference);*//*


      //>print('(WC101ERROR)${localDB.getWorkingChapter()!.reference!.path}');
      return;
    }
    for (int i = 0;
        i < getWorkingHyperbookLocalDB().readReferenceList.length;
        i++) {
      //>  print(
      //>     '(WC102)${i}....${getWorkingHyperbookLocalDB().readReferenceList.length}====${workingHyperbookIndex}....${getWorkingHyperbookLocalDB().readReferenceList[i].reference!.path}----${localReadReference!.path}');
      if (getWorkingHyperbookLocalDB().readReferenceList[i].reference!.path ==
          localReadReference!.path) {
        getWorkingHyperbookLocalDB().workingReadReferenceIndex = i;
        return;
      }
    }
  }

  ReadReferencesRecord? getWorkingReadReference() {
    ReadReferencesRecord? r;
    try {
      r = hyperbooklocalDBList[workingHyperbookIndex!].readReferenceList[
          hyperbooklocalDBList[workingHyperbookIndex!]
              .workingReadReferenceIndex!];
    } catch (e) {
      //>print('(EE2)${e}');
    }
    return r;
  }

  ChaptersRecord? getChapterRecordFromWorkingList(DocumentReference chapter) {
    for (int i = 0; i < getWorkingChapterList().length; i++) {
      if (getWorkingChapterList()[i].reference!.path == chapter!.path) {
        return getWorkingChapterList()[i];
      }
    }
    return null;
  }

  List<ReadReferencesRecord> getWorkingReadReferenceList() {
    return hyperbooklocalDBList[workingHyperbookIndex!].readReferenceList;
  }

  int? getReadReferenceIndex(DocumentReference readReference) {
    for (int i = 0; i < getWorkingReadReferenceList().length; i++) {
      if (getWorkingReadReferenceList()[i].reference!.path ==
          readReference.path) {
        return i;
      }
    }
    return null;
  }

  int? getConnectedUserIndex(DocumentReference connectedUser) {
    for (int i = 0;
        i < getConnectedUserList(getWorkingHyperbook().reference!).length;
        i++) {
      if (getConnectedUserList(getWorkingHyperbook().reference!)[i]
              .reference!
              .path ==
          connectedUser!.path) {
        return i;
      }
    }
    return null;
  }

  int? getWorkingConnectedUserIndex() {
    return localDB.getWorkingHyperbookLocalDB().workingConnectedUserIndex;
  }

  void setWorkingConnectedUserFromIndex(DocumentReference connectedUser) {
    for (int i = 0;
        i < getWorkingHyperbookLocalDB().connectedUserList.length;
        i++) {
      print(
          '<WC3>${connectedUser.path}????${i}....${getWorkingHyperbookLocalDB().connectedUserList.length}====${workingHyperbookIndex}');
      if (getWorkingHyperbookLocalDB().connectedUserList[i].reference!.path! ==
          connectedUser.path) {
        getWorkingHyperbookLocalDB().workingConnectedUserIndex = i;
        return;
      }
    }
  }

  void setWorkingConnectedUserFromHyperbook(
      {required DocumentReference? hyperbook,
      required DocumentReference? user}) {
    for (int i = 0;
        i < getWorkingHyperbookLocalDB().connectedUserList.length;
        i++) {
      print(
          '<WC4>${user!.path}????${i}....${getWorkingHyperbookLocalDB().connectedUserList.length}====${workingHyperbookIndex}');
      if ((getWorkingHyperbookLocalDB().connectedUserList[i].parent!.path ==
              hyperbook!.path) &&
          (getWorkingHyperbookLocalDB().connectedUserList[i].user!.path ==
              user!.path)) {
        getWorkingHyperbookLocalDB().workingConnectedUserIndex = i;
        print(
            '<WC5>${getWorkingHyperbookLocalDB().connectedUserList[i].reference!.path}????${i}');
        return;
      }
    }
  }

  ConnectedUsersRecord? getWorkingConnectedUser() {
    print('(CU1)${workingHyperbookIndex}');
    try {
    if (hyperbooklocalDBList[workingHyperbookIndex!]
            .workingConnectedUserIndex ==
        null) {
      return null;
    }
    }  */
/*on Exception*//*
 catch (e) {
      print('(CN1)${e}');
      return null;
    }
      hyperbooklocalDBList[workingHyperbookIndex!].workingConnectedUserIndex =
          hyperbooklocalDBList[workingHyperbookIndex!]
                  .connectedUserList
                  .length -
              1;
      //>print(
      //>  '(CU2)${hyperbooklocalDBList[workingHyperbookIndex!].connectedUserList.length}');

    //> print(
    //>  '(CU3)${hyperbooklocalDBList[workingHyperbookIndex!].connectedUserList.length}');
    return hyperbooklocalDBList[workingHyperbookIndex!].connectedUserList[
        hyperbooklocalDBList[workingHyperbookIndex!]
            .workingConnectedUserIndex!];
  }

  Future<ChaptersRecord> createLocalDBChapter({
    required String? title,
    required DocumentReference? hyperbook,
    String? body,
    double? xCoord,
    double? yCoord,
  }) async {
    ChaptersRecord createdChapter = await createChapterX(
      title: title,
      body: body ?? '',
      author: currentUser!.reference,
      xCoord: xCoord ??  random_data.randomDouble(kMinRandomXCoord, kMaxRandomXCoord),
      yCoord: yCoord ??  random_data.randomDouble(kMinRandomYCoord, kMaxRandomXCoord),
      createdTime: DateTime.now(),
      modifiedTime: DateTime.now(),
      parent: hyperbook,
      authorDisplayName: currentUser!.displayName,
    );
    int? hyperbookIndex = getHyperbookIndex(hyperbook!);
    print(
        '(CH12A)${hyperbooklocalDBList.length}++++${hyperbookIndex}====${hyperbooklocalDBList.length}');
    hyperbooklocalDBList[hyperbookIndex!].chapterList.add(createdChapter);
    print(
        '(CH12B)${hyperbooklocalDBList.length}++++${hyperbookIndex}====${hyperbooklocalDBList.length}');
    await createLocalDBReadReference(
        chapter: createdChapter.reference,
        hyperbook: hyperbook,
        readStateIndex: kNotVisitedIndex,
        xCoord: createdChapter.xCoord,
        yCoord: createdChapter.yCoord,
        parent: currentUser!.reference);
    return createdChapter;
  }

  Future<int> createLocalDBConnectedUserReturnIndex({
    DocumentReference? hyperbook,
    DocumentReference? user,
    String? role,
    String? displayName,
    String? requesting,
    DocumentReference? reference,
    double? nodeSize,
  }) async {
    int? hyperbookIndex = getHyperbookIndex(hyperbook!);
    //>print(
    //>   '(CU5)${hyperbookIndex}++++${hyperbooklocalDBList[hyperbookIndex!].connectedUserList.length}');

    ConnectedUsersRecord cu;
    if (reference == null) {
      cu = await createConnectedUserX(
        user: user,
        status: role,
        displayName: displayName,
        requesting: '',
        parent: hyperbook,
        nodeSize: kDefaultNodeSize,
      );
    } else {
      cu = await createConnectedUserX(
        user: user,
        status: role,
        displayName: displayName,
        requesting: '',
        parent: hyperbook,
        nodeSize: kDefaultNodeSize,
        id: reference.path!,
      );
    }
    ConnectedUsersRecord createdConnectedUser = ConnectedUsersRecord(
      reference: cu.reference,
      user: user,
      status: role,
      displayName: displayName,
      requesting: '',
      parent: hyperbook,
      nodeSize: nodeSize ?? kDefaultNodeSize,
    );
    hyperbooklocalDBList[hyperbookIndex!]
        .connectedUserList
        .add(createdConnectedUser);
    //>print(
    //>   '(CU6)${hyperbooklocalDBList[hyperbookIndex!].connectedUserList.length}');
    return hyperbooklocalDBList[hyperbookIndex!].connectedUserList.length - 1;
  }

  Future<DocumentReference> createLocalDBReadReference({
    required DocumentReference? chapter,
    required DocumentReference? hyperbook,
    required int? readStateIndex,
    required double? xCoord,
    required double? yCoord,
    required DocumentReference? parent,
    */
/*required*//*
 DocumentReference? reference,
  }) async {
    int? hyperbookIndex = getHyperbookIndex(hyperbook!);
    //> print(
    //>   '(CH50)${hyperbookIndex}++++${hyperbooklocalDBList[hyperbookIndex!].connectedUserList.length}');

    ReadReferencesRecord? rr;
    if (reference == null) {
      rr = await createReadReferenceX(
        chapter: chapter,
        hyperbook: hyperbook,
        readStateIndex: readStateIndex,
        xCoord: xCoord,
        yCoord: yCoord,
        parent: parent,
      );
    } */
/*else {
      // rr = await createReadReferenceX(
      //   chapter: chapter,
      //   hyperbook: hyperbook,
      //   readStateIndex: readStateIndex,
      //   xCoord: xCoord,
      //   yCoord: yCoord,
      //   parent: parent,
      //   id: reference.path!,
      // );
    }*//*

    ReadReferencesRecord createdReadReference = ReadReferencesRecord(
      reference: rr!.reference,
      chapter: chapter,
      hyperbook: hyperbook,
      readStateIndex: readStateIndex,
      xCoord: xCoord,
      yCoord: yCoord,
      parent: parent,
    );
    hyperbooklocalDBList[hyperbookIndex!]
        .readReferenceList
        .add(createdReadReference);
    //>print('(CH51)${rr}....${createdReadReference.reference!.path}');
    return createdReadReference.reference!;
  }

  Future<HyperbookLocalDB> createLocalDBHyperbook(String title) async {
    HyperbooksRecord createdHyperbook = await createHyperbook(
      moderator: currentUser!.reference,
      title: title,
      blurb: '',
      startChapter: DocumentReference(path: '0'),
      nonMemberRole: kRoleNone,
      moderatorDisplayName: currentUser!.displayName,
      createdTime: DateTime.now(),
      modifiedTime: DateTime.now(),
    );
    //>print('(CH16)${createdHyperbook.title}');
    localDB.dumpLocalDB();
    HyperbookLocalDB hyperbookLocalDB =
        HyperbookLocalDB(hyperbook: createdHyperbook);
    hyperbooklocalDBList.add(hyperbookLocalDB);
    int? hyperbookIndex =
        localDB.getHyperbookIndex(createdHyperbook.reference!);

    //>  print(
    //>   '(CH17)${hyperbookIndex}>>>>${hyperbooklocalDBList.length}<<<<${hyperbooklocalDBList.last.hyperbook!.title}');
    localDB.dumpLocalDB();
    await createLocalDBChapter(
        title: 'Introduction', hyperbook: createdHyperbook.reference);
    //>print('(CH18)${hyperbooklocalDBList.length}');

    ChaptersRecord startChapter =
        hyperbooklocalDBList[hyperbookIndex!].chapterList.last;
    int connectedUserIndex = await createLocalDBConnectedUserReturnIndex(
        hyperbook: createdHyperbook!.reference,
        user: currentUser!.reference,
        role: kRoleModerator,
        displayName: currentUser!.displayName);
    int hyperbookIndex2 = getHyperbookIndex(createdHyperbook.reference!)!;
    localDB.dumpLocalDB();
    //>print('(CH19)${hyperbooklocalDBList.length}....${connectedUserIndex}');
    await updateDocument(
      collection: hyperbooksRef,
      document: createdHyperbook!.reference,
      data: {
        kAttHyperbookStartChapter:
            //  hyperbooklocalDBList[hyperbookIndex].hyperbook!.reference!.path
            startChapter.reference!.path
      },
    );
    localDB.dumpLocalDB();
    //>  print(
    //>    '(CH19)${hyperbooklocalDBList[hyperbookIndex2].hyperbook!.startChapter!.path}&&&${createdHyperbook}');
    return hyperbookLocalDB;
  }

  List<String> getHyperbookStringList(String hsp) {
    // DocumentReference h = hyperbook ?? workingHyperbook().reference!;
    List<String> result = [];
    for (int i = 0; i < hyperbooklocalDBList.length; i++) {
      switch (hsp) {
        case kAttHyperbookReference:
          result.add(hyperbooklocalDBList[i].hyperbook!.reference!.path!);
          break;
        case kAttHyperbookModerator:
          result.add(hyperbooklocalDBList[i].hyperbook!.moderator!.path!);
          break;
        case kAttHyperbookTitle:
          result.add(hyperbooklocalDBList[i].hyperbook!.title!);
          break;
        case kAttHyperbookBlurb:
          result.add(hyperbooklocalDBList[i].hyperbook!.blurb!);
          break;
        case kAttHyperbookStartChapter:
          result.add(hyperbooklocalDBList[i].hyperbook!.startChapter!.path!);
          break;
        case kAttHyperbookNonMemberRole:
          result.add(hyperbooklocalDBList[i].hyperbook!.nonMemberRole!);
          break;
        case kAttHyperbookModeratorDisplayName:
          result.add(hyperbooklocalDBList[i].hyperbook!.moderatorDisplayName!);
          break;
        default:
          break;
      }
    }
    return result;
  }

  HyperbookLocalDB? selectHyperbookDB({String? hsp, String? param}) {
    List<String> paramList = getHyperbookStringList(hsp!);
    for (int i = 0; i < paramList.length; i++) {
      if (paramList[i] == param) {
        return hyperbooklocalDBList[i];
      }
    }
    return null;
  }

  Future<void> updateHyperbook({
    int? hyperbookIndex, //null if WorkingHyperbook
    String? hp,
    dynamic value,
    Function? contextualSetState,
  }) async {
    int i = hyperbookIndex ?? workingHyperbookIndex!;
    switch (hp) {
      case kAttHyperbookReference:
        hyperbooklocalDBList[i].hyperbook!.reference =
            value as DocumentReference;
        break;
      case kAttHyperbookModerator:
        hyperbooklocalDBList[i].hyperbook!
          ..moderator = value as DocumentReference;
        break;
      case kAttHyperbookTitle:
        hyperbooklocalDBList[i].hyperbook!.title = value as String;
        break;
      case kAttHyperbookBlurb:
        hyperbooklocalDBList[i].hyperbook!.blurb = value as String;
        break;
      case kAttHyperbookStartChapter:
        hyperbooklocalDBList[i].hyperbook!.startChapter!.path = value as String;
        break;
      case kAttHyperbookNonMemberRole:
        hyperbooklocalDBList[i].hyperbook!.nonMemberRole = value as String;
        break;
      case kAttHyperbookModeratorDisplayName:
        hyperbooklocalDBList[i].hyperbook!.moderatorDisplayName =
            value as String;
        break;
      default:
        break;
    }
    await updateDocument(
        collection: hyperbooksRef,
        document: hyperbooklocalDBList[i]!.hyperbook!.reference,
        data: {hp!: value});
    if (contextualSetState != null) {
      contextualSetState(() {});
      //>print('(CS1)');
    }
  }

*/
/*
  const kAttChapterReference = 'reference';
  const kAttChapterTitle = 'title';
  const kAttChapterBody = 'body';
  const kAttChapterAuthor = 'author';
  const kAttChapterXCoord = 'xCoord';
  const kAttChapterYCoord = 'yCoord';
  const kAttChapterParent = 'parent';
  const kAttChapterAuthorDisplayName = 'authorDisplayName';
*//*


  Future<void> updateChapter({
    int? hyperbookIndex, //null if WorkingHyperbook
    int? chapterIndex, //null if WorkingHyperbook
    required String? cp, // chapter attribute
    required dynamic value,
    required Function? contextualSetState,
  }) async {
    int i = hyperbookIndex ?? workingHyperbookIndex!;
    int j = chapterIndex ?? hyperbooklocalDBList[i].workingChapterIndex!;
    //>print('<LD11>${i}++++${j}====${cp}????${value}');
    switch (cp) {
      case kAttChapterReference:
        hyperbooklocalDBList[i].chapterList[j].reference =
            value as DocumentReference;
        break;
      case kAttChapterTitle:
        hyperbooklocalDBList[i].chapterList[j].title = value as String;
        break;
      case kAttChapterBody:
        hyperbooklocalDBList[i].chapterList[j].body = value as String;
        break;
      case kAttChapterAuthor:
        hyperbooklocalDBList[i].chapterList[j].author =
            value as DocumentReference;
        break;
      case kAttChapterXCoord:
        hyperbooklocalDBList[i].chapterList[j].xCoord = value as double;
        break;
      case kAttChapterYCoord:
        hyperbooklocalDBList[i].chapterList[j].yCoord = value as double;
        break;
      case kAttChapterParent:
        hyperbooklocalDBList[i].chapterList[j].parent =
            value as DocumentReference;
        break;
      case kAttChapterAuthorDisplayName:
        hyperbooklocalDBList[i].chapterList[j].authorDisplayName =
            value as String;
        break;
      default:
        break;
    }
    //>   print(
    //>    '<LD12>${i}++++${j}====${cp}????${value}||||${hyperbooklocalDBList[i].chapterList[j].body}');

    await updateDocument(
        collection: chaptersRef,
        document: hyperbooklocalDBList[i].chapterList[j].reference,
        data: {cp!: value});
    if (contextualSetState != null) {
      contextualSetState(() {});
      //>print('(CS1)');
    }
  }

  */
/*const kAttrReadReferenceReference = 'reference';
  const kAttrReadReferenceChapter = 'chapter';
  const kAttrReadReferenceHyperbook = 'hyperbook';
  const kAttrReadReferenceReadStateIndex = 'readStateIndex';
  const kAttrReadReferenceXCoord = ' xCoord';
  const kAttrReadReferenceYCoord = 'yCoord';
  const kAttrReadReferenceParent = 'parent';
  *//*


  Future<void> updateReadReference({
    int? hyperbookIndex, //null if WorkingHyperbook
    int? readReferenceIndex, //null if WorkingHyperbook
    String? rp, // chapter attribute
    dynamic value,
    Function? contextualSetState,
  }) async {
    int i = hyperbookIndex ?? workingHyperbookIndex!;
    int j = readReferenceIndex ?? hyperbooklocalDBList[i].workingChapterIndex!;
    print('<LD11A>${i}++++${j}====${rp}????${value}');
    print(
         '<LD11B>${hyperbooklocalDBList[i].readReferenceList[j].reference!.path}');
    switch (rp) {
      case kAttrReadReferenceReference:
        hyperbooklocalDBList[i].readReferenceList[j].reference =
            value as DocumentReference;
        break;
      case kAttrReadReferenceChapter:
        hyperbooklocalDBList[i].readReferenceList[j].chapter =
            value as DocumentReference;
        break;
      case kAttrReadReferenceHyperbook:
        hyperbooklocalDBList[i].readReferenceList[j].hyperbook =
            value as DocumentReference;
        break;
      case kAttrReadReferenceReadStateIndex:
        hyperbooklocalDBList[i].readReferenceList[j].readStateIndex =
            value as int;
        break;
      case kAttrReadReferenceXCoord:
        hyperbooklocalDBList[i].readReferenceList[j].xCoord = value as double;
        break;
      case kAttrReadReferenceYCoord:
        hyperbooklocalDBList[i].readReferenceList[j].yCoord = value as double;
        break;
      case kAttrReadReferenceParent:
        hyperbooklocalDBList[i].readReferenceList[j].parent =
            value as DocumentReference;
        break;
      default:
        break;
    }
    //>print('<LD13>${i}++++${j}====${rp}????${value}}');

    await updateDocument(
        collection: readReferencesRef,
        document: hyperbooklocalDBList[i].readReferenceList[j].reference,
        data: {rp!: value});
    if (contextualSetState != null) {
      contextualSetState(() {});
      print('(CS1)');
    }
  }

*/
/*
  const kAttConnectedUserReference = 'reference';
  const kAttConnectedUserUser = 'user';
  const kAttConnectedUserStatus = 'status';
  const kAttConnectedUserDisplayName = 'displayName';
  const kAttConnectedUserRequesting = 'requesting';
  const kAttConnectedUserParent = 'parent';
  const kAttConnectedUserNodeSize = 'nodeSize';
*//*


  Future<void> updateConnectedUser({
    int? hyperbookIndex, //null if WorkingHyperbook
    int? connectedUserIndex, //null if WorkingConnectedIndex
    String? cp, // chapter attribute
    dynamic value,
    Function? contextualSetState,
  }) async {
    int i = hyperbookIndex ?? workingHyperbookIndex!;
    int j = connectedUserIndex ??
        hyperbooklocalDBList[i].workingConnectedUserIndex!;
    print(
        '<LD11>${i}++++${j}====${cp}????${value}||||${hyperbooklocalDBList[i].connectedUserList[j].reference!.path}');
    switch (cp) {
      case kAttConnectedUserReference:
        hyperbooklocalDBList[i].connectedUserList[j].reference =
            value as DocumentReference;
        break;
      case kAttConnectedUserUser:
        hyperbooklocalDBList[i].connectedUserList[j].user =
            value as DocumentReference;
      // case kAttConnectedUserStatus:
      case kAttConnectedUserStatus:
        hyperbooklocalDBList[i].connectedUserList[j].status = value as String;
      case kAttConnectedUserDisplayName:
        hyperbooklocalDBList[i].connectedUserList[j].displayName =
            value as String;
      case kAttConnectedUserRequesting:
        hyperbooklocalDBList[i].connectedUserList[j].requesting =
            value as String;
      case kAttConnectedUserParent:
        hyperbooklocalDBList[i].connectedUserList[j].parent =
            value as DocumentReference;
      case kAttConnectedUserNodeSize:
        hyperbooklocalDBList[i].connectedUserList[j].nodeSize = value as double;
      default:
        break;
    }
      print(
         '<LD14>${i}++++${j}====${cp}????${value}||||${hyperbooklocalDBList[i].connectedUserList[j].reference!.path}');

    await updateDocument(
        collection: connectedUsersRef,
        document: hyperbooklocalDBList[i].connectedUserList[j].reference,
        data: {cp!: value});
    if (contextualSetState != null) {
      contextualSetState(() {});
      //>print('(CS1)');
    }
  }

  List<ConnectedUsersRecord> getConnectedUserList(DocumentReference hyperbook) {
    int hyperbookIndex = getHyperbookIndex(hyperbook)!;
    return hyperbooklocalDBList[hyperbookIndex].connectedUserList;
  }

  ConnectedUsersRecord? getConnectedUserFromHyperbookAndUser(
  {DocumentReference? hyperbook,
    DocumentReference? user,}) {
    int hyperbookIndex = getHyperbookIndex(hyperbook!)!;
    List<ConnectedUsersRecord> cul = getHyperbookLocalDBFromHyperbook(hyperbook).connectedUserList;
    for(ConnectedUsersRecord cu in cul){
      if(cu.user!.path == user!.path){
        return cu;
      }
    }
    return null;
  }


  */
/*void updateChapter({
    int? HyperbookIndex, //null if WorkingHyperbook
    int? ChapterIndex, //null if WorkingChapter

  }){

  }*//*


  Future<void> updateDocument({
    DocumentReference? collection,
    DocumentReference? document,
    Map<String, dynamic>? data,
  }) async {
    Schema schema = Schema.none;
    if (collection == hyperbooksRef) {
      schema = Schema.hyperbook;
      int hyperbookIndex = getHyperbookIndex(document!)!;
      data!.forEach((k, v) {
        //>print('<WC3>${k}>>>>${v}');
        switch (v) {
          case 'title':
        }
      });
    } else {
      if (collection == chaptersRef) {
        schema = Schema.chapter;
      } else {
        if (collection == readReferencesRef) {
          schema = Schema.readReference;
        } else {
          if (collection == connectedUsersRef) {
            schema = Schema.connectedUser;
          } else {
            if (collection == usersRef) {
              schema = Schema.user;
            }
          }
        }
      }
    }

    appwriteDatabases = Databases(client!);
    //>print('(N2011C)${data}////${collection!.path}++++${document!.path}');
    models.Document doc = await appwriteDatabases!.updateDocument(
      databaseId: databaseRef.path!,
      collectionId: collection!.path!,
      documentId: document!.path!,
      data: data,
    );
  }

  dumpLocalDB() {
    //>print('(LD_hyperbookWorkingIndex)${workingHyperbookIndex}');
    //>print('(LD_hyperbookChapterIndex)${getWorkingChapterIndex()}');
    //>print('(LD_hyperbookChapter)${getWorkingChapter()}');
    if (getWorkingChapter() != null) {
      //>print('(LD_hyperbookChapterPath)${getWorkingChapter()!.reference!.path}');
    }
    //>print('(LD_ReadReference)${getWorkingReadReference()}');
    if (getWorkingReadReference() != null) {
      //>  print(
      //>   '(LD_ReadReferencePath)${getWorkingReadReference()!.reference!.path}');
    }
    //>print('(LD_length)${hyperbooklocalDBList.length}');
    for (int i = 0; i < hyperbooklocalDBList.length; i++) {
      //>print('(LD_hyperbook)${i},${hyperbooklocalDBList[i].hyperbook!.title}');
      //>print('(LD_Chapters)${i},${hyperbooklocalDBList[i].chapterList.length}');
      //>   print(
      //>       '(LD_ReadReferences)${i},${hyperbooklocalDBList[i].readReferenceList.length}');
      //>    print(
      //>       '(LD_ConnectedUsers)${i},${hyperbooklocalDBList[i].chapterList.length}');
    }
  }

  Future<void> setupWorkingChapter({
    required DocumentReference? chapterReference,
  }) async {
    await setWorkingChapter(chapterReference!);
    DocumentReference? localReadReference = getReadReferenceFromChapter(
        chapter: getWorkingChapter()!.reference,
        user: currentUser!.reference);
    print(
        '(DT2X)${getWorkingChapter()!.reference}....${localReadReference}----${getWorkingChapter()!.reference!.path}');
    if (localReadReference == null) {
      localReadReference = await createLocalDBReadReference(
          chapter: chapterReference,
          hyperbook: localDB.getWorkingHyperbook().reference,
          readStateIndex: kNotVisitedIndex,
          xCoord: localDB.getWorkingChapter()!.xCoord,
          yCoord: localDB.getWorkingChapter()!.yCoord,
          parent: currentUser!.reference);
    }
    //>  print(        '(DT2Y)${localReadReference};;;;${getWorkingChapter()!.reference}....${localReadReference}----${getWorkingChapter()!.reference!.path}');
    setWorkingReadReference(localReadReference);
  }


}



enum Schema {
  none,
  hyperbook,
  chapter,
  readReference,
  connectedUser,
  user,
}

enum HyperbookParameters {
  none,
  reference,
  moderator,
  title,
  blurb,
  startChapter,
  nonMemberRole,
  moderatorDisplayName,
}
*/

const kAttHyperbookReference = 'reference';
const kAttHyperbookModerator = 'moderator';
const kAttHyperbookTitle = 'title';
const kAttHyperbookBlurb = 'blurb';
const kAttHyperbookStartChapter = 'startChapter';
const kAttHyperbookNonMemberRole = 'nonMemberRole';
const kAttHyperbookModeratorDisplayName = 'moderatorDisplayName';

const kDBid = '\$id';
const kDBcreatedAt = '\$createdAt';
const kDBupdatedAt = '\$updatedAt';
const kSessionClientId = 'clientId';
const kSessionTherapistId = 'therapistId';
const kSessionStepPhoto= 'photo';
const kSessionStepAudio= 'audio';
const kSessionStepCompleted= 'completed';
const kSessionStepTranscription= 'transcription';
const kSessionStepIndex= 'index';
const kUserEmail = 'email';
const kUserDisplayName = 'displayName';
const kUserPhoneNumber = 'phoneNumber';
const kUserUserMessage = 'userMessage';
const kUserRole = 'role';

/*
const Map<String, HyperbookParameters> kHyperbookParametersMap = {
  kAttHyperbookReference: HyperbookParameters.reference,
  kAttHyperbookModerator: HyperbookParameters.moderator,
  kAttHyperbookTitle: HyperbookParameters.title,
  kAttHyperbookBlurb: HyperbookParameters.blurb,
  kAttHyperbookStartChapter: HyperbookParameters.startChapter,
  kAttHyperbookNonMemberRole: HyperbookParameters.nonMemberRole,
  kAttHyperbookModeratorDisplayName: HyperbookParameters.moderatorDisplayName,
};

const Map<HyperbookParameters, String> kHyperbookParametersMapReverse = {
  HyperbookParameters.reference: kAttHyperbookReference,
  HyperbookParameters.moderator: kAttHyperbookModerator,
  HyperbookParameters.title: kAttHyperbookTitle,
  HyperbookParameters.blurb: kAttHyperbookBlurb,
  HyperbookParameters.startChapter: kAttHyperbookStartChapter,
  HyperbookParameters.nonMemberRole: kAttHyperbookNonMemberRole,
  HyperbookParameters.moderatorDisplayName: kAttHyperbookModeratorDisplayName,
};*/

const kAttChapterReference = 'reference';
const kAttChapterTitle = 'title';
const kAttChapterBody = 'body';
const kAttChapterAuthor = 'author';
const kAttChapterXCoord = 'xCoord';
const kAttChapterYCoord = 'yCoord';
const kAttChapterParent = 'parent';
const kAttChapterAuthorDisplayName = 'authorDisplayName';

/*
const Map<ChapterParameters, String> kHyperbookParametersMapReverse = {
  HyperbookParameters.reference: kAttHyperbookReference,
  HyperbookParameters.moderator: kAttHyperbookModerator,
  HyperbookParameters.title: kAttHyperbookTitle,
  HyperbookParameters.blurb: kAttHyperbookBlurb,
  HyperbookParameters.startChapter: kAttHyperbookStartChapter,
  HyperbookParameters.nonMemberRole: kAttHyperbookNonMemberRole,
  HyperbookParameters.moderatorDisplayName: kAttHyperbookModeratorDisplayName,
};
*/

const kAttrReadReferenceReference = 'reference';
const kAttrReadReferenceChapter = 'chapter';
const kAttrReadReferenceHyperbook = 'hyperbook';
const kAttrReadReferenceReadStateIndex = 'readStateIndex';
const kAttrReadReferenceXCoord = 'xCoord';
const kAttrReadReferenceYCoord = 'yCoord';
const kAttrReadReferenceParent = 'parent';

const kAttConnectedUserReference = 'reference';
const kAttConnectedUserUser = 'user';
const kAttConnectedUserStatus = 'status';
const kAttConnectedUserDisplayName = 'displayName';
const kAttConnectedUserRequesting = 'requesting';
const kAttConnectedUserParent = 'parent';
const kAttConnectedUserNodeSize = 'nodeSize';

const kAttrUserReference = 'reference';
const kAttrUserEmail = 'email';
const kAttrUserDisplayName = 'displayName';
const kAttrUserCreatedTime = 'createdTime';
const kAttrUserPhoneNumber = 'phoneNumber';
const kAttrUserChapterColorInts = 'chapterColorInts';
const kAttrUserUserReference = 'userReference';
const kAttrUserUserLevel = 'userLevel';
const kAttrUserUserMessage = 'userMessage';

const kAttrBackupHyperbookLocalDB = 'hyperbookLocalDB';
const kAttrBackupUsers = 'hyperbookUsers';
const kAttrBackupHyperbook = 'hyperbook';
const kAttrBackupConnectedUserList = 'connectedUserList';
const kAttrBackupChapterList = 'chapterList';
