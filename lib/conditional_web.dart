import 'package:web/web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:ui_web' as ui;
import 'dart:html';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

bool determineIsIncomingResetPassword() {
  String loadingParameter = '';
  bool result = false;
  //>print('(IN0)${window.location}++++${loadingParameter}****${result}');
  if (true /*kIsWeb*/ ) {
    List<String> locationSplit = window.location.toString().split('?');
    if (locationSplit.length >= 2) {
      loadingParameter = locationSplit[1];
      result =
          ((loadingParameter != null) && (loadingParameter.contains('reset')));
    }
    //>print('(IN1)${window.location}++++${loadingParameter}****${result}');
  }
  return result;
}

Widget showPayPalButton(String userId) {
  final String payPalButtonsHtml =
      '''
<div id="paypal-button-container-P-8PU421947Y7844259NFPDF2Y"></div>
<script src="https://www.paypal.com/sdk/js?client-id=AfSp9ZPr_otDp1PWbO8sOnVewxTFGAWVAvJtSzKzv-T1S7aeAPBtR2Xxc4Nu8k59uyOBy11204yJVCKi&vault=true&intent=subscription" data-sdk-integration-source="button-factory"></script>
<script>
paypal.Buttons({
style: {
shape: 'rect',
color: 'gold',
layout: 'vertical',
label: 'subscribe'
},
createSubscription: function(data, actions) {
return actions.subscription.create({
/* Creates the subscription */
plan_id: 'P-8PU421947Y7844259NFPDF2Y',
'custom_id': '${userId}'
});
},
onApprove: function(data, actions) {
alert(data.subscriptionID); // You can add optional success message for the subscriber here
}
}).render('#paypal-button-container-P-8PU421947Y7844259NFPDF2Y'); // Renders the PayPal button
</script>
''';

  print('(PQ40)');
  ui.platformViewRegistry.registerViewFactory(
    'hello-html',
    (int viewId) => IFrameElement()
      ..width = '640'
      ..height = '360'
      //..src = 'https://tin.syi.mybluehost.me/hyperbook/assets/assets/html/sub1.html'
      ..srcdoc = payPalButtonsHtml
      //(mapppedResponse['links'] as List)[1]['href']
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%',
  );
  print('(PQ41)');
  // runApp(
  return Padding(
    padding: EdgeInsets.all(25),
    child: SizedBox(
      width: 640,
      height: 360,
      child: HtmlElementView(viewType: 'hello-html'),
    ),
  );
  // );
  print('(PWT23)');
}

void webListenForMessage() {
  window.onMessage.listen((event) {
    var data = event.data;
    print('(PQ10)${data}');
    print(event);
  });
}
