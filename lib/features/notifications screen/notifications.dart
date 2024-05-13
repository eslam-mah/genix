import 'package:flutter/material.dart';
import 'package:genix/features/notifications%20screen/views/notificationsbody.dart';

class AppNotifications extends StatelessWidget {
  const AppNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NotificationsBody(),
    );
  }
}
