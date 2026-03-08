import 'package:motion_toast/motion_toast.dart';
import 'package:flutter/material.dart';

enum ToastKind {success, warning, error}

void toast(BuildContext context, String message, ToastKind toastKind){
  void _displaySuccessMotionToast() {
    MotionToast toast = MotionToast.success(
      toastDuration: Duration(seconds : 5),
      description: Text(
        message,
        style: TextStyle(fontSize: 14),
      ),
      dismissable: true,
      opacity: .5,
    );
    toast.show(context);
  }
  void _displayWarningMotionToast() {
    MotionToast toast = MotionToast.warning(
      description: Text(
        message,
        style: TextStyle(fontSize: 14),
      ),
      dismissable: true,
      opacity: .5,
    );
    toast.show(context);
  }
  void _displayErrorMotionToast() {
    MotionToast toast = MotionToast.warning(
      description: Text(
        message,
        style: TextStyle(fontSize: 14),
      ),
      dismissable: true,
      opacity: .5,
    );
    toast.show(context);
  }
  switch(toastKind){
    case ToastKind.success:
      _displaySuccessMotionToast();
      break;
    case ToastKind.warning:
      _displayWarningMotionToast();
      break;
    case ToastKind.error:
      _displayErrorMotionToast();
      break;
  }
}