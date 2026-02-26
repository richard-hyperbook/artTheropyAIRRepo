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
// import 'custom_code/widgets/get_hyperbooks.dart';
import 'custom_code/widgets/permissions.dart';

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io' as dartio;
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
import '../session_display/session_display_widget.dart';
import 'dart:async';
// import 'dart:html' as html show window;
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:web/web.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:io';
import 'dart:convert';

// part 'appwrite_interface.g.dart';

enum FileKind { audio, photo, video }

const String _numericChars = '1234567890';
Random _numericRnd = Random();

String getRandomNumericString(int length) => String.fromCharCodes(
  Iterable.generate(
    length,
    (_) => _numericChars.codeUnitAt(_numericRnd.nextInt(_numericChars.length)),
  ),
);

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
const kEndpoint = 'https://fra.cloud.appwrite.io/v1';
const kProjectID = '696ddda6001b28f2352e';
const kDevKey =
    '4de99514ee3d5a8fb3cdf236ba66a91e9bdb37c8397f9f98542530bd2f6a71797d93b068276fc23c0aba27cbd1e41912d4362456a9a167150bc5a2d66265b86a94229cfaf7d63181b173898e5f322b28f4d1c9a6c3470fa129f933062428ceb4806c26ca5bfa8e91d7e88f8dcbc430d1eb864016906a31d0dd78bf6a9450794d';
const imageFilenameHead = kEndpoint + '/storage/buckets';

final DocumentReference databaseRef = DocumentReference(
  path: '698c8fce0029ddaaecdb',
);
final DocumentReference sessionStepsRef = DocumentReference(
  path: 'sessionsteps',
);
final DocumentReference sessionsRef = DocumentReference(path: 'sessions');
final DocumentReference usersRef = DocumentReference(path: 'users');
final DocumentReference backupStorageRef = DocumentReference(
  path: '680746de003983073d29',
);
final DocumentReference artTheopyAIRphotosRef = DocumentReference(
  path: '698c93550005c8307b67',
);
final DocumentReference artTheopyAIRaudiosRef = DocumentReference(
  path: '698c93a00006c743c31f',
);
final DocumentReference constraintsRef = DocumentReference(path: '');

// LocalDB localDB = LocalDB();

UsersRecord? currentUser;
String currentUserDisplayName = '';
String currentUserEmail = '';
SessionsRecord? currentSession;
SessionStepsRecord? currentSessionStep;
int? currentSessionStepIndex;
String? currentLocalAudioPath;
UsersRecord? currentTherapist;
UsersRecord? currentClient;

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
const int kLimitStorageListDocuments = 1000;

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
  ConstraintsRecord({
    this.noOfHyperbooks,
    this.noOfUsersPerHyperbook,
    this.level,
  });
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

TablesDB? tablesDB;
void initAppwrite() {
  print('(AAT30)');
  client = Client()
      .setEndpoint(kEndpoint)
      .setProject(kProjectID)
      .setDevKey(kDevKey)
      .setSelfSigned();
  account = Account(client!);
  tablesDB = TablesDB(client!);
  print('(AAT31)${client},,,,${account}++++${tablesDB}');
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
  String? clientDisplayName;
  DateTime? $createdAt;
  DateTime? $updatedAt;

  SessionsRecord({
    this.reference,
    this.clientId,
    this.therapistId,
    this.clientDisplayName,
    this.$createdAt,
    this.$updatedAt,
  });

  /* factory SessionStepsRecord.fromJson(Map<String, dynamic> json) =>
      _$SessionStepsRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SessionStepsRecordToJson(this);*/
}

@JsonSerializable()
class SessionStepsRecord {
  DocumentReference? reference;
  DocumentReference? sessionId;
  DocumentReference? photo;
  DocumentReference? audio;
  bool? completed;
  String? transcription;
  int? index;
  String? question;
  DateTime? $createdAt;
  DateTime? $updatedAt;
  int? maxAudioVersion;
  int? maxPhotoVersion;

  SessionStepsRecord({
    this.reference,
    this.sessionId,
    this.photo,
    this.audio,
    this.completed,
    this.transcription,
    this.index,
    this.question,
    this.$createdAt,
    this.$updatedAt,
    this.maxAudioVersion,
    this.maxPhotoVersion,
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

Future<models.Document> createDocument({
  required DocumentReference? collection,
  required Map? data,
  String id = '',
}) async {
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
    '(N11A)${appwriteDatabases!.client.endPoint}////${collection!.path}((((${orderByAttribute}',
  );
  print('(N11B)${databaseRef.path}////${collection.path}');
  models.DocumentList? docs;
  if (orderByAttribute == null) {
    docs = await appwriteDatabases!.listDocuments(
      databaseId: databaseRef.path!,
      collectionId: collection.path!,
      queries: [Query.limit(kLimitDatabaseListDocuments)],
    );
    print('(N11C)${docs}');
  } else {
    docs = await appwriteDatabases!.listDocuments(
      databaseId: databaseRef.path!,
      collectionId: collection.path!,
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
    '(N2011A)${databaseRef.path}<<<<${collection!.path}++++${document!.path}',
  );
  models.Document? doc;
  try {
    doc =
        await tablesDB!.getRow(
              databaseId: databaseRef.path!,
              tableId: collection.path!,
              rowId: document.path!,
              queries: [],
            )
            as models.Document;
  } on AppwriteException catch (e) {
    print('(AAT42)${e.type}****${e.message}');
    //   toast(context, 'Login failure: ${e.message}', ToastKind.error);
  }
  print('(N2011B)${doc!.$id}');
  return doc;
}

Future<models.Row> getRow({
  DocumentReference? collection,
  DocumentReference? document,
}) async {
  // appwriteDatabases = Databases(client!);
  print(
    '(N2011A)${databaseRef.path}<<<<${collection!.path}++++${document!.path}',
  );
  models.Row? row;
  try {
    row = await tablesDB!.getRow(
      databaseId: databaseRef.path!,
      tableId: collection.path!,
      rowId: document.path!,
      queries: [],
    );
  } on AppwriteException catch (e) {
    print('(AAT52)${e.type}****${e.message}');
    //   toast(context, 'Login failure: ${e.message}', ToastKind.error);
  }
  print('(N2011B)${row!.$id}');
  return row;
}

Future<void> updateDocument({
  DocumentReference? collection,
  DocumentReference? document,
  Map<String, dynamic>? data,
}) async {
  // appwriteDatabases = Databases(client!);
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

Future<void> updateRow({
  DocumentReference? collection,
  DocumentReference? document,
  Map<String, dynamic>? data,
}) async {
  // appwriteDatabases = Databases(client!);
  //>print('(N2011C)${data}////${collection!.path}++++${document!.path}');688c919e8a6d84adb201
  try {
    models.Row row = await tablesDB!.updateRow(
      databaseId: databaseRef.path!,
      tableId: collection!.path!,
      rowId: document!.path!,
      data: data,
    );
  } on AppwriteException catch (e) {
    print('(ND6)${e.message}&&&&${e.code}====${e.code}');
  }
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
    print('(ND6)${e.message}&&&&${e.code}====${e.code}');
  }
  //>print('(ND5)');
  return;
}

Future<void> deleteRow({
  required DocumentReference? collection,
  required DocumentReference? document,
}) async {
  // appwriteDatabases = Databases(client!);
  //>print('(ND4)${collection!.path}++++${document!.path}');
  try {
    await tablesDB!.deleteRow(
      databaseId: databaseRef.path!,
      tableId: collection!.path!,
      rowId: document!.path!,
    );
  } on AppwriteException {
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

Future<models.RowList> listRowsWithOneQueryDocumentReference({
  DocumentReference? collection,
  String attribute = '',
  DocumentReference? value,
  String? orderByAttribute,
}) async {
  // appwriteDatabases = Databases(client!);
  models.RowList rows = models.RowList(total: 0, rows: []);
  //>  print(
  //>   '(N7A)${attribute}&&&&${value!.path}////${databaseRef.path}ÅÅÅÅ${collection!.path}',
  // );
  //>print('(N7ZA)${appwriteDatabases}>>>>${collection}<<<<${value}');
  try {
    if (orderByAttribute == null) {
      rows = await tablesDB!.listRows(
        databaseId: databaseRef.path!,
        tableId: collection!.path!,
        queries: [
          Query.equal(attribute, value!.path),
          Query.limit(kLimitDatabaseListDocuments),
        ],
      );
    } else {
      rows = await tablesDB!.listRows(
        databaseId: databaseRef.path!,
        tableId: collection!.path!,
        queries: [
          Query.equal(attribute, value!.path),
          Query.limit(kLimitDatabaseListDocuments),
          Query.orderAsc(orderByAttribute),
        ],
      );
    }
  } on AppwriteException catch (e) {
    print('(N8A)${e.message}&&&&${e.code}====${e.code}');
    print('(N8B)${e}');
  }
  // //>print('(N9A)${docs.documents.length}');
  // if(docs.documents.length > 0) {
  //   //>print('(N9)${docs.documents.length}>>>>${docs.documents.first.$id}<<<<${docs.documents.first.data.entries}');
  // }
  return rows;
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

Future<models.DocumentList> listDocumentsWithTwoQueries({
  DocumentReference? collection,
  String attribute1 = '',
  dynamic value1,
  String attribute2 = '',
  dynamic value2,
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
        Query.equal(attribute1, value1!),
        Query.equal(attribute2, value2!),
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
        Query.limit(kLimitDatabaseListDocuments),
      ],
    );
  } on AppwriteException {
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

Future<SessionStepsRecord> createSessionStep({
  required DocumentReference? sessionId,
  required DocumentReference? photo,
  required DocumentReference? audio,
  required bool? completed,
  required String? transcription,
  required int? index,
  required String? question,
  String id = '',
}) async {
  //>//>('(NW60)${id}');
  models.Document doc = await createDocument(
    collection: sessionsRef,
    data: {
      kSessionStepSessionId: sessionId,
      kSessionStepPhoto: photo,
      kSessionStepAudio: audio,
      kSessionStepCompleted: completed,
      kSessionStepTranscription: transcription,
      kSessionStepIndex: index,
      kSessionStepQuestion: question,
      kDBcreatedAt: DateTime.now(),
      kDBupdatedAt: DateTime.now(),
    },
    id: id,
  );
  //>print('(NW61)${doc}');
  SessionStepsRecord h = SessionStepsRecord(
    reference: DocumentReference(path: doc.$id),
    sessionId: sessionId,
    photo: photo,
    audio: audio,
    completed: completed,
    transcription: transcription,
    index: index,
    question: question,
    maxAudioVersion: 0,
    maxPhotoVersion: 0,
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
  models.Row row = await getRow(collection: usersRef, document: document);
  print('(M1)${row.data}****${row.data['chapterColorInts']}');
  List<int> colorInts = [];
  print('(M1A)${row.data['displayName']}');
  UsersRecord u = UsersRecord(
    reference: document,
    email: (row.data[kUserEmail]) as String,
    displayName: (row.data[kUserDisplayName]) as String,
    phoneNumber: ((row.data[kUserPhoneNumber]) ?? '') as String,
    role: (row.data[kUserRole]) as String,
    userMessage: (row.data[kUserUserMessage] as String?),
  );
  print('(N2005)${u}');
  return u;
}

String generateAudioStorageFilename(
  SessionStepsRecord sessionStep,
  int version,
) {
  return 'audio${sessionStep.reference!.path}_${version}.wav';
}

String generatePhotoStorageFilename(
  SessionStepsRecord sessionStep,
  int version,
) {
  return 'photo${sessionStep.reference!.path}_${version}.jpg';
}

Future<List<SessionsRecord>> listSessionList({
  bool justCurrentUserAsTherapist = true,
}) async {
  //>print('(N12)${justCurrentUserAsModerator}');
  models.DocumentList docs;
  if (justCurrentUserAsTherapist) {
    docs = await listDocumentsWithOneQueryDocumentReference(
      collection: sessionsRef,
      attribute: kSessionTherapistId,
      value: currentUser!.reference,
      orderByAttribute: kDBcreatedAt,
    );
  } else {
    docs = await listDocuments(
      collection: sessionsRef,
      orderByAttribute: kDBcreatedAt,
    );
  }
  List<SessionsRecord> hh = [];
  for (models.Document d in docs.documents) {
    //>print('(N1)${d.$id}&&&&${d.data}');
    UsersRecord clientsRecord = await getUser(
      document: DocumentReference(path: (d.data[kSessionClientId] as String?)),
    );
    String clientDisplayName = clientsRecord.displayName!;
    SessionsRecord h = SessionsRecord(
      reference: DocumentReference(path: d.$id),
      clientId: DocumentReference(path: (d.data[kSessionClientId] as String?)),
      therapistId: DocumentReference(
        path: (d.data[kSessionTherapistId] as String?),
      ),
      $createdAt: DateTime.parse(d.$createdAt),
      $updatedAt: DateTime.parse(d.$updatedAt),
      clientDisplayName: clientDisplayName,
    );
    hh.add(h);
  }
  //>print('(N1AA)${hh.length}');
  return hh;
}

Future<void> setMaxVersionNumbersCurrentSessionStep() async {
  final int maxAudioVersion = await getMaxVersionNumber(
    bucketId: artTheopyAIRaudiosRef.path!,
    sessionStepId: currentSessionStep!.reference!.path!,
  );
  final int maxPhotoVersion = await getMaxVersionNumber(
    bucketId: artTheopyAIRphotosRef.path!,
    sessionStepId: currentSessionStep!.reference!.path!,
  );
  currentSessionStep!.maxAudioVersion = maxAudioVersion;
  currentSessionStep!.maxPhotoVersion = maxPhotoVersion;
  print(
    '(VC5)${currentSessionStep!.maxAudioVersion}....${currentSessionStep!.maxPhotoVersion}',
  );
}

Future<int> getMaxVersionNumber({
  required String bucketId,
  required String sessionStepId,
}) async {
  print('(DE79)${bucketId}....${sessionStepId}');
  models.FileList? fileList;
  try {
    fileList = await storage.listFiles(
      bucketId: bucketId,
      queries: [
        Query.contains(kAttrStorageId, sessionStepId),
        Query.limit(kLimitStorageListDocuments),
      ],
    );
    print('(DE80)${fileList}');
    print('(DE81.0)${fileList.files.length}');
    int maxVersion = 0;
    if (fileList.files.length > 0) {
      print('(DE81.1)${fileList.files.length}');
      // for (var file in fileList.files) {
      for (int i = 0; i < fileList.files.length; i++) {
        print('(DE81.2)${i}');
        var file = fileList.files[i];
        print('(DE81.3)${i}...${file.$id}');
        List<String> filenameSplit1 = file.$id.split('_');
        print('(DE81.4)${i}...${filenameSplit1}');
        List<String> filenameSplit2 = filenameSplit1[1].split('.');
        print('(DE81.5)${filenameSplit2}');
        int? version = int.tryParse(filenameSplit2[0]);
        print('(DE81.6)${version}');
        if (version == null) {
          version = 0;
        }
        if (version > maxVersion) {
          maxVersion = version;
        }
        print(
          '(DE82)${file.name}....${filenameSplit2[0]}----${version}----${maxVersion}',
        );
      }
    }
    return maxVersion;
  } on AppwriteException catch (e) {
    print('(DE83)${e}....${e.code}');
    return 0;
  }
}

Future<List<SessionStepsRecord>> listSessionStepList({
  bool justCurrentSession = true,
}) async {
  print('(SS12)${justCurrentSession}');
  models.DocumentList docs;
  if (justCurrentSession) {
    docs = await listDocumentsWithOneQueryDocumentReference(
      collection: sessionStepsRef,
      attribute: kSessionStepSessionId,
      value: currentSession!.reference,
      orderByAttribute: kSessionStepIndex,
    );
  } else {
    docs = await listDocuments(
      collection: sessionsRef,
      orderByAttribute: kDBcreatedAt,
    );
  }
  print('(SS16)${docs.documents.length}');
  List<SessionStepsRecord> hh = [];

  for (models.Document d in docs.documents) {
    int maxPhotoVersion = await getMaxVersionNumber(
      bucketId: artTheopyAIRphotosRef.path!,
      sessionStepId: d.$id,
    );
    int maxAudioVersion = await getMaxVersionNumber(
      bucketId: artTheopyAIRaudiosRef.path!,
      sessionStepId: d.$id,
    );
    print(
      '(SS13)${d.$id}&&&&${d.data[kSessionStepPhoto]}^^^^${maxPhotoVersion}',
    );
    SessionStepsRecord h = SessionStepsRecord(
      reference: DocumentReference(path: d.$id),
      sessionId: DocumentReference(
        path: (d.data[kSessionStepSessionId] as String?),
      ),
      photo: DocumentReference(path: (d.data[kSessionStepPhoto] as String?)),
      audio: DocumentReference(path: (d.data[kSessionStepAudio] as String?)),
      completed: d.data[kSessionStepCompleted] as bool,
      transcription: d.data[kSessionStepTranscription] as String,
      index: d.data[kSessionStepIndex] as int,
      question: d.data[kSessionStepQuestion] as String,
      maxPhotoVersion: maxPhotoVersion,
      maxAudioVersion: maxAudioVersion,
    );
    print('(SS40)${hh.length}....${h.photo}');
    hh.add(h);
    print('(SS41)${hh.length}');
  }
  print('(SS42)${hh.length}');
  return hh;
}

SessionStepsRecord extractSessionStepRecord(models.Document d) {
  print('(SS80)${d.$id}&&&&${d.data[kSessionStepPhoto]}');
  SessionStepsRecord h = SessionStepsRecord(
    reference: DocumentReference(path: d.$id),
    sessionId: DocumentReference(
      path: (d.data[kSessionStepSessionId] as String?),
    ),
    photo: DocumentReference(path: (d.data[kSessionStepPhoto] as String?)),
    audio: DocumentReference(path: (d.data[kSessionStepAudio] as String?)),
    completed: d.data[kSessionStepCompleted] as bool,
    transcription: d.data[kSessionStepTranscription] as String,
    index: d.data[kSessionStepIndex] as int,
    question: d.data[kSessionStepQuestion] as String,
  );
  return h;
}

Future<SessionsRecord> getSession({DocumentReference? document}) async {
  models.Document d = await getDocument(
    collection: sessionsRef,
    document: document,
  );
  ////>print('(M1)${doc.data['chapterColorInts'].runtimeType}****${doc.data['chapterColorInts']}');
  SessionsRecord h = SessionsRecord(
    reference: DocumentReference(path: d.$id),
    clientId: DocumentReference(path: (d.data[kSessionClientId] as String?)),
    therapistId: DocumentReference(
      path: (d.data[kSessionTherapistId] as String?),
    ),
    $createdAt: DateTime.parse(d.$createdAt),
    $updatedAt: DateTime.parse(d.$updatedAt),
  );
  //>print('(N5005)${h}');
  return h;
}

Future<SessionStepsRecord> getSessionStep({DocumentReference? document}) async {
  models.Document d = await getDocument(
    collection: sessionsRef,
    document: document,
  );
  ////>print('(M1)${doc.data['chapterColorInts'].runtimeType}****${doc.data['chapterColorInts']}');
  SessionStepsRecord h = SessionStepsRecord(
    reference: DocumentReference(path: d.$id),
    sessionId: DocumentReference(
      path: (d.data[kSessionStepSessionId] as String?),
    ),
    photo: DocumentReference(path: (d.data[kSessionStepPhoto] as String?)),
    audio: DocumentReference(path: (d.data[kSessionStepAudio] as String?)),
    completed: d.data[kSessionStepCompleted] as bool,
    transcription: d.data[kSessionStepTranscription] as String,
    index: d.data[kSessionStepIndex] as int,
    question: d.data[kSessionStepQuestion] as String,
    $createdAt: DateTime.parse(d.$createdAt),
    $updatedAt: DateTime.parse(d.$updatedAt),
  );
  //>print('(N5005)${h}');
  return h;
}

Future<List<UsersRecord>> listUsersListWithEmail({String? email}) async {
  models.DocumentList docs;
  //>print('(N2106)${email}¤¤¤¤${usersRef}');
  if (email == null) {
    docs = await listDocuments(collection: usersRef);
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
    collection: constraintsRef,
    orderByAttribute: 'level',
  );
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
    for (int i = 0; i < colorArray.length; i++) {
      prefMap['color${i.toString()}'] = colorArray[i].value;
    }
    var response = await account.updatePrefs(prefs: prefMap);
    models.Preferences prefs = await account.getPrefs();
    //>print('(N56)${prefs.data['color0']}****${response.prefs}');
    ;
  }
}

Future<UsersRecord?> appwriteLogin(
  BuildContext context,
  String email,
  String password,
) async {
  models.User? user;
  models.Session? session;
  print('(N91A)${email}****${password}');
  try {
    session = await account!.createEmailPasswordSession(
      email: email,
      password: password,
    );
  } on AppwriteException catch (e) {
    print('(N91B)${e.type}****${e.message}');
    if (e.message!.startsWith('Creation of a session is prohibited')) {
      print('(N91C)${email}****${password}');

      try {
        await appwriteLogout();
      } on AppwriteException catch (e) {
        print('(N91D)${e.type}****${e.message}');
        toast(context, 'Error on logging in 1', ToastKind.error);
      }
      print('(N91E)${email}****${password}');
      loggedIn = false;
      try {
        session = await account!.createEmailPasswordSession(
          email: email,
          password: password,
        );
      } on AppwriteException catch (e) {
        print('(N91FA)${e.type}****${e.message}');
        toast(context, 'Error on logging in 2', ToastKind.error);
      }
    }
  }

  try {
    user = await account!.get();
  } on AppwriteException catch (e) {
    print('(N91FB)${e.type}****${e.message}');
    toast(context, 'Error on logging in 3', ToastKind.error);
  }

  if (user == null) {
    toast(context, 'Error on logging in 4', ToastKind.error);
  }

  print('(N91G)${user}');
  print('(N91H)${user!.name}++++${user!.$id}');

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
  if ((role == null) || (role == '') || (role == kRoleNotLoggedIn)) {
    //>print('(N404R)${role}');
    return false;
  } else {
    if ((role == kRoleSupervisor) || (role == kRoleAdministrator)) {
      //>print('(N404S)${role}');
      return true;
    } else {
      //>print('(N404T)${role}');
      if ((role == kRoleTherapist) &&
          (session.therapistId!.path == currentUser!.reference!.path)) {
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
  final String truncatedName = (name!.length > 15)
      ? name.substring(0, 15)
      : name;
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
    bucketId: artTheopyAIRphotosRef.path!,
    fileId: fileId,
  );
  //String url = file.
  //>print('(IS1)${file.toString()}++++${result.name}@@@@${file.name}~~~~');

  const String head = imageFilenameHead;
  final b_id = artTheopyAIRphotosRef.path!;
  final f_id = fileId;
  final p_id = kProjectID;
  final String url =
      '${head}/${b_id}/files/${f_id}/preview?project=${p_id}&mode=admin';
  //>print('(IS2)${head}££££${url}????');

  return url;
}

Future<String?> storeStorageFile({
  required String? bucketId,
  required String? storageFilename,
  required String? localFilePath,
}) async {
  print('(AU30)${bucketId},,,,${storageFilename}...${localFilePath}');
  models.File result = await storage.createFile(
    bucketId: bucketId!,
    fileId: storageFilename!,
    file: InputFile.fromPath(path: localFilePath!),
  );
  var file = await storage.getFile(bucketId: bucketId, fileId: storageFilename);
  print('(AU62)${file.toString()}++++${result.name}@@@@${file.name}~~~~');
  const String head = imageFilenameHead;
  final b_id = artTheopyAIRphotosRef.path!;
  final f_id = storageFilename;
  final p_id = kProjectID;
  final String url =
      '${head}/${b_id}/files/${f_id}/preview?project=${p_id}&mode=admin';
  print('(AU63)${head}££££${url}????');
  return url;
}

Future<String?> getStorageFileDownload({
  String? bucketId,
  models.File? file,
}) async {
  String? localBucketId = bucketId;
  if (bucketId == null) {
    localBucketId = backupStorageRef.path!;
  }
  Uint8List bytes = await storage.getFileDownload(
    bucketId: backupStorageRef.path!,
    fileId: file!.$id,
  );
  String s = utf8.decode(bytes);
  //>print('(XY30)${file!.$id}++++${bytes.length}****${s}');
  return s;
}

Future<void> deleteFile(String path) async {
  dartio.File file = dartio.File(path);
  try {
    if (await file.exists()) {
      await file.delete();
    }
  } catch (e) {
    print('(DE50)${e}....${path}');
  }
}

Future<bool> copyStorageFiletoLocal({
  required String? bucketId,
  required String? fileId,
  required String? localPath,
  required FileKind? fileKind,
}) async {
  await deleteFile(localPath!);
  String? localBucketId = bucketId;
  if (bucketId == null) {
    localBucketId = backupStorageRef.path!;
  }
  print('(DE70A)${fileId}....${localPath}');
  String token = '';
  switch (fileKind) {
    case FileKind.audio:
      token = 'audio';
      break;
    case FileKind.photo:
      token = 'photo';
      break;
    case FileKind.video:
      token = 'video';
      break;
    case null:
      break;
  }
  final utf8Encoder = utf8.encoder;
  List<String> dirPath = localPath.split('/${token}');
  print('(DE70B)${dirPath[0]}');
  var dir = Directory.fromRawPath(utf8Encoder.convert(dirPath[0]));
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    print('(DE71)${entity.path}');
    if (entity.path.contains(token)) {
      File file = File(entity.path);
      print('DE72)${entity.path}');
      await file.delete();
    }
  }
  print('(DE73)${localBucketId},,,,${fileId}----${dirPath[0]}...${dirPath[1]}');
  await storage
      .getFileDownload(bucketId: localBucketId!, fileId: fileId!)
      .then((bytes) {
        print('(DE74)${bytes.length}....${localPath}');
        final file = File(localPath);
        file.writeAsBytesSync(bytes);
      })
      .catchError((error) {
        print('(DE75)${error.response}');
      });

  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    print('(DE76)${entity.path}');
  }

  return true;
}

Future<String?> readStorageFile({
  required DocumentReference? user,
  required String? hyperbookTitle,
  required int? versionNumber,
}) async {
  String expandedFilename =
      user!.path! +
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

Future<void> deleteStorageFile({
  required String? bucketId,
  required String? fileId,
}) async {
  await storage.deleteFile(bucketId: bucketId!, fileId: fileId!);
  print('(AU110)${fileId}');
}

Future<models.FileList> listStorageFiles({String? bucketId}) async {
  print(
    '(XY6)${bucketId}....${kAttrStorageName}----${currentSessionStep!.reference!.path}',
  );
  models.FileList fileList = models.FileList(total: 0, files: []);
  try {
    fileList = await storage.listFiles(
      bucketId: bucketId!,
      queries: [
        Query.contains(kAttrStorageId, currentSessionStep!.reference!.path),
        Query.limit(kLimitStorageListDocuments),
      ],
    );
    print('(XY7A)${fileList.files.length}');
  } catch (e) {
    //>print('(XY9)${e.toString()}');
  }
  return fileList;
}

Future<void> deleteImagesInChapter({required DocumentReference chapter}) async {
  //>print('(MI5)${chapter.path}');
  models.FileList fileList = await storage.listFiles(
    bucketId: artTheopyAIRphotosRef.path!, // bucketId
    queries: [
      Query.contains("name", [chapter.path]),
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
  print('(RW1)');
  // await localDB.dumpLocalDB();
  if (kIsWeb) {
    print('(RW2)${currentUser}');
    String? message = currentUser!.userMessage;
    print('(RW3)');
    bool showMessage = ((message != null) && (message != ''));
    print('(RW4)${message}....${showMessage}````${versionNumber}');
    if (showMessage) {
      List<String> splitMessage = message.split(kMessageSpitCharacter);
      if (message.contains(kMessageSpitCharacter)) {
        int? versiontoUpgradeTo = int.tryParse(splitMessage[1]);
        print('(RW5)${versiontoUpgradeTo}');
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
