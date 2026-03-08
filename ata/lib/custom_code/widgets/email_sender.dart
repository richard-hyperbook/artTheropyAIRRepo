
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import '../../appwrite_interface.dart';
import '../../localDB.dart';
import '/../custom_code/widgets/toast.dart';


enum EmailType { inviteUser, roleRequest, roleGrant, customBody }

Future<void> sendEmail({
  required BuildContext context,
  required EmailType emailType,
  required String senderDisplayName,
  required String senderEmail,
  required String hyperbookName,
  required String receiverEmail,
  String receiverDisplayName = 'Fred',
  String newRole = 'Unknown',
  String body = '',
}) async {
  final bodyJsonInviteUser =
      '''{ 
      "sender":{
      "name": "Hyperbook App",
      "email":"no_reply@hyperbook.co.uk"
      },
      "to":[
      {
      "email":"${receiverEmail}",
      "name":"_"
      }
      ],
      "subject":"Invitation to access my Hyperbook",
      "htmlContent":"<html><head></head><body><p>Hello,</p> This is an invitation to join my Hyperbook community. Click on this link: <a href='https://tin.syi.mybluehost.me/hyperbook/'>hyperbook</a>. Enter your email address (${receiverEmail}) and a password, click on <b>Login</b>. Click on <b>Tutorial</b> at the bottom of the sceen and follow the instructions. When you are ready, click on <b>Hyperbooks</b> and you will see a list including my hyperbook ${hyperbookName}.</p><br>${senderDisplayName}</body></html>"
      }
      ''';
  final bodyJsonRoleRequest =
      '''{ 
      "sender":{
      "name": "Hyperbook App",
      "email":"no_reply@hyperbook.co.uk"
      },
      "to":[
      {
      "email":"${receiverEmail}",
      "name":"${receiverDisplayName}"
      }
      ],
      "subject":"Request for a change of role in hyperbook ${hyperbookName}",
      "htmlContent":"<html><head></head><body><p>Hello ${receiverDisplayName},</p> ${senderDisplayName} (${senderEmail}) has requested that their role in hyperbook <b><i>${hyperbookName}</i></b> be changed to <b><i>${newRole}</i></b>.  Open the Hyperbook App, login and find <b><i>${hyperbookName}</i></b> in the list of hyperbooks.  Click on the settings icon and find this request. Click on that and decide whether to grant the request.</body></html>"
      }
      ''';
  final bodyJsonRoleGrant =
  '''{ 
      "sender":{
      "name": "Hyperbook App",
      "email":"no_reply@hyperbook.co.uk"
      },
      "to":[
      {
      "email":"${receiverEmail}",
      "name":"${receiverDisplayName}"
      }
      ],
      "subject":"Your request for new role in hyperbook ${hyperbookName} has been granted",
      "htmlContent":"<html><head></head><body><p>Hello ${receiverDisplayName},</p> ${senderDisplayName} (${senderEmail}) has responded to your request for a change of role in hyperbook ${hyperbookName} to ${newRole}.  Open the Hyperbook App, login and find ${hyperbookName} in the list of hyperbooks.  You will find that you now can access ${hyperbookName} according to your new Role.</body></html>"
      }
      ''';
  final bodyJsonCustomBody =
  '''{ 
      "sender":{
      "name": "Art Therapy AIR",
      "email":"no_reply@hyperbook.co.uk"
      },
      "to":[
      {
      "email":"${receiverEmail}",
      "name":"${receiverDisplayName}"
      }
      ],
      "subject":"A video is available from ${senderDisplayName}",
      "htmlContent":"<html><head></head><body><p>Hello ${body},</p> </body></html>"
      }
      ''';
  String bodyJson = '';
  switch (emailType) {
    case EmailType.inviteUser:
      bodyJson = bodyJsonInviteUser;
      break;
    case EmailType.roleRequest:
      bodyJson = bodyJsonRoleRequest;
      break;
    case EmailType.roleGrant:
      bodyJson = bodyJsonRoleGrant;
      break;
    case EmailType.customBody:
      bodyJson = bodyJsonCustomBody;
      break;
  }

  models.Document doc = await getDocument(
      collection: DocumentReference(path: '69a9253600091c44ad9f'),
      document: DocumentReference(path:  '69a925d2001d220fb19e'));
  final String value = doc.data['value'] as String;
  var response = await http.post(
    Uri.parse('https://api.brevo.com/v3/smtp/email'),
    headers: <String, String>{
      'accept': 'application/json',
      'api-key': value,

      'content-type': 'application/json;' 'charset=UTF-8',
    },
    //body: jsonEncode(<String, String>{'title': title}),
    body: bodyJson,
  );
  print(
      '(SE2)${response.body}****${response.statusCode}&&&&${response.request}@@@@${bodyJson}');
  if((response.statusCode >= 200) && (response.statusCode < 300)){
    toast(context, 'Email sent', ToastKind.success);
  } else {
    toast(context, 'Email not sent, status: ${response.statusCode}', ToastKind.error);
  }


  //"<html><head></head><body>XXX/body></html>"
  //>//>print('(SE1)${senderEmail}****${receiverEmail}££££${receiverDisplayName}||||${newRole}');
}
