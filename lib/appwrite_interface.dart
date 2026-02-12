//import 'dart:js_interop';

//import 'dart:js_interop';

// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'dart:math';
import 'package:date_format/date_format.dart';
import '/flutter_flow/custom_functions.dart' as functions;

import 'app_state.dart';
import 'custom_code/widgets/get_hyperbooks.dart';
import 'custom_code/widgets/permissions.dart';

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../custom_code/widgets/toast.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import '/custom_code/actions/index.dart' as actions;
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/random_data_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'localDB.dart';
import '../hyperbook_display/hyperbook_display_widget.dart';
import 'dart:async';
// import 'dart:html' as html show window;
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:web/web.dart';
import 'package:universal_html/html.dart' as html;

// part 'appwrite_interface.g.dart';

const String _numericChars = '1234567890';
Random _numericRnd = Random();

String getRandomNumericString(int length) => String.fromCharCodes(
    Iterable.generate(
        length,
        (_) => _numericChars
            .codeUnitAt(_numericRnd.nextInt(_numericChars.length))));

/*
//localhost
const endpoint = 'http://localhost/v1';
const project = '67cd5b6e000fe41c331e';
const DocumentReference databaseRef = DocumentReference(
  path: '67cd5e2c0011a37a550c',
);
const DocumentReference hyperbooksRef = DocumentReference(
  path: '67d25aaf003d6b9507b6',
);
const DocumentReference connectedUsersRef = DocumentReference(
  path: '67d26456000deb78fa6a',
);
const DocumentReference chaptersRef = DocumentReference(
  path: '67d260ec0037564b2569',
);
const DocumentReference aaMilneUserRef = DocumentReference(
  path: '67cdf1e76e9881bd3a5c',
);


 */
//intelvid.co.uk

late Timer timer;
const endpoint = 'https://fra.cloud.appwrite.io/v1';
const project = '696ddda6001b28f2352e';
const devKey =
    '4de99514ee3d5a8fb3cdf236ba66a91e9bdb37c8397f9f98542530bd2f6a71797d93b068276fc23c0aba27cbd1e41912d4362456a9a167150bc5a2d66265b86a94229cfaf7d63181b173898e5f322b28f4d1c9a6c3470fa129f933062428ceb4806c26ca5bfa8e91d7e88f8dcbc430d1eb864016906a31d0dd78bf6a9450794d';
const imageFilenameHead = endpoint + '/storage/buckets';

final DocumentReference databaseRef = DocumentReference(
  path: '698c8fce0029ddaaecdb',
);
final DocumentReference sessionStepsRef = DocumentReference(
  path: 'sessionsteps',
);
final DocumentReference sessionsRef = DocumentReference(
  path: 'sessions',
);
final DocumentReference usersRef = DocumentReference(
  path: 'users',
);
final DocumentReference backupStorageRef = DocumentReference(
  path: '680746de003983073d29',
);
final DocumentReference artTheopyAIRphotosRef = DocumentReference(
  path: '698c93550005c8307b67',
);
final DocumentReference artTheopyAIRaudiosRef = DocumentReference(
  path: '698c93a00006c743c31f',
);
final DocumentReference constraintsRef = DocumentReference(
  path: '',
);

// LocalDB localDB = LocalDB();

UsersRecord? currentUser;
String currentUserDisplayName = '';
String currentUserEmail = '';

RealtimeSubscription? hyperbookDisplaySubscription;
RealtimeSubscription? hyperbookEditSubscription;
RealtimeSubscription? chapterChapterSubscription;
RealtimeSubscription? chapterReadReferenceSubscription;
List<String> chapterSubscriptionStringList = [];
List<String> readReferenceSubscriptionStringList = [];
// RealtimeSubscription? drawMapPageChapterSubscription;
// RealtimeSubscription? drawMapPageReadReferenceSubscription;

const databaseId = 'default';
const bucketId = 'testBucket';
const collectionId = 'usernames';

const double kPhonewWidthThreashold = 650;
const double kIntroductionChapterXCoord = 50.1;
const double kIntroductionChapterYCoord = 100.2;
const double kMinRandomXCoord = 20;
const double kMinRandomYCoord = 20;
const double kMaxRandomXCoord = 300;
const double kMaxRandomYCoord = 300;
const double zoomChangeMultiplyer = 1.1;

const String kStorageFilenameSpitString = '_';
const String kStorageFilenameStartString = '/*';
const String kStorageFilenameEndString = '*/';

const double kChickletHeight = 40;
const double kHeightMapTitle = 50;

const double kMapPreferenceButtonWidth = 100;
const double kNodeButtonWidth = 40;
const double kMapNodeBorderWidth = 5;
const int kMaxBlurbLengthOnMap = 50;

const String kMessageSpitCharacter = '~';

const double kStateSelectorWidthFactor = 0.8;
const double kStateSelectorHeight = 35.0;

Random random = Random();
Client? client;
Databases? appwriteDatabases;
String result = 'XXX';
List<Map<String, dynamic>> items = [];
Account? account;
models.User? loggedInUser;
bool loggedIn = false;
bool hyperbookDisplayIsSubscribed = false;
bool hyperbookEditIsSubscribed = false;
bool chapterReadPageChapterAppIsSubscribed = false;
bool chapterReadPageReadReferenceAppIsSubscribed = false;
bool drawMapPageChapterAppIsSubscribed = false;
bool drawMapPageReadReferenceAppIsSubscribed = false;
bool isDrawingMap = false;
// DocumentReference chapterClicked = DocumentReference(path: '');
bool resetPasswordCommandRecived = false;
bool chapterHasBeenEdited = false;

const int kUserLevelNotLoggedIn = 0;
const int kUserLevelFree = 1;
const int kUserLevelPro = 2;
const int kUserLevelSupervisor = 99;

const double kAbbBarButtonSize = 40;
const double kArrowPadSize = 100;
const double mapShiftIncrement = 15.0;
const double kDefaultNodeSize = 40.0;

const String kGuestUserDisplayName = 'Guest';

const kConectedUserNodeSizePrefLabel = 'conectedUserNodeSize';
const kConectedUserXCoordPrefLabel = 'xCoord';
const kConectedUserYCoordPrefLabel = 'yCoord';
const kConectedUserReadStateIndexPrefLabel = 'readStateIndex';
const kConectedUserColors = 'colors';

const double kMapNodeMoveMinChange = 2.0;
const int kLimitDatabaseListDocuments = 1000;

const PageTransitionType kStandardPageTransitionType =
    PageTransitionType.leftToRight;
const Duration kStandardTransitionTime = Duration(milliseconds: 1000);
const Duration kStandardReverseTransitionTime = Duration(milliseconds: 300);

bool showLogoEtcOnMap = true;
bool isIncomingResetPassword = false;

DocumentReference? _currentHyperbook;
DocumentReference? get currentHyperbook => _currentHyperbook;
set currentHyperbook(DocumentReference? value) {
  _currentHyperbook = value;
}

class ConstraintsRecord {
  int? noOfHyperbooks;
  int? noOfUsersPerHyperbook;
  int? level;
  ConstraintsRecord(
      {this.noOfHyperbooks, this.noOfUsersPerHyperbook, this.level});
}

List<ConstraintsRecord> constraintsMatrix = [];
DateTime? lastCheckedConstraints;

Future<void> loadConstraisMatrix() async {
  print('(CC6)');
  if (lastCheckedConstraints != null) {
    print('(CC3)${DateTime.now().difference(lastCheckedConstraints!).inDays}');
  } else {
    print('(CC4)');
  }
/*  if ((lastCheckedConstraints == null) ||
      (DateTime.now().difference(lastCheckedConstraints!).inDays > 1)) {
    constraintsMatrix = await listConstraintsList();
  }*/
}

void initAppwrite() {
  client = Client()
      .setEndpoint(endpoint)
      .setProject(project)
      .setDevKey(devKey)
      .setSelfSigned();
  account = Account(client!);
}

@JsonSerializable()
class DocumentReference {
  String? path;
  DocumentReference({this.path = '0'});
/*  factory DocumentReference.fromJson(Map<String, dynamic> json) =>
      _$DocumentReferenceFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentReferenceToJson(this);*/
}

@JsonSerializable()
class SessionsRecord {
  DocumentReference? reference;
  DocumentReference? clientId;
  DocumentReference? therapistId;
  DateTime? $createdAt;
  DateTime? $updatedAt;

  SessionsRecord({
    this.reference,
    this.clientId,
    this.therapistId,
    this.$createdAt,
    this.$updatedAt,
  });

/* factory SessionStepsRecord.fromJson(Map<String, dynamic> json) =>
      _$SessionStepsRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SessionStepsRecordToJson(this);*/
}

@JsonSerializable()
class SessionsStepsRecord {
  DocumentReference? reference;
  DocumentReference? photo;
  DocumentReference? audio;
  bool? completed;
  String? transcription;
  int? index;
  DateTime? $createdAt;
  DateTime? $updatedAt;

  SessionsStepsRecord({
    this.reference,
    this.photo,
    this.audio,
    this.completed,
    this.transcription,
    this.index,
    this.$createdAt,
    this.$updatedAt,
  });

/* factory SessionStepsRecord.fromJson(Map<String, dynamic> json) =>
      _$SessionStepsRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SessionStepsRecordToJson(this);*/
}

@JsonSerializable()
class UsersRecord {
  DocumentReference? reference;
  String? email;
  String? displayName;
  DateTime? createdTime;
  String? phoneNumber;
  int? userLevel;
  String? userMessage;
  String? role;
  DateTime? $createdAt;
  DateTime? $updatedAt;

  UsersRecord({
    this.reference,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.userMessage,
    this.role,
    this.$createdAt,
    this.$updatedAt,
  });

/*  factory UsersRecord.fromJson(Map<String, dynamic> json) =>
      _$UsersRecordFromJson(json);
  Map<String, dynamic> toJson() => _$UsersRecordToJson(this);
}*/
}

Future<models.Document> createDocument(
    {required DocumentReference? collection,
    required Map? data,
    String id = ''}) async {
  if (id == '') {
    id = ID.unique();
  }
  appwriteDatabases = Databases(client!);
  //>print('(N100A)${id}////${data}::::${collection!.path}');
  models.Document doc = await appwriteDatabases!.createDocument(
    databaseId: databaseRef.path!,
    collectionId: collection!.path!,
    documentId: id,
    data: data!,
  );
  //>print('(N100B)${doc}');
  return doc;
}

Future<models.DocumentList> listDocuments({
  DocumentReference? collection,
  String? orderByAttribute,
}) async {
  appwriteDatabases = Databases(client!);
  print(
      '(N11A)${appwriteDatabases!.client.endPoint}////${collection!.path}((((${orderByAttribute}');
  print('(N11B)${databaseRef.path}////${collection!.path}');
  models.DocumentList? docs;
  if (orderByAttribute == null) {
    docs = await appwriteDatabases!.listDocuments(
      databaseId: databaseRef.path!,
      collectionId: collection!.path!,
      queries: [
        Query.limit(kLimitDatabaseListDocuments),
      ],
    );
    print('(N11C)${docs}');
  } else {
    docs = await appwriteDatabases!.listDocuments(
      databaseId: databaseRef.path!,
      collectionId: collection!.path!,
      queries: [
        Query.limit(kLimitDatabaseListDocuments),
        Query.orderAsc(orderByAttribute),
      ],
    );
    print('(N11E)${docs}');
  }
  print('(N11F)${docs.documents.length}');
  print('(N11G)${docs!.documents}');
  return docs;
}

Future<models.Document> getDocument({
  DocumentReference? collection,
  DocumentReference? document,
}) async {
  appwriteDatabases = Databases(client!);
  print(
      '(N2011A)${databaseRef.path}<<<<${collection!.path}++++${document!.path}');
  models.Document doc = await appwriteDatabases!.getDocument(
    databaseId: databaseRef.path!,
    collectionId: collection!.path!,
    documentId: document!.path!,
    queries: [],
  );
  print('(N2011B)${doc.$id}');
  return doc;
}

Future<void> updateDocument({
  DocumentReference? collection,
  DocumentReference? document,
  Map<String, dynamic>? data,
}) async {
  appwriteDatabases = Databases(client!);
  //>print('(N2011C)${data}////${collection!.path}++++${document!.path}');688c919e8a6d84adb201
  models.Document doc = await appwriteDatabases!.updateDocument(
    databaseId: databaseRef.path!,
    collectionId: collection!.path!,
    documentId: document!.path!,
    data: data,
  );
  // //>print('(N2021D)${document.path}');
  return;
}

Future<void> deleteDocument({
  required DocumentReference? collection,
  required DocumentReference? document,
}) async {
  appwriteDatabases = Databases(client!);
  //>print('(ND4)${collection!.path}++++${document!.path}');
  try {
    await appwriteDatabases!.deleteDocument(
      databaseId: databaseRef.path!,
      collectionId: collection!.path!,
      documentId: document!.path!,
    );
  } on AppwriteException catch (e) {
    //>print('(ND6)${e.message}&&&&${e.code}====${e.code}');
  }
  //>print('(ND5)');
  return;
}

Future<models.DocumentList> listDocumentsWithOneQueryDocumentReference({
  DocumentReference? collection,
  String attribute = '',
  DocumentReference? value,
  String? orderByAttribute,
}) async {
  appwriteDatabases = Databases(client!);
  models.DocumentList docs = models.DocumentList(total: 0, documents: []);
//>  print(
  //>   '(N7A)${attribute}&&&&${value!.path}////${databaseRef.path}ÅÅÅÅ${collection!.path}',
  // );
  //>print('(N7ZA)${appwriteDatabases}>>>>${collection}<<<<${value}');
  try {
    if (orderByAttribute == null) {
      docs = await appwriteDatabases!.listDocuments(
        databaseId: databaseRef.path!,
        collectionId: collection!.path!,
        queries: [
          Query.equal(attribute, value!.path),
          Query.limit(kLimitDatabaseListDocuments),
        ],
      );
    } else {
      docs = await appwriteDatabases!.listDocuments(
        databaseId: databaseRef.path!,
        collectionId: collection!.path!,
        queries: [
          Query.equal(attribute, value!.path),
          Query.limit(kLimitDatabaseListDocuments),
          Query.orderAsc(orderByAttribute),
        ],
      );
    }
  } /*on AppwriteException */ catch (e) {
    //  //>print('(N8A)${e.message}&&&&${e.code}====${e.code}');
    //>print('(N8B)${e}');
  }
  // //>print('(N9A)${docs.documents.length}');
  // if(docs.documents.length > 0) {
  //   //>print('(N9)${docs.documents.length}>>>>${docs.documents.first.$id}<<<<${docs.documents.first.data.entries}');
  // }
  return docs;
}

Future<models.DocumentList> listDocumentsWithTwoQueryDocumentReferences({
  DocumentReference? collection,
  String attribute1 = '',
  DocumentReference? value1,
  String attribute2 = '',
  DocumentReference? value2,
}) async {
  appwriteDatabases = Databases(client!);
  models.DocumentList docs = models.DocumentList(total: 0, documents: []);
  //> print(
  //>  '(NY10)${attribute1}&&&&${value1!.path}////${databaseRef.path}ÅÅÅÅ${collection!.path}',
  //> );
  //>print('(NY11)${appwriteDatabases}>>>>${collection}<<<<${value1}');
  try {
    docs = await appwriteDatabases!.listDocuments(
      databaseId: databaseRef.path!,
      collectionId: collection!.path!,
      queries: [
        Query.equal(attribute1, value1!.path),
        Query.equal(attribute2, value2!.path),
        Query.limit(kLimitDatabaseListDocuments),
      ],
    );
  } /*on AppwriteException */ catch (e) {
    //  //>print('(N8A)${e.message}&&&&${e.code}====${e.code}');
    //>print('(NY12${e}');
  }
  //>print('(NY13)${docs.documents.length}>>>>${docs.documents}<<<<${docs.total}');
  return docs;
}

Future<models.DocumentList> listDocumentsWithOneQueryString({
  DocumentReference? collection,
  String attribute = '',
  String? value,
}) async {
  appwriteDatabases = Databases(client!);
  models.DocumentList? docs;
  //> print(
  //>   '(N207A)${attribute}&&&&${value}////${databaseRef.path}ÅÅÅÅ${collection!.path}',
//>  );
  //>print('(N7ZB)${appwriteDatabases}>>>>${collection}<<<<${value}');
  try {
    docs = await appwriteDatabases!.listDocuments(
      databaseId: databaseRef.path!,
      collectionId: collection!.path!,
      queries: [
        Query.equal(attribute, value!),
        Query.limit(kLimitDatabaseListDocuments)
      ],
    );
  } on AppwriteException catch (e) {
    //  //>print('(N8A)${e.message}&&&&${e.code}====${e.code}');
    //>print('(N208B)${e}');
  }
  //> print(
  //>     '(N2009)${appwriteDatabases!.client.endPoint}>>>>${collection.path}<<<<${value}');
  return docs!;
}

Future<SessionsRecord> createSession({
  required DocumentReference? clientId,
  required DocumentReference? therapistId,
  String id = '',
}) async {
  //>//>('(NW60)${id}');
  models.Document doc = await createDocument(
    collection: sessionsRef,
    data: {
      kSessionClientId: clientId!.path,
      kSessionTherapistId: therapistId!.path,
      kDBcreatedAt: DateTime.now(),
      kDBupdatedAt: DateTime.now(),
    },
    id: id,
  );
  //>print('(NW61)${doc}');
  SessionsRecord h = SessionsRecord(
    reference: DocumentReference(path: doc.$id),
    clientId: clientId,
    therapistId: therapistId,
  );
  return h;
}

Future<SessionsStepsRecord> createSessionStep({
  required DocumentReference? photo,
  required DocumentReference? audio,
  required bool? completed,
  required String? transcription,
  required int? index,
  String id = '',
}) async {
  //>//>('(NW60)${id}');
  models.Document doc = await createDocument(
    collection: sessionsRef,
    data: {
      kSessionStepPhoto: photo,
      kSessionStepAudio: audio,
      kSessionStepCompleted: completed,
      kSessionStepTranscription: transcription,
      kSessionStepIndex: index,
      kDBcreatedAt: DateTime.now(),
      kDBupdatedAt: DateTime.now(),
    },
    id: id,
  );
  //>print('(NW61)${doc}');
  SessionsStepsRecord h = SessionsStepsRecord(
    reference: DocumentReference(path: doc.$id),
    photo: photo,
    audio: audio,
    completed: completed,
    transcription: transcription,
    index: index,
  );
  return h;
}

Future<UsersRecord> createUser({
  DocumentReference? reference,
  String? email,
  String? displayName,
  DateTime? createdTime,
  String? phoneNumber,
  DocumentReference? userReference,
  int? userLevel,
  String? userMessage,
  String? role,
  String id = '',
}) async {
  //>print('(M10`)${createdTime!.hour}');
  models.Document doc = await createDocument(
    collection: usersRef,
    data: {
      'email': email,
      'displayName': displayName,
      'createdTime': createdTime!.toIso8601String(),
      'phoneNumber': phoneNumber,
      'userReference': userReference!.path,
      'userLevel': userLevel,
      'userMessage': userMessage,
    },
    id: id,
  );
  UsersRecord u = UsersRecord(
    reference: DocumentReference(path: doc.$id),
    email: email,
    displayName: displayName,
    phoneNumber: phoneNumber,
    role: role,
    userMessage: userMessage,
  );
  return u;
}

Future<UsersRecord> getUser({DocumentReference? document}) async {
  models.Document doc =
      await getDocument(collection: usersRef, document: document);
  print(
      '(M1)${doc.data}&&&&${doc.data['chapterColorInts'].runtimeType}****${doc.data['chapterColorInts']}');
  List<int> colorInts = [];
  List<dynamic> dyn = doc.data['chapterColorInts'] as List<dynamic>;
  for (var x in dyn) {
    colorInts.add(x as int);
  }
  print('(M1A)${doc.data['displayName']}');
  UsersRecord u = UsersRecord(
    reference: document,
    email: (doc.data[kUserEmail]) as String,
    displayName: (doc.data[kUserDisplayName]) as String,
    phoneNumber: ((doc.data[kUserPhoneNumber]) ?? '') as String,
    role: (doc.data[kUserRole]) as String,
    userMessage: (doc.data[kUserUserMessage] as String?),
  );
  //>print('(N2005)${u}');
  return u;
}

Future<List<SessionsRecord>> listSessionList(
    {bool justCurrentUserAsTherapist = true}) async {
  //>print('(N12)${justCurrentUserAsModerator}');
  models.DocumentList docs;
  if (justCurrentUserAsTherapist) {
    docs = await listDocumentsWithOneQueryDocumentReference(
        collection: sessionsRef,
        attribute: kSessionTherapistId,
        value: currentUser!.reference,
        orderByAttribute: kDBcreatedAt);
  } else {
    docs = await listDocuments(
        collection: sessionsRef, orderByAttribute: kDBcreatedAt);
  }
  List<SessionsRecord> hh = [];
  for (models.Document d in docs.documents) {
    //>print('(N1)${d.$id}&&&&${d.data}');
    SessionsRecord h = SessionsRecord(
      reference: DocumentReference(path: d.$id),
      clientId: DocumentReference(path: (d.data[kSessionClientId] as String?)),
      therapistId:
          DocumentReference(path: (d.data[kSessionTherapistId] as String?)),
      $createdAt: DateTime.parse(d.$createdAt),
      $updatedAt: DateTime.parse(d.$updatedAt),
    );
    hh.add(h);
  }
  //>print('(N1AA)${hh.length}');
  return hh;
}

Future<SessionsRecord> getSession({DocumentReference? document}) async {
  models.Document d =
      await getDocument(collection: sessionsRef, document: document);
  ////>print('(M1)${doc.data['chapterColorInts'].runtimeType}****${doc.data['chapterColorInts']}');
  SessionsRecord h = SessionsRecord(
    reference: DocumentReference(path: d.$id),
    clientId: DocumentReference(path: (d.data[kSessionClientId] as String?)),
    therapistId:
        DocumentReference(path: (d.data[kSessionTherapistId] as String?)),
    $createdAt: DateTime.parse(d.$createdAt),
    $updatedAt: DateTime.parse(d.$updatedAt),
  );
  //>print('(N5005)${h}');
  return h;
}

Future<List<UsersRecord>> listUsersListWithEmail({
  String? email,
}) async {
  models.DocumentList docs;
  //>print('(N2106)${email}¤¤¤¤${usersRef}');
  if (email == null) {
    docs = await listDocuments(
      collection: usersRef,
    );
  } else {
    docs = await listDocumentsWithOneQueryString(
      collection: usersRef,
      attribute: 'email',
      value: email,
    );
  }
  List<UsersRecord> uu = [];
  for (models.Document d in docs.documents) {
    List<dynamic> cCIList = d.data['chapterColorInts'] as List<dynamic>;
    List<int> cCListInt = [];
    for (var cCIItem in cCIList) {
      cCListInt.add(cCIItem as int);
    }
    //>print('(NY7)${cCListInt}');
    UsersRecord u = UsersRecord(
      reference: DocumentReference(path: d.$id),
      email: (d.data[kUserEmail] as String?),
      displayName: (d.data[kUserDisplayName] as String?),
      phoneNumber: (d.data[kUserPhoneNumber] as String?),
      role: (d.data[kUserRole] as String?),
      userMessage: (d.data[kUserUserMessage] as String?),
    );
    uu.add(u);
  }
  return uu;
}

Future<List<ConstraintsRecord>> listConstraintsList() async {
  print('(CC10)${constraintsRef}');
  models.DocumentList docs;
  docs = await listDocuments(
      collection: constraintsRef, orderByAttribute: 'level');
  List<ConstraintsRecord> cc = [];
  for (models.Document d in docs.documents) {
    print('(CC1)${d.$id}&&&&${d.data}');
    ConstraintsRecord c = ConstraintsRecord(
      noOfHyperbooks: (d.data['noOfHyperbooks'] as int?),
      noOfUsersPerHyperbook: (d.data['noOfUsersPerHyperbook'] as int?),
      level: (d.data['level'] as int?),
    );
    cc.add(c);
  }
  print('(CC2)${cc.length}++++${cc}');
  return cc;
}

Future<void> setUserPrefs({
  required Account account,
  List<Color>? colorArray,
}) async {
  //>print('(N55A)${account}****${colorArray}');
  int x = colorArray![0].value;
  //>print('(N55B)${x}');
  final user = await account.get();
  Map<String, int> prefMap = {};
  if (user != null) {
    for (int i = 0; i < colorArray!.length; i++) {
      prefMap['color${i.toString()}'] = colorArray[i].value;
    }
    var response = await account.updatePrefs(prefs: prefMap);
    models.Preferences prefs = await account.getPrefs();
    //>print('(N56)${prefs.data['color0']}****${response.prefs}');
    ;
  }
}

Future<UsersRecord?> appwriteLogin(
    BuildContext context, String email, String password) async {
  models.User? user;
  models.Session? session;
  //>print('(N91A)${email}****${password}');
  try {
    session = await account!.createEmailPasswordSession(
      email: email,
      password: password,
    );
  } on AppwriteException catch (e) {
    //>print('(N91B)${e.type}****${e.message}');
    if (e.message!.startsWith('Creation of a session is prohibited')) {
      //>print('(N91C)${email}****${password}');

      try {
        await appwriteLogout();
      } on AppwriteException catch (e) {
        //>print('(N91D)${e.type}****${e.message}');
        toast(context, 'Error on logging in 1', ToastKind.error);
      }
      //>print('(N91E)${email}****${password}');
      loggedIn = false;
      try {
        session = await account!.createEmailPasswordSession(
          email: email,
          password: password,
        );
      } on AppwriteException catch (e) {
        //>print('(N91F)${e.type}****${e.message}');
        toast(context, 'Error on logging in 2', ToastKind.error);
      }
    }
  }

  try {
    user = await account!.get();
  } on AppwriteException catch (e) {
    //>print('(N91F)${e.type}****${e.message}');
    toast(context, 'Error on logging in 3', ToastKind.error);
  }

  if (user == null) {
    toast(context, 'Error on logging in 4', ToastKind.error);
  }

  //>print('(N91G)${user}');
  //>print('(N91H)${user!.name}++++${user!.$id}');

  //setState(() {
  loggedInUser = user;

  currentUser = await getUser(document: DocumentReference(path: user!.$id));
  print('(N91I)${currentUser}');
  print('(N91J)${currentUser!.reference!.path}');
  print('(N91K)${currentUser!.displayName}');

  //> print(
  //>     '(N91O)${user.$id}****${currentUser!.reference!.path}!!!!${currentUser!.chapterColorInts}');
  currentUserDisplayName = currentUser!.displayName!;
  currentUserEmail = currentUser!.email!;
  return currentUser;
  // });
}

Future<void> getCurrentUserDetails() async {
  models.User user = await account!.get();
}

Future<void> appwriteLogout() async {
  await account!.deleteSessions();
}

Future<void> appwritePhoneLogin() async {
  account!.createPhoneVerification();
}

Future<UsersRecord> appwriteCreateAccount(String email, String password) async {
  String id = getRandomNumericString(20);
  models.User user = await account!.create(
    userId: id,
    email: email,
    password: password,
    name: 'Unknown',
  );
  //>print('(N5000)${user}&&&&${user.email}');
  UsersRecord userRecord = await createUser(
    reference: DocumentReference(path: id),
    email: email,
    displayName: 'Unknown',
    createdTime: DateTime.now(),
    phoneNumber: '',
    userReference: DocumentReference(path: id),
    id: id,
    userLevel: kUserLevelFree,
    userMessage: 'Welcome to the Hyperbook App',
  );

  loggedInUser = user;
  currentUser = await getUser(document: DocumentReference(path: user.$id));
  currentUserDisplayName = currentUser!.displayName!;
  currentUserEmail = currentUser!.email!;
  // });
  //>print('(N5002)${userRecord}****${currentUser}');
  return userRecord;
}

bool canUserSeeSession(DocumentReference? user, SessionsRecord? session) {
  //>print('(N404A)${Session!.title}####${user}&&&&${Session!.nonMemberRole}');
  if (currentUser!.reference == null) return false;
  if (session == null) return false;
  final String role = currentUser!.role!;
  if ((role == null) || (role == '') || (role == kRoleNone)) {
    //>print('(N404R)${role}');
    return false;
  } else {
    if ((role == kRoleSupervisor) || (role == kRoleAdministrator)) {
      //>print('(N404S)${role}');
      return true;
    } else {
      //>print('(N404T)${role}');
      if ((role == kRoleTherapist) &&
          (session!.therapistId!.path == currentUser!.reference!.path)) {
        return true;
      }

      return false;
    }
  }
}

Storage storage = Storage(client!);

Future<String?> createStorageImageFile({
  required DocumentReference? chapter,
  required DocumentReference? user,
  required String? path,
  required String? name,
  required Uint8List bytes,
}) async {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyyMMddkkmms');
  String randomFileNumber = getRandomNumericString(15);
  // List<String> splitFilename = name!.split('.');
  // final String preffix = splitFilename.first;
  // final String suffix = splitFilename.last;
  final String truncatedName =
      (name!.length > 15) ? name.substring(0, 15) : name;
  final String fileId =
      chapter!.path! + kStorageFilenameSpitString + randomFileNumber;
  final String storageFilename =
      chapter.path! + kStorageFilenameSpitString + truncatedName;
  //>print('(QE30)${fileId}++++${storageFilename}');

  models.File result = await storage.createFile(
    bucketId: artTheopyAIRphotosRef.path!,
    fileId: fileId,
    file: InputFile.fromBytes(bytes: bytes, filename: storageFilename),
  );
  var file = await storage.getFile(
      bucketId: artTheopyAIRphotosRef.path!, fileId: fileId);
  //String url = file.
  //>print('(IS1)${file.toString()}++++${result.name}@@@@${file.name}~~~~');

  const String head = imageFilenameHead;
  final b_id = artTheopyAIRphotosRef.path!;
  final f_id = fileId;
  final p_id = project;
  final String url =
      '${head}/${b_id}/files/${f_id}/preview?project=${p_id}&mode=admin';
  //>print('(IS2)${head}££££${url}????');

  return url;
}

Future<String?> getStorageFileDownload({
  models.File? file,
}) async {
  Uint8List bytes = await storage.getFileDownload(
    bucketId: backupStorageRef.path!,
    fileId: file!.$id,
  );
  String s = utf8.decode(bytes);
  //>print('(XY30)${file!.$id}++++${bytes.length}****${s}');
  return s;
}

Future<String?> readStorageFile(
    {required DocumentReference? user,
    required String? hyperbookTitle,
    required int? versionNumber}) async {
  String expandedFilename = user!.path! +
      '_' +
      hyperbookTitle! +
      '-' +
      versionNumber.toString() +
      '.json';
  Uint8List bytes = await storage.getFileDownload(
    bucketId: backupStorageRef.path!,
    fileId: expandedFilename,
  );
  String s = utf8.decode(bytes);
  //>print('(XY10)${expandedFilename}++++${bytes.length}****${s}');
  return s;
}

Future<models.FileList> listStorageFiles({String? bucketId}) async {
  //>print('(XY6)${bucketId}');
  models.FileList fileList = models.FileList(total: 0, files: []);
  try {
    fileList = await storage.listFiles(bucketId: bucketId!, queries: [
      Query.limit(1000),
    ]);
    //>print('(XY7)${fileList.files.length}');
    if (fileList.files.length < 1) {
      for (models.File file in fileList.files) {
        String filename = file.name;
        //>print('(XY8)${filename}');
      }
    }
  } catch (e) {
    //>print('(XY9)${e.toString()}');
  }
  return fileList;
}

Future<void> deleteImagesInChapter({
  required DocumentReference chapter,
}) async {
  //>print('(MI5)${chapter.path}');
  models.FileList fileList = await storage.listFiles(
    bucketId: artTheopyAIRphotosRef.path!, // bucketId
    queries: [
      Query.contains("name", [chapter.path])
    ], // queries (optional)
  );
  for (models.File f in fileList.files) {
    //>  print(
    //>      '(MI6)${imageStorageRef.path!}~~~~${f.name}++++${f.signature}&&&&${f.$id}');
    storage.deleteFile(bucketId: artTheopyAIRphotosRef.path!, fileId: f.$id);
  }
}

setupTutorialUser(BuildContext context) async {
  // BaseAuthUser? user =
  //   await authManager.signInWithEmail(
  //       context,'info@hyperbook.co.uk', '244891'
  //   );
  UsersRecord? user;

  try {
    /*  user = await appwriteLogin(
      context,
      'info@hyperbook.co.uk',
      '244891244891',
    );
  */
    user = await appwriteLogin(context, 'info@hyperbook.co.uk', '244891244891');
  } catch (e) {
    //>print('(TU1)${e}');
    toast(context, 'Cannot setup guest user', ToastKind.error);
  }

  loggedIn = true;
  // localDB.hyperbooklocalDBValid = false;
  // await localDB.loadLocalDB(user: currentUser!.reference);
  // await localDB.dumpLocalDB();
  if (kIsWeb) {
    String? message = currentUser!.userMessage;
    bool showMessage = ((message != null) && (message != ''));
    print('(RW1)${message}....${showMessage}````${versionNumber}');
    if (showMessage) {
      List<String> splitMessage = message.split(kMessageSpitCharacter);
      if (message.contains(kMessageSpitCharacter)) {
        int? versiontoUpgradeTo = int.tryParse(splitMessage[1]);
        print('(RW2)${versiontoUpgradeTo}');
        if (versiontoUpgradeTo != null) {
          if (versionNumber < versiontoUpgradeTo) {
            await html.window.caches!.delete('flutter-app-manifest');
            await html.window.caches!.delete('flutter-app-cache');
            html.window.location.reload();
          }
        }
      }
    }
  }
}
