import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/presentation/views/dashboard/profil/widgets/editable_avatar_widget.dart';
import 'package:onbush/service_locator.dart';

@RoutePage()
class EditAvatarScreen extends StatefulWidget {
  final List<String> avatarList;

  const EditAvatarScreen({
    super.key,
    required this.avatarList,
  });

  @override
  State<EditAvatarScreen> createState() => EditAvatarScreenState();
}

class EditAvatarScreenState extends State<EditAvatarScreen> {
  int? _currentIndex;

  String thisAvatar() {
    return widget.avatarList[_currentIndex ?? 0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Editer Avatar"),
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.quaternaire,
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(30.h),
            Opacity(
              opacity: 0.7,
              child: EditableAvatarWidget(
                image: Image.asset(
                  _currentIndex == null
                      ? getIt.get<LocalStorage>().getString("avatar")!
                      : widget.avatarList[_currentIndex!],
                  fit: BoxFit.fill,
                  width: 150.r,
                  height: 150.r,
                ),
                subIcon: Container(
                    height: 42.r,
                    width: 42.r,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      margin: EdgeInsets.all(10.r),
                      child: SvgPicture.asset(
                        "assets/icons/pencil.svg",
                        color: AppColors.white,
                      ),
                    )),
              ),
            ),
            Gap(30.h),
            Expanded(
              child: Container(
                width: context.width,
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20.r)),
                child: Column(
                  children: [
                    Gap(20.h),
                    Text("Choisir un avatar",
                        style: TextStyle(
                            fontSize: 30.r,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold)),
                    Gap(20.h),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Nombre de colonnes
                            childAspectRatio:
                                1, // Ratio hauteur/largeur pour des carrés
                            mainAxisSpacing:
                                5, // Espacement vertical entre les lignes
                            crossAxisSpacing:
                                0, // Espacement horizontal entre les colonnes
                          ),
                          itemCount: widget.avatarList.length,
                          itemBuilder: (context, index) {
                            return EditableAvatarWidget(
                              size: 90.r,
                              onPressed: () {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                              isSelectable: index == _currentIndex,
                              image: Image.asset(
                                widget.avatarList[index],
                                fit: BoxFit.fill,
                              ),
                            );
                          }),
                    ),
                    // Gap(10.h),
                    IgnorePointer(
                      ignoring: _currentIndex == null,
                      child: Opacity(
                        opacity: _currentIndex == null ? 0.5 : 1,
                        child: AppButton(
                          text: "Sélectionner",
                          textColor: AppColors.white,
                          bgColor: AppColors.secondary,
                          onPressed: () {
                            if (_currentIndex != null) {
                              getIt.get<LocalStorage>().setString(
                                  'avatar', widget.avatarList[_currentIndex!]);
                              context.router.push(const EditProfilRoute());
                            }
                          },
                          width: context.width - 40.w,
                        ),
                      ),
                    ),
                    Gap(40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
