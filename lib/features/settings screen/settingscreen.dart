import 'package:flutter/material.dart';
import 'package:genix/features/settings%20screen/views/settingsbody.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SettingsBody(),
    );
  }
}
