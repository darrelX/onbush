import 'package:onbush/core/constants/images/enums/enums.dart';

abstract class AppImage {
  static const String home = "assets/icons/home.svg";
  static const String homeActive = "assets/icons/home-active.svg";
  static const String courseInactive = 'assets/icons/course_inactive.svg';
  static const String person = 'assets/icons/user.svg';
  static const String ambassador = 'assets/icons/ambassador.svg';
  static const String ambassadorActive = 'assets/icons/ambassador_active.svg';
  static const String downloadIconCircle =
      'assets/icons/leading-icon-circle.png';
  static const String downloadIcon = 'assets/icons/leading-icon.png';
  static const String blueCourseIcon = 'assets/icons/course.png';
  static const String courseOpened = 'assets/icons/course_downloaded.svg';
  static const String notificationWhite = 'assets/icons/trailing-icon.png';
  static const String copy = 'assets/icons/copy.svg';
  static const String base = 'assets/icons/Icon.svg';
  static const String personMark = 'assets/icons/person_icon.svg';
  static const String pencil = "assets/icons/pencil.svg";
  static const String courseMark = "assets/icons/course_mark.svg";
  static const String searchIcon = "assets/icons/search.svg";
  static const String languageIcon = "assets/icons/language.svg";
  static const String messageIcon = "assets/icons/message.svg";
  static const String netwoekProblem = "assets/images/network_problem.svg";
  static const String onBush = "assets/icons/onbush_original.svg";
  static const String allOnBush = "assets/images/onBush.svg";
  static const String courseDownloadedIcon =
      "assets/icons/course_not_downloaded.svg";
  static const String downloadButton = "assets/icons/download_icon.svg";
  static const String bugIcon = "assets/icons/bug.svg";
  static const String clock = "assets/icons/clock.svg";

  static const String _basePath = "assets/avatars";
  static String getAvatarImage(Gender gender, AvatarState state) {
    final genderStr = gender.name; 
    final stateStr = state.name;
    return '$_basePath/${genderStr}_${stateStr}_avatar.png';
  }

  /// Avatars
  static const String avatar1 = "assets/avatars/avatar1.png";
  static const String avatar2 = "assets/avatars/avatar2.png";
  static const String avatar3 = "assets/avatars/avatar3.png";
  static const String avatar4 = "assets/avatars/avatar4.png";
  static const String avatar5 = "assets/avatars/avatar5.png";
  static const String avatar6 = "assets/avatars/avatar6.png";

  /// images
  static const String error400 = "assets/images/error_400.svg";
  static const String sponsorImage = "assets/images/5.png";
  static const String logo = "assets/images/logo.png";
  static const String image1 = "assets/images/1.jpeg";
  static const String image2 = "assets/images/2.png";
  static const String image3 = "assets/images/3.jpeg";
}
