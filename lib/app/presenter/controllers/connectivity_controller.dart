import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final connectivityStatusProvider =
    StateNotifierProvider<ConnectivityNotifier, ConnectivityResult>(
        (ref) => ConnectivityNotifier());

class ConnectivityNotifier extends StateNotifier<ConnectivityResult> {
  ConnectivityNotifier() : super(ConnectivityResult.none) {
    // Inicia la escucha de los cambios de conectividad
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      // _showConnectivityToast(result);
      state = result.first; // Actualiza el estado cada vez que hay un cambio
    });
  }

  void _showConnectivityToast(List<ConnectivityResult> result) {
    String connectionStatus = _getConnectionStatus(result.first);
    for (var element in result) {
      print("🛺 $element");
    }
    Fluttertoast.showToast(
      msg: connectionStatus,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }

  String _getConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return "Mobile data connection is being used.";
      case ConnectivityResult.wifi:
        return "Wi-Fi connection is being used.";
      case ConnectivityResult.bluetooth:
        return "Bluetooth connection is being used.";
      case ConnectivityResult.ethernet:
        return "Ethernet connection is being used.";
      case ConnectivityResult.vpn:
        return "VPN connection is being used.";
      case ConnectivityResult.none:
        return "No connection.";
      default:
        return "Unknown connection status.";
    }
  }

  Future<bool> get isConnected async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return _getConnectionStatusBool(connectivityResult.first);
  }

  bool _getConnectionStatusBool(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
        return true;
      default:
        return false;
    }
  }
}
