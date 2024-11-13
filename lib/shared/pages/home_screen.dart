import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/application/cubit/application_cubit.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/utils/const.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_carousel_widget.dart';
import 'package:onbush/shared/widget/app_dialog.dart';
import 'package:onbush/shared/widget/app_input.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CarouselSliderController _carouselController =
        CarouselSliderController();
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(15.h),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/account_image.png",
                        height: 43.h,
                        fit: BoxFit.fitHeight,
                      ),
                      Gap(5.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Salut",
                            style: context.textTheme.titleMedium!.copyWith(),
                          ),
                          Text(
                            "Annastasie",
                            style: context.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Niveau : 4",
                            style: context.textTheme.titleMedium!.copyWith(),
                          ),
                          Text(
                            "Enspd",
                            style: context.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(15.h),
                  Stack(
                    children: [
                      Container(
                        height: 180.h,
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 180.w,
                                    child: Text(
                                      "Deviens Ambassadeur, Partage et Récolte des Récompenses !",
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                              fontSize: 18.r,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.white),
                                      textAlign: TextAlign.left,
                                      maxLines: 3,
                                    )),
                                AppButton(
                                  text: "Devenir Ambassadeur",
                                  bgColor: AppColors.sponsorButton,
                                  width: 160.w,
                                  height: 35.h,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.r,
                                      color: AppColors.white),
                                )
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Positioned(
                          right: 10.r,
                          bottom: 0,
                          child: Image.asset(
                            "assets/images/5.png",
                            height: 170.h,
                            fit: BoxFit.fitHeight,
                          )),
                    ],
                  ),
                  Gap(20.h),
                  Text(
                    "Vos progrès",
                    style: context.textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Gap(10.h),
                  Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5.r, color: AppColors.ternary),
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 60.w,
                          height: 59.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/course.png",
                                width: 27.w,
                                fit: BoxFit.fitWidth,
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "10",
                                    style: context.textTheme.headlineMedium!
                                        .copyWith(
                                            fontSize: 24.r,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary),
                                  ),
                                  // Gap(5.h),
                                  Text(
                                    "Cours",
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                            fontSize: 10.r,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 90.w,
                          height: 50.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/pencil.png",
                                height: 36.h,
                                fit: BoxFit.fitHeight,
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "6",
                                    style: context.textTheme.headlineMedium!
                                        .copyWith(
                                            fontSize: 24.r,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary),
                                  ),
                                  // Gap(5.h),
                                  Text(
                                    "Sujets traites",
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                            fontSize: 10.r,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 85.w,
                          height: 59.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/course.png",
                                width: 27.w,
                                fit: BoxFit.fitWidth,
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "13",
                                    style: context.textTheme.headlineMedium!
                                        .copyWith(
                                            fontSize: 24.r,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary),
                                  ),
                                  // Gap(5.h),
                                  Text(
                                    "Fiches de TD",
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                            fontSize: 10.r,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(10.h),
                  Text(
                    "Raccourci",
                    style: context.textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Gap(10.h),
            AppCarouselWidget(
              carouselController: _carouselController,
              height: 180.h,
              viewportFraction: 0.39,
              children: const [
                _Shortcut(
                  title: "Resume de cours",
                ),
                _Shortcut(title: "Sujets d'examens"),
                _Shortcut(title: "Fiches de cours"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Shortcut extends StatelessWidget {
  final String title;
  const _Shortcut({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      margin: EdgeInsets.only(left: 19.w),
      width: 120.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(width: 2.r, color: AppColors.ternary),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 95.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(width: 2.r, color: AppColors.ternary),
              color: AppColors.ternary,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: context.textTheme.bodyMedium!
                .copyWith(fontSize: 14.r, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
