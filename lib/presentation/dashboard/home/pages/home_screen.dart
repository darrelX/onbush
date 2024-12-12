import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/theme/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/shared/widget/carrousel/app_carousel_widget.dart';
import 'package:onbush/presentation/dashboard/home/widgets/dashboard_summary_widget.dart';

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
                                          "Deviens Parrain, Partage et Récolte des Récompenses !",
                                          style: context.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontSize: 17.r,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.white),
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                        )),
                                    AppButton(
                                      text: "Devenir Parrain",
                                      bgColor: AppColors.sponsorButton,
                                      onPressed: () {
                                        context.router
                                            .push(const AmbassadorSpaceRoute());
                                      },
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
                        "Donnees disponibles",
                        style: context.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Gap(10.h),
                      DashboardSummaryWidget(
                        numberOfCourses: 12,
                        numberOfTD: 13,
                        processedTopics: 6,
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
                    _Shortcut(title: "Fiches de TD"),
                    _Shortcut(title: "Sujets d'examens"),
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
