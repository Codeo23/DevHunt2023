import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constants/topic.dart';

class PushNotificationService {

  static Future<void> sendPushNotification(String title, String body) async {
    final message = {
      'notification': {
        'title': title,
        'body': body,
      },
      'priority': 'high',
      'to': '/topics/${Topic.postAdded}',
    };

    // Send the notification message to Firebase Cloud Messaging
    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAAQ90dkV8:APA91bGlPSyQyErExn3eRV9f-_ixxTI6b0vjyFyPfp_m6kfxmqk6UCf92IEQ1zuF5-IYgsHdtitYM3TRz59EQeQ9mpljEZfCchlDj9Aj00eeAkiKsMMdD6Ws1yEE1rEH-PZ2jQtGjJwM',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Push notification sent to topic ${Topic.postAdded} successfully');
    } else {
      print('Error sending push notification to topic ${Topic.postAdded}: ${response.body}');
    }
  }
}