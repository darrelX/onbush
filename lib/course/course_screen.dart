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
class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final _carouselController = CarouselSliderController();
  String? pm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      body: SizedBox(
        width: context.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const Text(
                "Mes cours",
                style: TextStyle(fontWeight: FontWeight.bold),
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
            Gap(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const AppInput(
                hint: "Chercher un cours",
                prefix: Icon(Icons.search),
              ),
            ),
            Row(
              children: [Container()],
            ),
            Gap(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      'Crytograohie',
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
    );
  }
}
