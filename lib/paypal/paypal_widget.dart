import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '/auth/firebase_auth/auth_util.dart';
// import '/backend/backend.dart';
// import '/backend/firebase_storage/storage.dart';
import '../localDB.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'paypal_model.dart';
import '../../appwrite_interface.dart';
import 'package:appwrite/models.dart' as models;
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import '../../conditional.dart';
export 'paypal_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '/../custom_code/widgets/toast.dart';
// import '../../map_display/map_display_widget.dart';
import '../../hyperbook_edit/hyperbook_edit_widget.dart';
import '../../chapter_display/chapter_display_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

String? _accessToken;
DateTime? _tokenExpiry;
const _tokenBufferSeconds = 30;
final bool sandbox = false;
http.Client _http = http.Client();

// Map<String, dynamic> jsonResp = {};
List<String> upgradedUserIds = [];

const String clientId =
    'AfSp9ZPr_otDp1PWbO8sOnVewxTFGAWVAvJtSzKzv-T1S7aeAPBtR2Xxc4Nu8k59uyOBy11204yJVCKi';
const String secret =
    'EM-F2VJjRpE8pvuL7EH91bhtshGmYf0BqRn15qnqUSQQuZFs8tB4MmpwtKzB_f7upzYgmJKTqT3394UP';

class PayPalException implements Exception {
  final int statusCode;
  final dynamic body;
  PayPalException(this.statusCode, this.body);
  @override
  String toString() => 'PayPalException($statusCode): $body';
}

String get _baseUrl =>
    sandbox ? 'https://api.sandbox.paypal.com' : 'https://api.paypal.com';
Future<void> _ensureAccessToken() async {
  if (_accessToken != null &&
      _tokenExpiry != null &&
      DateTime.now().isBefore(
        _tokenExpiry!.subtract(Duration(seconds: _tokenBufferSeconds)),
      )) return;
  await _fetchAccessToken();
}

Future<void> _fetchAccessToken() async {
  var jsonRespAccessToken;
  final uri = Uri.parse('$_baseUrl/v1/oauth2/token');
  final creds = base64.encode(utf8.encode('$clientId:$secret'));
  final respAccessToken = await _http.post(
    uri,
    headers: {
      'Authorization': 'Basic $creds',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: 'grant_type=client_credentials',
  );
  print('(PQ1)${respAccessToken.statusCode}');
  print(respAccessToken.body);

  if (respAccessToken.statusCode < 200 || respAccessToken.statusCode >= 300) {
    throw PayPalException(respAccessToken.statusCode, respAccessToken.body);
  }
  //  var checkoutUrl = resp["approvalUrl"];
  //   var x =  _accessToken = jsonResp[["approvalUrl"] as String?;
  jsonRespAccessToken = json.decode(respAccessToken.body);
  _accessToken = jsonRespAccessToken['access_token'] as String?;
  final int? expiresIn = jsonRespAccessToken['expires_in'] as int?;
  print('(PQ2)${respAccessToken.statusCode}');
  print(respAccessToken);
  _tokenExpiry = DateTime.now().add(
    Duration(seconds: (expiresIn ?? 3600)),
  ); // fallback 1 hour if missing
}

Map<String, dynamic> _handleResponse(http.Response resp) {
  final status = resp.statusCode;
  final body = resp.body.isNotEmpty ? json.decode(resp.body) : null;
  print('(PQ5)${status}');
  print(resp);
  if (status >= 200 && status < 300) {
    return body is Map<String, dynamic> ? body : {'data': body};
  } else {
    throw PayPalException(status, body ?? resp.body);
  }
}

Map<String, String> _authHeaders() {
  return {
    'Content-Type': 'application/json',
    if (_accessToken != null) 'Authorization': 'Bearer $_accessToken',
  };
}

class PayPalWidget extends StatefulWidget {
  const PayPalWidget({super.key});

  @override
  _PayPalWidgetState createState() => _PayPalWidgetState();
}

class _PayPalWidgetState extends State<PayPalWidget> {
  late PayPalModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PayPalModel());

    _model.textController ??=
        TextEditingController(text: currentUserDisplayName);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    String? userId = currentUser!.reference!.path;
    bool isNotLoggedIn = (currentUser!.userLevel == kUserLevelNotLoggedIn);
    print('(PQ30)${userId}&&&&${isNotLoggedIn}');
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Hyperbooks',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Rubik',
              color: Colors.white,
              fontSize: 22.0,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                //# await loadCachedChaptersReadReferencesCachedHyperbookIndex(
                //#     hyperbook: tutorialHyperbook, user: currentUser);

                toast(context, 'Please wait while Hyperbook Tutorial loads',
                    ToastKind.success);


              },
              child: SvgPicture.asset(
                'assets/images/hyperbooklogosvg10.svg',
                width: 40,
                height: 40,
              ),
            ),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
            child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 1.0,
                child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Container(
                        child: Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FFButtonWidget(
                            onPressed: () async {
                              getPayPalListOfActiveSubs();
                            },
                            text: 'PP Query',
                            options: FFButtonOptions(
                              width: 130.0,
                              height: 50.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Rubik',
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                              elevation: 2.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          SizedBox(height:40),
                          (isNotLoggedIn)
                              ? Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.black)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Please login before upgrading'),
                                  ))
                              : activateShowPayPalButton(userId!),
                        ],
                      ),
                    ))))));
  }
}

Future<List<String>> getPayPalListOfActiveSubs() async {
  var jsonRespSubPlans;
  await _ensureAccessToken();
  print('(PQ3)');
  final uri = Uri.parse(
      '$_baseUrl/v1/billing/plans?sort_by=create_time&sort_order=desc');
  final respSubPlans = await _http.get(
    uri,
    headers: _authHeaders(),
    // body: json.encode(orderBody),
  );
  print('(PQ6)${respSubPlans.statusCode}');
  print(respSubPlans.body);
  jsonRespSubPlans = json.decode(respSubPlans.body);
  print('(PQ7)${jsonRespSubPlans.keys}');
  print(jsonRespSubPlans['plans'][0]);
  int noOfPlans = jsonRespSubPlans['plans'][0]['links'].length as int;
  print('(PQ8)${noOfPlans}');
  var respSubPlan;
  for (int i = 0; i < noOfPlans; i++) {
    String linkPlan = jsonRespSubPlans['plans'][0]['links'][i]['href'] as String;
    print('(PQ9)${i}++++${linkPlan}');
    final uriSubPlan = Uri.parse(linkPlan);
    respSubPlan = await _http.get(
      uri,
      headers: _authHeaders(),
      // body: json.encode(orderBody),
    );
    print('(PQ10)${respSubPlan.statusCode}');
    print(respSubPlan.body);
    print('(PQ11)${respSubPlan.reasonPhrase}');
    final uri3 = Uri.parse(
        '$_baseUrl/v1/billing/plans?sort_by=create_time&sort_order=desc');
    final resp = await _http.get(
      uri,
      headers: _authHeaders(),
      // body: json.encode(orderBody),
    );
  }
  final uriSubs = Uri.parse('$_baseUrl/v1/billing/subscriptions');
  final respSubs = await _http.get(
    uriSubs,
    headers: _authHeaders(),
    // body: json.encode(orderBody),
  );
  print('(PQ12)${respSubs.statusCode}');
  print(respSubs.body);
  var jsonRespSubs = json.decode(respSubs.body);
  int noOfSubs = jsonRespSubs['subscriptions'].length as int;
  print('(PQ13)${noOfSubs}');
  upgradedUserIds.clear();
  for (int j = 0; j < noOfSubs; j++) {
    var linkInfoSubs = jsonRespSubs['subscriptions'][j];
    print('(PQ14)${j}');
    print(linkInfoSubs['status']);
    print('(PQ15)${j}');
    print(linkInfoSubs);
    var linkToSub = (linkInfoSubs['links'][0]['href'] as String);
    print('(PQ16)${linkToSub}');
    final uriSub = Uri.parse(linkToSub);
    final respSub = await _http.get(
      uriSub,
      headers: _authHeaders(),
      // body: json.encode(orderBody),
    );
    print(respSub.body);
    var jsonRespSub = json.decode(respSub.body);
    String? subStatus = jsonRespSub['status'] as String?;
    String? userId = jsonRespSub['custom_id'] as String?;
    print('(PQ17)${subStatus}++++${userId}');
    if((subStatus != null) && (subStatus == 'ACTIVE') && (userId != null)){
      upgradedUserIds.add(userId);
    }
  }
  print('(PQ18)${upgradedUserIds.length}');
  print(upgradedUserIds);

  return upgradedUserIds;
}

Future<bool> isOKToCreateSession() async {
  bool oK = false;
  await loadConstraisMatrix();
  for(int i = 0; i < constraintsMatrix.length; i++){
    print('(CC20)${i}++++${constraintsMatrix[i].level}----${currentUser!.userLevel}');
    if(constraintsMatrix[i].level == currentUser!.userLevel){
      // List<HyperbooksRecord> currentHyperbooks = await listHyperbookList(justCurrentUserAsModerator: true);
      break;
    }
  }
  return oK;
}
