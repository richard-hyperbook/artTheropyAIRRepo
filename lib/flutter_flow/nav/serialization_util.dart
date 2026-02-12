import 'dart:convert';

import 'package:flutter/material.dart';

// import '/backend/backend.dart';

import '../../flutter_flow/place.dart';
import '../../flutter_flow/uploaded_file.dart';
import 'package:hyperbook/appwrite_interface.dart';
import '../../flutter_flow/lat_lng.dart';


/// SERIALIZATION HELPERS

String dateTimeRangeToString(DateTimeRange dateTimeRange) {
  final String startStr = dateTimeRange.start.millisecondsSinceEpoch.toString();
  final String endStr = dateTimeRange.end.millisecondsSinceEpoch.toString();
  return '$startStr|$endStr';
}

String placeToString(FFPlace place) => jsonEncode(<String, String>{
      'latLng': place.latLng.serialize(),
      'name': place.name,
      'address': place.address,
      'city': place.city,
      'state': place.state,
      'country': place.country,
      'zipCode': place.zipCode,
    });

String uploadedFileToString(FFUploadedFile uploadedFile) =>
    uploadedFile.serialize();

const String _kDocIdDelimeter = '|';

String _serializeDocumentReference(DocumentReference ref) {
  return ref.path!;
}
  /*£String _serializeDocumentReference(DocumentReference ref) {
  final List<String> docIds = <String>[];
  DocumentReference? currentRef = ref;
  while (currentRef != null) {
    docIds.add(currentRef.id);
    // Get the parent document (catching any errors that arise).
    currentRef = safeGet<DocumentReference?>(() => currentRef?.parent.parent);
  }
  // Reverse the list to get the correct ordering.
  return docIds.reversed.join(_kDocIdDelimeter);
}*/

String? serializeParam(
  dynamic param,
  ParamType paramType, [
  bool isList = false,
]) {
  try {
    if (param == null) {
      return null;
    }
    if (isList) {
      final List<String> serializedValues = (param as Iterable)
          .map((p) => serializeParam(p, paramType))
          .where((String? p) => p != null)
          .map((String? p) => p!)
          .toList();
      return json.encode(serializedValues);
    }
    switch (paramType) {
      case ParamType.int:
        return param.toString();
      case ParamType.double:
        return param.toString();
      case ParamType.String:
        return param as String;
      case ParamType.bool:
        return (param as bool) ? 'true' : 'false';
      case ParamType.DateTime:
        return (param as DateTime).millisecondsSinceEpoch.toString();
      case ParamType.DateTimeRange:
        return dateTimeRangeToString(param as DateTimeRange);
      case ParamType.LatLng:
        return (param as LatLng).serialize();
/*      case ParamType.Color:
        return (param as Color).toCssString();*/
      case ParamType.FFPlace:
        return placeToString(param as FFPlace);
      case ParamType.FFUploadedFile:
        return uploadedFileToString(param as FFUploadedFile);
      case ParamType.JSON:
        return json.encode(param);
      case ParamType.DocumentReference:
        return _serializeDocumentReference(param as DocumentReference);
     /* case ParamType.Document:
        final DocumentReference reference = (param as FirestoreRecord).reference;
        return _serializeDocumentReference(reference);*/

      default:
        return null;
    }
  } catch (e) {
    //%//>print('Error serializing parameter: $e');
    return null;
  }
}

/// END SERIALIZATION HELPERS

/// DESERIALIZATION HELPERS

DateTimeRange? dateTimeRangeFromString(String dateTimeRangeStr) {
  final List<String> pieces = dateTimeRangeStr.split('|');
  if (pieces.length != 2) {
    return null;
  }
  return DateTimeRange(
    start: DateTime.fromMillisecondsSinceEpoch(int.parse(pieces.first)),
    end: DateTime.fromMillisecondsSinceEpoch(int.parse(pieces.last)),
  );
}

LatLng? latLngFromString(String latLngStr) {
  final List<String> pieces = latLngStr.split(',');
  if (pieces.length != 2) {
    return null;
  }
  return LatLng(
    double.parse(pieces.first.trim()),
    double.parse(pieces.last.trim()),
  );
}

FFPlace placeFromString(String placeStr) {
  final Map<String, dynamic> serializedData = jsonDecode(placeStr) as Map<String, dynamic>;
  final Map<String, dynamic> data = {
    'latLng': serializedData.containsKey('latLng')
        ? latLngFromString(serializedData['latLng'] as String)
        : const LatLng(0.0, 0.0),
    'name': serializedData['name'] ?? '',
    'address': serializedData['address'] ?? '',
    'city': serializedData['city'] ?? '',
    'state': serializedData['state'] ?? '',
    'country': serializedData['country'] ?? '',
    'zipCode': serializedData['zipCode'] ?? '',
  };
  return FFPlace(
    latLng: data['latLng'] as LatLng,
    name: data['name'] as String,
    address: data['address'] as String,
    city: data['city'] as String,
    state: data['state'] as String,
    country: data['country'] as String,
    zipCode: data['zipCode'] as String,
  );
}

FFUploadedFile uploadedFileFromString(String uploadedFileStr) =>
    FFUploadedFile.deserialize(uploadedFileStr);

DocumentReference _deserializeDocumentReference(
  String refStr,
  List<String> collectionNamePath,
) {
/*  String path = '';
  final List<String> docIds = refStr.split(_kDocIdDelimeter);
  for (int i = 0; i < docIds.length && i < collectionNamePath.length; i++) {
    path += '/${collectionNamePath[i]}/${docIds[i]}';
  }
  return FirebaseFirestore.instance.doc(path);*/
  return DocumentReference(path: refStr);
}

enum ParamType {
  int,
  double,
  String,
  bool,
  DateTime,
  DateTimeRange,
  LatLng,
  Color,
  FFPlace,
  FFUploadedFile,
  JSON,
  Document,
  DocumentReference,
}

dynamic deserializeParam<T>(
  String? param,
  ParamType paramType,
  bool isList, {
  List<String>? collectionNamePath,
}) {
  try {
    if (param == null) {
      return null;
    }
    if (isList) {
      final paramValues = json.decode(param);
      if (paramValues is! Iterable || paramValues.isEmpty) {
        return null;
      }
      return paramValues
          .whereType<String>()
          .map((String p) => p)
          .map((String p) => deserializeParam<T>(p, paramType, false,
              collectionNamePath: collectionNamePath))
          .where((p) => p != null)
          .map((p) => p! as T)
          .toList();
    }
    switch (paramType) {
      case ParamType.int:
        return int.tryParse(param);
      case ParamType.double:
        return double.tryParse(param);
      case ParamType.String:
        return param;
      case ParamType.bool:
        return param == 'true';
      case ParamType.DateTime:
        final int? milliseconds = int.tryParse(param);
        return milliseconds != null
            ? DateTime.fromMillisecondsSinceEpoch(milliseconds)
            : null;
      case ParamType.DateTimeRange:
        return dateTimeRangeFromString(param);
      case ParamType.LatLng:
        return latLngFromString(param);
/*      case ParamType.Color:
        return fromCssColor(param);*/
      case ParamType.FFPlace:
        return placeFromString(param);
      case ParamType.FFUploadedFile:
        return uploadedFileFromString(param);
      case ParamType.JSON:
        return json.decode(param);
      case ParamType.DocumentReference:
        return _deserializeDocumentReference(param, collectionNamePath ?? <String>[]);

      default:
        return null;
    }
  } catch (e) {
    //%//>print('Error deserializing parameter: $e');
    return null;
  }
}
/*

Future<dynamic> Function(String) getDoc(
  List<String> collectionNamePath,
  RecordBuilder recordBuilder,
) {
  return (String ids) => _deserializeDocumentReference(ids, collectionNamePath)
      .get()
      .then((DocumentSnapshot<Object?> s) => recordBuilder(s));
}

Future<List<T>> Function(String) getDocList<T>(
  List<String> collectionNamePath,
  RecordBuilder<T> recordBuilder,
) {
  return (String idsList) {
    List<String> docIds = <String>[];
    try {
      final Iterable ids = json.decode(idsList) as Iterable;
      docIds = ids.whereType<String>().map((String d) => d).toList();
    } catch (_) {}
    return Future.wait(
      docIds.map(
        (String ids) => _deserializeDocumentReference(ids, collectionNamePath)
            .get()
            .then((DocumentSnapshot<Object?> s) => recordBuilder(s)),
      ),
    ).then((List<T> docs) => docs.where((d) => d != null).map((d) => d!).toList());
  };
}
*/
