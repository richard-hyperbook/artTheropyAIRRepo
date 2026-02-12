/*
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appwrite_interface.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentReference _$DocumentReferenceFromJson(Map<String, dynamic> json) =>
    DocumentReference(
      path: json['path'] as String? ?? '0',
    );

Map<String, dynamic> _$DocumentReferenceToJson(DocumentReference instance) =>
    <String, dynamic>{
      'path': instance.path,
    };

SessionsRecord _$HyperbooksRecordFromJson(Map<String, dynamic> json) =>
    SessionsRecord(
      reference: json['reference'] == null
          ? null
          : DocumentReference.fromJson(
              json['reference'] as Map<String, dynamic>),
      moderator: json['moderator'] == null
          ? null
          : DocumentReference.fromJson(
              json['moderator'] as Map<String, dynamic>),
      title: json['title'] as String?,
      blurb: json['blurb'] as String?,
      startChapter: json['startChapter'] == null
          ? null
          : DocumentReference.fromJson(
              json['startChapter'] as Map<String, dynamic>),
      nonMemberRole: json['nonMemberRole'] as String?,
      modifiedTime: json['modifiedTime'] == null
          ? null
          : DateTime.parse(json['modifiedTime'] as String),
      createdTime: json['createdTime'] == null
          ? null
          : DateTime.parse(json['createdTime'] as String),
      moderatorDisplayName: json['moderatorDisplayName'] as String?,
    );

Map<String, dynamic> _$HyperbooksRecordToJson(HyperbooksRecord instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'moderator': instance.moderator,
      'title': instance.title,
      'blurb': instance.blurb,
      'startChapter': instance.startChapter,
      'nonMemberRole': instance.nonMemberRole,
      'createdTime': instance.createdTime?.toIso8601String(),
      'modifiedTime': instance.modifiedTime?.toIso8601String(),
      'moderatorDisplayName': instance.moderatorDisplayName,
    };

ConnectedUsersRecord _$ConnectedUsersRecordFromJson(
        Map<String, dynamic> json) =>
    ConnectedUsersRecord(
      reference: json['reference'] == null
          ? null
          : DocumentReference.fromJson(
              json['reference'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : DocumentReference.fromJson(json['user'] as Map<String, dynamic>),
      status: json['status'] as String?,
      displayName: json['displayName'] as String?,
      requesting: json['requesting'] as String?,
      parent: json['parent'] == null
          ? null
          : DocumentReference.fromJson(json['parent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConnectedUsersRecordToJson(
        ConnectedUsersRecord instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'user': instance.user,
      'status': instance.status,
      'displayName': instance.displayName,
      'requesting': instance.requesting,
      'parent': instance.parent,
    };

ChaptersRecord _$ChaptersRecordFromJson(Map<String, dynamic> json) =>
    ChaptersRecord(
      reference: json['reference'] == null
          ? null
          : DocumentReference.fromJson(
              json['reference'] as Map<String, dynamic>),
      title: json['title'] as String?,
      body: json['body'] as String?,
      author: json['author'] == null
          ? null
          : DocumentReference.fromJson(json['author'] as Map<String, dynamic>),
      xCoord: (json['xCoord'] as num?)?.toDouble(),
      yCoord: (json['yCoord'] as num?)?.toDouble(),
      createdTime: json['createdTime'] == null
          ? null
          : DateTime.parse(json['createdTime'] as String),
      modifiedTime: json['modifiedTime'] == null
          ? null
          : DateTime.parse(json['modifiedTime'] as String),
      parent: json['parent'] == null
          ? null
          : DocumentReference.fromJson(json['parent'] as Map<String, dynamic>),
      authorDisplayName: json['authorDisplayName'] as String?,
    );

Map<String, dynamic> _$ChaptersRecordToJson(ChaptersRecord instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'title': instance.title,
      'body': instance.body,
      'author': instance.author,
      'xCoord': instance.xCoord,
      'yCoord': instance.yCoord,
      'createdTime': instance.createdTime?.toIso8601String(),
      'modifiedTime': instance.modifiedTime?.toIso8601String(),
      'parent': instance.parent,
      'authorDisplayName': instance.authorDisplayName,
    };

UsersRecord _$UsersRecordFromJson(Map<String, dynamic> json) => UsersRecord(
      reference: json['reference'] == null
          ? null
          : DocumentReference.fromJson(
              json['reference'] as Map<String, dynamic>),
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      createdTime: json['createdTime'] == null
          ? null
          : DateTime.parse(json['createdTime'] as String),
      phoneNumber: json['phoneNumber'] as String?,
      chapterColorInts: (json['chapterColorInts'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      userReference: json['userReference'] == null
          ? null
          : DocumentReference.fromJson(
              json['userReference'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UsersRecordToJson(UsersRecord instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'email': instance.email,
      'displayName': instance.displayName,
      'createdTime': instance.createdTime?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'chapterColorInts': instance.chapterColorInts,
      'userReference': instance.userReference,
    };

ReadReferencesRecord _$ReadReferencesRecordFromJson(
        Map<String, dynamic> json) =>
    ReadReferencesRecord(
      reference: json['reference'] == null
          ? null
          : DocumentReference.fromJson(
              json['reference'] as Map<String, dynamic>),
      chapter: json['chapter'] == null
          ? null
          : DocumentReference.fromJson(json['chapter'] as Map<String, dynamic>),
      hyperbook: json['hyperbook'] == null
          ? null
          : DocumentReference.fromJson(
              json['hyperbook'] as Map<String, dynamic>),
      readStateIndex: (json['readStateIndex'] as num?)?.toInt(),
      xCoord: (json['xCoord'] as num?)?.toDouble(),
      yCoord: (json['yCoord'] as num?)?.toDouble(),
      parent: json['parent'] == null
          ? null
          : DocumentReference.fromJson(json['parent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReadReferencesRecordToJson(
        ReadReferencesRecord instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'chapter': instance.chapter,
      'hyperbook': instance.hyperbook,
      'readStateIndex': instance.readStateIndex,
      'xCoord': instance.xCoord,
      'yCoord': instance.yCoord,
      'parent': instance.parent,
    };

CachedHyperbook _$CachedHyperbookFromJson(Map<String, dynamic> json) =>
    CachedHyperbook(
          json['hyperbook'] == null
              ? null
              : HyperbooksRecord.fromJson(
              json['hyperbook'] as Map<String, dynamic>),
          (json['connectedUserList'] as List<dynamic>)
              .map((e) => ConnectedUsersRecord.fromJson(e as Map<String, dynamic>))
              .toList(),
          (json['chapterList'] as List<dynamic>)
              .map((e) => ChaptersRecord.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$CachedHyperbookToJson(CachedHyperbook instance) =>
    <String, dynamic>{
          'hyperbook': instance.hyperbook,
          'connectedUserList': instance.connectedUserList,
          'chapterList': instance.chapterList,
    };

HyperbookLocalDB _$HyperbookLocalDBFromJson(Map<String, dynamic> json) =>
    HyperbookLocalDB(
          hyperbook: json[kAttrBackupHyperbook] == null
              ? null
              : HyperbooksRecord.fromJson(
              json[kAttrBackupHyperbook] as Map<String, dynamic>),
          connectedUserList: (json[kAttrBackupConnectedUserList] as List<dynamic>)
              .map((e) => ConnectedUsersRecord.fromJson(e as Map<String, dynamic>))
              .toList(),
          chapterList: (json[kAttrBackupChapterList] as List<dynamic>)
              .map((e) => ChaptersRecord.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$HyperbookLocalDBToJson(HyperbookLocalDB instance) =>
    <String, dynamic>{
          kAttrBackupHyperbook: instance.hyperbook,
          kAttrBackupConnectedUserList: instance.connectedUserList,
          kAttrBackupChapterList: instance.chapterList,
    };

HyperbookUsers _$HyperbookUsersFromJson(Map<String, dynamic> json) =>
    HyperbookUsers(
      userList: (json['userList'] as List<dynamic>?)
          ?.map((e) => UsersRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      readReferenceList: (json['readReferenceList'] as List<dynamic>?)
          ?.map((e) => ReadReferencesRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HyperbookUsersToJson(HyperbookUsers instance) =>
    <String, dynamic>{
      'userList': instance.userList,
      'readReferenceList': instance.readReferenceList,
    };

HyperbookArchive _$HyperbookArchiveFromJson(Map<String, dynamic> json) =>
    HyperbookArchive(
      hyperbookLocalDB: json[kAttrBackupHyperbookLocalDB] == null
          ? null
          : HyperbookLocalDB.fromJson(
              json[kAttrBackupHyperbookLocalDB] as Map<String, dynamic>),
      hyperbookUsers: json[kAttrBackupUsers] == null
          ? null
          : HyperbookUsers.fromJson(
              json[kAttrBackupUsers] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HyperbookArchiveToJson(HyperbookArchive instance) =>
    <String, dynamic>{
          kAttrBackupHyperbookLocalDB: instance.hyperbookLocalDB,
          kAttrBackupUsers: instance.hyperbookUsers,
    };
*/
