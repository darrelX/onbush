import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum Status { connected, disconnected }

class MyBlocObserver extends BlocObserver {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  Status status = Status.disconnected;

  MyBlocObserver() {
    _initializeConnectivity();
  }

  void _initializeConnectivity() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        _updateConnectionStatus(result);
      },
    );
  }

  // Mise à jour de l'état de connexion
  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      status = Status.disconnected;
      print('Network Status: Disconnected');
    } else {
      status = Status.connected;
      print('Network Status: Connected');
    }
  }

  // Vous pouvez aussi ajouter une gestion des changements d'état globaux ici
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('Bloc Change: ${bloc.runtimeType}, $change');
  }
}
