import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

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
}

bootstrap({
  required FutureOr<Widget> Function() builder,
}) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      tz.initializeTimeZones();
      await dotenv.load(fileName: ".env");
      await setupLocator();
      await getIt.get<LocalStorage>().init();
      await _setupApplication();
      // Bloc.observer = MyBlocObserver();
      runApp(await builder.call());
    },
    (error, stack) {
      if (kDebugMode) {
        print(error);
      }
    },
  );
}
