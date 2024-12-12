// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:onbush/my_bloc_observer.dart';
// // import 'network_observer.dart';

// class GlobalNetworkListener extends NavigatorObserver {
//   @override
//   void didPop(Route route, Route? previousRoute) {
//     super.didPop(route, previousRoute);
//     _showConnectivitySnackBar();
//   }

//   @override
//   void didPush(Route route, Route? previousRoute) {
//     super.didPush(route, previousRoute);
//     _showConnectivitySnackBar();
//   }

// void _showConnectivitySnackBar() {
//   final networkStatus = (Bloc.observer as NetworkObserver).status;
//   final message = networkStatus == Status.connected
//       ? 'You are online'
//       : 'You are offline';

//   scaffoldMessengerKey.currentState?.showSnackBar(
//     SnackBar(
//       content: Text(message),
//       backgroundColor:
//           networkStatus == Status.connected ? Colors.green : Colors.red,
//       duration: Duration(seconds: 2),
//     ),
//   );
// }
// }
