// import '/backend/backend.dart';
import 'package:flutter/material.dart';
import '../../appwrite_interface.dart';

int convertTypeDropdownToInt(String? dropdownChoice) {
  int? type;
  type = int.tryParse(dropdownChoice!);
  return type ?? 0;
}

List<int> returnDefaultChapterColorsInts() {
  final List<int> defaultColors = <int>[
    Colors.black.value,
    Colors.lime.value,
    Colors.blueGrey.value,
    Colors.blue.value,
    Colors.amber.value,
    Colors.grey.value,
  ];
  return defaultColors;
}

Color setChapterColor(
  int? index,
  List<Color>? chapterReadColors,
) {
  if (index! < chapterReadColors!.length) {
    return chapterReadColors[index];
  } else {
    return Colors.pink;
  }
}

List<int> setCChosenColorsDatabaseFieldFromLocalState(List<Color>? colorList) {
  final List<int> intColors = <int>[];
  for (final Color color in colorList!) {
    intColors.add(color.value);
  }
  return intColors;
}

int getChapterStateFromList(
  int? index,
  List<int>? chapterStateList,
) {
  if ((index == null) ||
      (chapterStateList == null) ||
      (index >= chapterStateList.length)) {
    return 0;
  }
  return chapterStateList[index];
}

DocumentReference? returnChapterReadReference(
  int? index,
  List<DocumentReference>? currentHyperbookReadReferenceList,
) {
  if ((index == null) ||
      (currentHyperbookReadReferenceList == null) ||
      (index >= currentHyperbookReadReferenceList.length)) {
    return null;
  }
  return currentHyperbookReadReferenceList[index];
}

bool returnFalse() {
  return false;
}

bool returnTrue() {
  return true;
}

DocumentReference? returnNull() {
  return null;
}
