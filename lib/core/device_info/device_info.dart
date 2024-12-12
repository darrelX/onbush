import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DeviceInfo {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  /// Constructeur d'initialisation.
  DeviceInfo.init();

  /// Récupère les informations de l'appareil et les affecte à [deviceInfo].
  // void fetchDeviceInfo(Map<String, dynamic> deviceInfo) =>
  //     return await _initializeDeviceInfo(deviceInfo);

  Future<String> getInfoDevice(String info) async{
    return await  _initializeDeviceInfo(info);
  }

  /// Récupère les informations pour les appareils Android.
  static Map<String, String> _parseAndroidDeviceInfo(
      AndroidDeviceInfo androidInfo) {
    return {
      'version.securityPatch': androidInfo.version.securityPatch.toString(),
      'version.sdkInt': androidInfo.version.sdkInt.toString(),
      'version.release': androidInfo.version.release,
      'version.previewSdkInt': androidInfo.version.previewSdkInt.toString(),
      'version.incremental': androidInfo.version.incremental,
      'version.codename': androidInfo.version.codename,
      'version.baseOS': androidInfo.version.baseOS.toString(),
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
      'supported32BitAbis': androidInfo.supported32BitAbis.toString(),
      'supported64BitAbis': androidInfo.supported64BitAbis.toString(),
      'supportedAbis': androidInfo.supportedAbis.toString(),
      'tags': androidInfo.tags,
      'type': androidInfo.type,
      'isPhysicalDevice': androidInfo.isPhysicalDevice.toString(),
      'systemFeatures': androidInfo.systemFeatures.toString(),
      'serialNumber': androidInfo.serialNumber,
      'isLowRamDevice': androidInfo.isLowRamDevice.toString(),
    };
  }

  /// Récupère les informations pour les appareils iOS.
  Map<String, String> _parseIosDeviceInfo(IosDeviceInfo iosInfo) {
    return {
      'name': iosInfo.name,
      'systemName': iosInfo.systemName,
      'systemVersion': iosInfo.systemVersion,
      'model': iosInfo.model,
      'localizedModel': iosInfo.localizedModel,
      'identifierForVendor': iosInfo.identifierForVendor.toString(),
      'isPhysicalDevice': iosInfo.isPhysicalDevice.toString(),
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
  Future<String> _initializeDeviceInfo(String info) async {
    Map<String, String> deviceData;
    try {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          deviceData =
              _parseAndroidDeviceInfo(await _deviceInfoPlugin.androidInfo);
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
    return deviceData[info]!;
  }
}
