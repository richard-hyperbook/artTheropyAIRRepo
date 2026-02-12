import 'package:http/http.dart';
import 'dart:convert';

enum EmailType { inviteUser, roleRequest, roleGrant }

Future<void> sendEmail(
    {required EmailType emailType,
    required String senderDisplayName,
    required String senderEmail,
    required String hyperbookName,
    required String receiverEmail,
    String receiverDisplayName = '',
    String newRole = 'Unknown'}) async {

  final bodyJsonInviteUser = '''{ 
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
  final bodyJsonRoleRequest = '''{ 
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
  final bodyJsonRoleGrant = '''{ 
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
  }

  //"<html><head></head><body>XXX/body></html>"
  //>//>print('(SE1)${senderEmail}****${receiverEmail}££££${receiverDisplayName}||||${newRole}');


}
