import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  void initialize(BuildContext context) {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (!context.mounted) return;
      String message = result == ConnectivityResult.none
          ? "No Internet Connection"
          : "Connected to the Internet";
      _showToast(context, message);
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
