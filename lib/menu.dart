import 'dart:math';
import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:hyperbook/flutter_flow/flutter_flow_theme.dart';

///import 'flutter_flow_widgets.dart';
import 'package:hyperbook/appwrite_interface.dart';
import '../../chapter_read/chapter_read_widget.dart';
import 'package:infinity_view/infinity_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

///import 'flutter_flow_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hyperbook/custom_code/widgets/appwrite_realtime_subscribe.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../custom_code/widgets/toast.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

///import 'package:gap/gap.dart';

class MenuDetails {
  List<String> menuLabelList = [];
  List<Icon> menuIconList = [];
  List<Function(BuildContext context)> menuTargets = [];
  List<Color> menuColorList = [];
  MenuDetails(
      {required this.menuLabelList,
      required this.menuIconList,
      this.menuColorList = kDefautltColorList,
      required this.menuTargets});
}

const kDefaultColor = Colors.white38;
const List<Color> kDefautltColorList = [
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
  kDefaultColor,
];




Widget insertMenu(
    BuildContext context, MenuDetails menuDetails, Function externalSetState) {
  return MenuAnchor(
    builder: (BuildContext context, MenuController controller, Widget? child) {
      return FlutterFlowIconButton(
        enabled: true,
        fillColor: Colors.white,
        tooltipMessage: 'Menu',
        borderColor: FlutterFlowTheme.of(context).primary,
        borderRadius: 30,
        borderWidth: 1,
        buttonSize: 40,
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        icon: kIconMenu,
        // tooltip: 'Show menu',
      );
    },
    menuChildren: List<MenuItemButton>.generate(
      menuDetails.menuLabelList.length,
      (int index) => MenuItemButton(
        leadingIcon: menuDetails.menuIconList[index],
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(menuDetails.menuColorList[index])),
        onPressed: () {
          externalSetState(() {
            //>print('(ME1)${index}++++${menuDetails.menuLabelList[index]}');
            menuDetails.menuTargets[index](context);
          });
          //>print('(ME2)');
        },
        child: PointerInterceptor(
            child: Container(child: Text(menuDetails.menuLabelList[index]))),
      ),
    ),
  );
}
