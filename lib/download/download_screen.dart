import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_carousel_widget.dart';
import 'package:onbush/shared/widget/app_input.dart';

@RoutePage()
class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final _carouselController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [Image.asset("leading-icon-circle.png")],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: context.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  "Mes cours",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              ),
              Gap(20.h),
              AppCarouselWidget(
                carouselController: _carouselController,
                height: 40.h,
                viewportFraction: 0.35,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 18.w),
                    child: AppButton(
                      width: 120.w,
                      text: "Semestre 1",
                      bgColor: AppColors.grey,
                    ),
                  ),
                  AppButton(
                    width: 120.w,
                    text: "Semestre 2",
                    bgColor: AppColors.grey,
                  ),
                  AppButton(
                    width: 120.w,
                    text: "Semestre 3",
                    bgColor: AppColors.grey,
                  ),
                  AppButton(
                    width: 120.w,
                    text: "Semestre 4",
                    bgColor: AppColors.grey,
                  ),
                ],
              ),
              Gap(40.h),

              // Row(
              //   children: [Container()],
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppInput(
                      hint: "Chercher un cours",
                      width: context.width,
                      prefix: Icon(Icons.search),
                    ),
                    ListTile(
                      onTap: () {
                        // context.router.push(const AmbassadorSpaceRoute());
                      },
                      // leading: Icon(Icons.star),
                      title: Text(
                        'Espace ambassadeur',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xffA7A7AB),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        // context.router.push(const AmbassadorSpaceRoute());
                      },
                      // leading: Icon(Icons.star),
                      title: Text(
                        'Cryptographie',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xffA7A7AB),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        // context.router.push(const AmbassadorSpaceRoute());
                      },
                      // leading: Icon(Icons.star),
                      title: Text(
                        'Théorie de la décision',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xffA7A7AB),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        // context.router.push(const AmbassadorSpaceRoute());
                      },
                      // leading: Icon(Icons.star),
                      title: Text(
                        'Resaeu LAN',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xffA7A7AB),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
