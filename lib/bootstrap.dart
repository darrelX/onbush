import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onbush/presentation/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:onbush/my_bloc_observer.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/device_info/device_info.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final directory = await getApplicationDocumentsDirectory();
}

bootstrap({
  required FutureOr<Widget> Function() builder,
}) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
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
