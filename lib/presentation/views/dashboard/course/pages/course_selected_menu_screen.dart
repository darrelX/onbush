import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/application/data/models/subject_model.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';

@RoutePage()
class CourseSelectionMenuScreen extends StatefulWidget {
  final SubjectModel subjectModel;
  const CourseSelectionMenuScreen({super.key, required this.subjectModel});

  @override
  State<CourseSelectionMenuScreen> createState() =>
      _CourseSelectionMenuScreenState();
}

class _CourseSelectionMenuScreenState extends State<CourseSelectionMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        title: Text(widget.subjectModel.name!),
        centerTitle: true,
        actions: [
          Image.asset("assets/icons/leading-icon.png"),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Gap(30.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.r),
                color: AppColors.white,
              ),
              child: ListTile(
                onTap: () {
                  context.router.push(CourseRoute(
                      subjectModel: widget.subjectModel, category: "cours"));
                },
                leading: SvgPicture.asset(
                  "assets/icons/course_inactive.svg",
                  // color: AppColors.primary,
                ),
                title: Text(
                  'Resumes de cours',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 16, color: AppColors.sponsorButton),
              ),
            ),
            Gap(20.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.r),
                color: AppColors.white,
              ),
              child: ListTile(
                onTap: () {
                  context.router.push(CourseRoute(
                      subjectModel: widget.subjectModel,
                      category: "travauxdiriges"));
                },
                leading: SvgPicture.asset(
                  "assets/icons/pencil.svg",
                ),
                title: Text(
                  "Sujets d'examens",
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 16, color: AppColors.sponsorButton),
              ),
            ),
            Gap(20.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.r),
                color: AppColors.white,
              ),
              child: ListTile(
                onTap: () {
                  context.router.push(CourseRoute(
                      subjectModel: widget.subjectModel,
                      category: "controlcontinus"));
                },
                leading: SvgPicture.asset(
                  "assets/icons/course_mark.svg",
                  // color: AppColors.primary,
                ),
                title: Text(
                  ' Fiches de TD',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 16, color: AppColors.sponsorButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
