import 'main.dart';
import 'package:flutter/material.dart';
import 'appwrite_interface.dart';
import 'conditional_stub.dart'
    if (dart.library.io) 'conditional_io.dart'
    if (dart.library.html) 'conditional_web.dart';

void setIsIncomingResetPassword() {
  isIncomingResetPassword = determineIsIncomingResetPassword();
}

Widget activateShowPayPalButton(String userId) {
  return showPayPalButton(userId);
}

void listenForMessage(){
  webListenForMessage();
}
