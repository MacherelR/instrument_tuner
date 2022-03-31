import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MicrophonePermissions {
  bool isEnabled = false;
  bool hasBeenRefused = false;
  Future<void> isGranted() async {
    isEnabled = await Permission.microphone.isGranted;
  }

  Future<void> RequestPermission() async {
    await Permission.microphone.request();
    isEnabled = await Permission.microphone.isGranted;
  }

  MicrophonePermissions() {
    isGranted();
  }
}
