import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

enum Status { connected, disconnected }

class MyObserver extends AutoRouteObserver {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();
  String? _currentRoute;
  Status status = Status.disconnected;
  bool _hasShownInitialConnection = false;

  MyObserver() {
    _initializeConnectivity();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
  }

  // // only override to observer tab routes
  // @override
  // void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
  //
  // }

  // @override
  // void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
  //
  // }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _currentRoute = route.settings.name;

    // _showConnectivitySnackBar();
  }

  void _initializeConnectivity() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        _updateConnectionStatus(result);
      },
    );
  }

  // Mise à jour de l'état de connexion
  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      status = Status.disconnected;
      _hasShownInitialConnection = true;
    } else {
      status = Status.connected;
    }
    if (_hasShownInitialConnection) {
      _showConnectivitySnackBar();
    }
  }

  void _showConnectivitySnackBar() {
    final message =
        status == Status.connected ? 'You are online' : 'You are offline';

    if (navigator?.context != null &&
        ScaffoldMessenger.maybeOf(navigator!.context) != null) {
      // Vérifiez si la route actuelle est différente de `ApplicationRoute`
      //
      if (_currentRoute != null || _currentRoute != "AppInitRoute") {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          var snackBar = SnackBar(
            content: Text(message),
            backgroundColor:
                status == Status.connected ? Colors.green : Colors.red,
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(navigator!.context).showSnackBar(snackBar);
        });
      }
    }
  }
}
