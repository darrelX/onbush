import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbush/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:onbush/service_locator.dart';

_setupApplication() {
  /// Hide status bar for splash screen
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  LicenseRegistry.addLicense(
    () async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    },
  );
}

bootstrap({
  required FutureOr<Widget> Function() builder,
}) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      _setupApplication();
      setupLocator();
      runApp(

        MultiBlocProvider(providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
  
      ], child: await builder.call()));
    },
    (error, stack) {
      if (kDebugMode) {
        print(error);
      }
    },
  );
}
