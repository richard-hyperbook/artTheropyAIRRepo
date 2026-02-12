// Automatic FlutterFlow imports
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '/backend/backend.dart';
import '../../index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../main.dart';
import 'package:hyperbook/appwrite_interface.dart';
// import 'package:hyperbook/map_display/map_display_widget.dart';

class IconButtonTooltipMap extends StatefulWidget {
  const IconButtonTooltipMap(
      {super.key,
      this.width,
      this.height,
      this.currentHyperbook,
      this.tooltipMessage});

  final double? width;
  final double? height;
  final DocumentReference? currentHyperbook;
  final String? tooltipMessage;

  @override
  _IconButtonTooltipMapState createState() => _IconButtonTooltipMapState();
}

class _IconButtonTooltipMapState extends State<IconButtonTooltipMap> {
  @override
  Widget build(BuildContext context) {
    //%//>//>print('(D28)');
    String? message = widget.tooltipMessage;
    message ??= 'XXX';
    return Tooltip(
        message: message,
        child: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          // borderRadius: 30,
          borderWidth: 1,
          buttonSize: 30,
          icon: const FaIcon(
            FontAwesomeIcons.networkWired,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () async {
            setState(
                () => FFAppState().currentHyperbook = widget.currentHyperbook);
            //%//>//>print('(N1102)${0}');
            await /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const NavBarPage(initialPage: 'map_display'),
              ),
            );*/
            Navigator.push(
                context,
                PageTransition(
                  type: kStandardPageTransitionType,
                  duration:kStandardTransitionTime,
                  reverseDuration: kStandardReverseTransitionTime,
                  child: LoginWidget(),
                ));
          },
        ));
  }
}
