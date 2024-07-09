import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryService {
  final Battery _battery = Battery();
  final int threshold = 90;

  void initialize(BuildContext context) {
    _battery.onBatteryStateChanged.listen((BatteryState state) async {
      if (state == BatteryState.charging) {
        if (!context.mounted) return; // Check if context is mounted
        int batteryLevel = await _battery.batteryLevel;
        if (batteryLevel >= threshold) {
          _showToast(context, "Battery level reached $threshold%");
          // Ringing functionality can be added here if necessary.
        }
      }
    });
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
