import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onbush/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:onbush/service_locator.dart';
// import 'package:path_provider/path_provider.dart';

_setupApplication() async {
  /// Hide status bar for splash screen
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  LicenseRegistry.addLicense(
    () async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    },
  );
  //  final directory = await getApplicationDocumentsDirectory();
}

bootstrap({
  required FutureOr<Widget> Function() builder,
}) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await dotenv.load(fileName: ".env");
      await _setupApplication();
      await setupLocator();

      runApp(await builder.call());
    },
    (error, stack) {
      if (kDebugMode) {
        print(error);
      }
    },
  );
}
