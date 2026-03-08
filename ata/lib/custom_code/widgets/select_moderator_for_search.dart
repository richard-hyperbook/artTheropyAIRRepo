// Automatic FlutterFlow imports
import 'package:flutter/material.dart';

// import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../appwrite_interface.dart';

// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Automatic FlutterFlow imports
import 'permissions.dart';

// Begin custom widget code
class SelectModeratorForSearch extends StatefulWidget {
  const SelectModeratorForSearch({
    super.key,
    this.width,
    this.height,
    this.user,
  });

  final double? width;
  final double? height;
  final DocumentReference? user;

  @override
  _SelectModeratorForSearchState createState() =>
      _SelectModeratorForSearchState();
}

int _keyValue = 1;

class _SelectModeratorForSearchState extends State<SelectModeratorForSearch> {
  UsersRecord? chosenModerator;
  List<UsersRecord>? moderatorList;
  int kevValue = 1;

  @override
  void initState() {
    super.initState();
  }

  Widget showModeratorDropdown() {
    //%//>//>print('(D351)&$chosenModerator%$moderatorList');

    return SizedBox(
        width: 400,
        child: Form(
//key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Row(children: <Widget>[
              Text(
                'List hyperbooks from Moderator:',
                style: FlutterFlowTheme.of(context).bodyText2.override(
                      fontFamily: 'Rubik',
                      color: const Color(0xFF323B45),
                    ),
              ),
             /* Switch(
                  key: ValueKey<int>(_keyValue),
                  value: filterByModerator ??= true,
                  onChanged: (bool newValue) {
                    setState(() {
                      filterByModerator = newValue;
                      FFAppState().filterByModerator = newValue;
                      _keyValue++;
                    });
                  }),*/
              Expanded(
                flex: 5,
                child: DropdownButton<UsersRecord>(
                  key: ValueKey(widget),
                  value: chosenModerator,
                  hint: const Text('Please select moderator'),

                  items: moderatorList!
                      .map<DropdownMenuItem<UsersRecord>>((UsersRecord item) {
                    return DropdownMenuItem<UsersRecord>(
                      value: item,
                      child: Text(
                        item.displayName!,
                        // style: FlutterFlowTheme.bodyText1,
                      ),
                    );
                  }).toList(),
                  elevation: 2,
                  onChanged: (UsersRecord? value) {
                    setState(() {
                      chosenModerator = value;
                      FFAppState().chosenModerator = chosenModerator!.reference;
                    });

                    //%//>//>print('(D352)$chosenModerator');
                    // widget.onChanged(value);
                  },
                  //icon: widget.icon,
                  isExpanded: true,
                  //dropdownColor: widget.fillColor,
                  focusColor: Colors.transparent,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    Future<List<UsersRecord>> populateModerators() async {
      if ((moderatorList == null) || (moderatorList!.isEmpty)) {
        //%//>//>print('(D310-1)');
        //£moderatorList = await queryUsersRecordOnce();
        //%//>//>print('(D357)$moderatorList');
        chosenModerator = moderatorList![0];
        FFAppState().chosenModerator = chosenModerator!.reference;
      }
      return moderatorList!;
    }

    return FutureBuilder<void>(
        future: populateModerators(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasData) {
            //%//>//>print('(D356)$moderatorList£$chosenModerator');
            return showModeratorDropdown();
          } else {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              ),
            );
          }
        });
  }
}
