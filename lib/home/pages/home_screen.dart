import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/shared/application/cubit/application_cubit.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_carousel_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ApplicationCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = context.read<ApplicationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final CarouselSliderController _carouselController =
        CarouselSliderController();

    return BlocConsumer<ApplicationCubit, ApplicationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
                      Gap(10.h),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/account_image.png",
                            height: 43.h,
                            fit: BoxFit.fitHeight,
                          ),
                          Gap(5.w),
                          SizedBox(
                            height: 49.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Salut",
                                  style:
                                      context.textTheme.titleSmall!.copyWith(),
                                ),
                                Text(
                                  _cubit.userModel.name!,
                                  style: context.textTheme.titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                        const Shadow(
                                          offset: Offset(0.5, 0.5),
                                          blurRadius: 1.0,
                                          color: Colors.grey,
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 49.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Niveau : ${_cubit.userModel.academiclevel}",
                                  style:
                                      context.textTheme.titleSmall!.copyWith(),
                                ),
                                Text(
                                  "Enspd",
                                  style: context.textTheme.titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                        const Shadow(
                                          offset: Offset(0.5, 0.5),
                                          blurRadius: 1.0,
                                          color: Colors.grey,
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Gap(20.h),
                      Stack(
                        children: [
                          Container(
                            height: 190.h,
                            padding: EdgeInsets.all(20.r),
                            decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 180.w,
                                        child: Text(
                                          "Deviens Ambassadeur, Partage et Récolte des Récompenses !",
                                          style: context.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontSize: 17.r,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.white),
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                        )),
                                    AppButton(
                                      text: "Devenir Ambassadeur",
                                      bgColor: AppColors.sponsorButton,
                                      width: 158.w,
                                      height: 35.h,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.r,
                                          color: AppColors.white),
                                    )
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          Positioned(
                              right: 5.w,
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
                        style: context.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Gap(10.h),
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5.r, color: AppColors.ternary),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                              width: 105.w,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                              width: 95.w,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                      Gap(20.h),
                      Text(
                        "Raccourcis",
                        style: context.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Gap(5.h),
                AppCarouselWidget(
                  carouselController: _carouselController,
                  height: 170.h,
                  viewportFraction: 0.44,
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
      },
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
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      width: 140.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(width: 2.r, color: AppColors.ternary),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 90.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(width: 2.r, color: AppColors.ternary),
              color: AppColors.ternary,
            ),
          ),
          Text(
            title,
            style: context.textTheme.bodySmall!
                .copyWith(fontSize: 13.r, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
