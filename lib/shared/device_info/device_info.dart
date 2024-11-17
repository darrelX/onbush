import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DeviceInfo {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  /// Constructeur d'initialisation.
  DeviceInfo.init();

  /// Récupère les informations de l'appareil et les affecte à [deviceInfo].
  void fetchDeviceInfo(Map<String, dynamic> deviceInfo) => _initializeDeviceInfo(deviceInfo);

  /// Récupère les informations pour les appareils Android.
  Map<String, dynamic> _parseAndroidDeviceInfo(AndroidDeviceInfo androidInfo) {
    return {
      'version.securityPatch': androidInfo.version.securityPatch,
      'version.sdkInt': androidInfo.version.sdkInt,
      'version.release': androidInfo.version.release,
      'version.previewSdkInt': androidInfo.version.previewSdkInt,
      'version.incremental': androidInfo.version.incremental,
      'version.codename': androidInfo.version.codename,
      'version.baseOS': androidInfo.version.baseOS,
      'board': androidInfo.board,
      'bootloader': androidInfo.bootloader,
      'brand': androidInfo.brand,
      'device': androidInfo.device,
      'display': androidInfo.display,
      'fingerprint': androidInfo.fingerprint,
      'hardware': androidInfo.hardware,
      'host': androidInfo.host,
      'id': androidInfo.id,
      'manufacturer': androidInfo.manufacturer,
      'model': androidInfo.model,
      'product': androidInfo.product,
      'supported32BitAbis': androidInfo.supported32BitAbis,
      'supported64BitAbis': androidInfo.supported64BitAbis,
      'supportedAbis': androidInfo.supportedAbis,
      'tags': androidInfo.tags,
      'type': androidInfo.type,
      'isPhysicalDevice': androidInfo.isPhysicalDevice,
      'systemFeatures': androidInfo.systemFeatures,
      'serialNumber': androidInfo.serialNumber,
      'isLowRamDevice': androidInfo.isLowRamDevice,
    };
  }

  /// Récupère les informations pour les appareils iOS.
  Map<String, dynamic> _parseIosDeviceInfo(IosDeviceInfo iosInfo) {
    return {
      'name': iosInfo.name,
      'systemName': iosInfo.systemName,
      'systemVersion': iosInfo.systemVersion,
      'model': iosInfo.model,
      'localizedModel': iosInfo.localizedModel,
      'identifierForVendor': iosInfo.identifierForVendor,
      'isPhysicalDevice': iosInfo.isPhysicalDevice,
      'utsname.sysname': iosInfo.utsname.sysname,
      'utsname.nodename': iosInfo.utsname.nodename,
      'utsname.release': iosInfo.utsname.release,
      'utsname.version': iosInfo.utsname.version,
      'utsname.machine': iosInfo.utsname.machine,
    };
  }

  /// Retourne le titre de l'application en fonction de la plateforme.
  String getAppBarTitle() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'Android Device Info';
      case TargetPlatform.iOS:
        return 'iOS Device Info';
      case TargetPlatform.linux:
        return 'Linux Device Info';
      case TargetPlatform.windows:
        return 'Windows Device Info';
      case TargetPlatform.macOS:
        return 'MacOS Device Info';
      case TargetPlatform.fuchsia:
        return 'Fuchsia Device Info';
      default:
        return 'Unknown Device Info';
    }
  }

  /// Initialise les informations de la plateforme et met à jour [deviceInfo].
  Future<void> _initializeDeviceInfo(Map<String, dynamic> deviceInfo) async {
    Map<String, dynamic> deviceData;
    try {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          deviceData = _parseAndroidDeviceInfo(await _deviceInfoPlugin.androidInfo);
          break;
        case TargetPlatform.iOS:
          deviceData = _parseIosDeviceInfo(await _deviceInfoPlugin.iosInfo);
          break;
        case TargetPlatform.fuchsia:
          deviceData = {'Error': 'Fuchsia platform isn\'t supported'};
          break;
        default:
          deviceData = {'Error': 'Unsupported platform'};
      }
    } on PlatformException catch (e) {
      deviceData = {'Error': 'Failed to retrieve platform data: ${e.message}'};
    }

    deviceInfo.addAll(deviceData);
  }
}
