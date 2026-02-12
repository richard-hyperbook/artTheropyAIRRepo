// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:hyperbook/appwrite_interface.dart';
class Permissions extends StatefulWidget {
  const Permissions({
    super.key,
    this.width,
    this.height,
    this.currentColorsIntsFromDatabase,
  });

  final double? width;
  final double? height;
  final List<int>? currentColorsIntsFromDatabase;

  @override
  _PermissionsState createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
  @override
  Widget build(BuildContext context) {
/*
    if ((FFAppState().chosenColors == null) ||
        (FFAppState().chosenColors.length != kColorStatusLength)) {
      if ((widget.currentColorsIntsFromDatabase! == null) ||
          (widget.currentColorsIntsFromDatabase!.length !=
              kColorStatusLength)) {
        FFAppState().chosenColors = List.from(kDefaultColors);
      } else {
        FFAppState().chosenColors =
            List.from(widget.currentColorsIntsFromDatabase!);
      }
    }
    */
    //%print(
      //  '(D60-1)${FFAppState().chosenColors}*${widget.currentColorsIntsFromDatabase!}');

    FFAppState().chosenColors.clear();
    for (int i = 0; i < widget.currentColorsIntsFromDatabase!.length; i++) {
      FFAppState()
          .chosenColors
          .add(Color(widget.currentColorsIntsFromDatabase![i]));
    }
    //%print(
     //   '(D60-2)${FFAppState().chosenColors}*${widget.currentColorsIntsFromDatabase!}');

    return Container();
  }
}

/*
Moderator Display Names are unique
Hyperbooks asre identified by Title and Moderator Display Name

*/

const String kEveryone = 'Everyone';
const String kReader = 'Reader';
const String kRequestingReader = 'Requesting Reader';
const String kRequestingWriter = 'Requesting Writer';
const String kWriter = 'Writer';
const String kOriginator = 'Originator';
const String kModerator = 'Moderator';
const String kAdministrator = 'Administrator';
const List<String> kRoles = <String>[
  kEveryone,
  kReader,
  kWriter,
  kOriginator,
  kModerator,
  kAdministrator
];

const String kCreate = 'Create';
const String kRead = 'Read';
const String kUpdate = 'update';
const String kDelete = 'Delete';
const List<String> kActions = <String>[kCreate, kRead, kUpdate, kDelete];

const String kPublic = 'Public';
const String kPrivate = 'Private';
const List<String> kVaialabilities = <String>[kPublic, kPrivate];

const int kNotVisitedIndex = 0;
const int kVisitedIndex = 1;
const int kPartiallyReadIndex = 2;
const int kFullyReadIndex = 3;
const int kHighlightedIndex = 4;
const int kDepredciatedIndex = 5;
const String kNotVisitedString = 'Not visited';
const String kVisitedString = 'Visited';
const String kPartiallyReadString = 'Partially read';
const String kFullyReadString = 'Fully Read';
const String kHighlightedString = 'Highlighted';
const String kDepredciatedString = 'Depreciated';
const String kAwaitingApprovalString = 'Awaiting approval';

const List<String> kChapterStateList = <String>[
  kNotVisitedString,
  kVisitedString,
  kPartiallyReadString,
  kFullyReadString,
  kHighlightedString,
  kDepredciatedString,
  kAwaitingApprovalString,
];
const List<Color> kDefaultColors = <Color>[
  Colors.black,
  Colors.lime,
  Colors.blueGrey,
  Colors.blue,
  Colors.amber,
  Colors.grey,
  Colors.red,
];
const int kColorStatusLength = 7;
bool areChaptersLoaded = false;

const String kRRA0 = 'No readers';
const String kRRA1 = 'Yes';
const String kRRA2 = 'No';
const String kRWA0 = 'No writers';
const String kRWA1 = 'Yes';
const String kRWA2 = 'No';

//List<HyperbooksRecord> hyperbookList = <HyperbooksRecord>[];
//£ List<ReadReferencesRecord> readReferenceList = <ReadReferencesRecord>[];
//List<ReadReferencesRecord> readReferenceListCurrentHyperbook = <ReadReferencesRecord>[];

bool filterByModerator = false;
const String before = ' <a href="#';
const String middle =
    '" target="_blank"style="background-color:black;color:white;padding:2px;border:2px solid grey;border-radius:5px">';
const String after = '</a>&nbsp;';
Map<DocumentReference, int> introductionReadStateIndex = <DocumentReference, int>{};
DocumentReference? hyperbookTutorialReference;

