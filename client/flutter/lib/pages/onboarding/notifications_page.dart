import 'package:WHOFlutter/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsPage extends StatefulWidget {

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    return PermissionRequestPage(
      pageTitle: "Stay up to date on the Coronavirus",
      pageDescription: "To stay up to date with Coronavirus news, turn on app notifications from the World Health Organization.",
      buttonTitle: "Allow Notifications", // TODO: Localize
      backgroundImageSrc: "assets/onboarding/onboarding_notifications.png",
      onGrantPermission: _allowNotifications,
      onSkip: _skipNotifications,
    );
  }

  void _allowNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: false));

    
    _registerFCMToken();
    // TODO: Register token with web service

    _complete();
  }

  void _skipNotifications() async {
       _complete();
  }

  void _complete() async {
    Navigator.of(context).pop();
  }

  void _registerFCMToken() {
     _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);

      //TODO: Make call to web service to register the token. 

    });
  }
}
