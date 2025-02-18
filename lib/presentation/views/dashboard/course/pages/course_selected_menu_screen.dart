import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/domain/entities/subject/subject_entity.dart';

@RoutePage()
class CourseSelectionMenuScreen extends StatefulWidget {
  final SubjectEntity subjectEntity;
  const CourseSelectionMenuScreen({super.key, required this.subjectEntity});

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
        title: Text(widget.subjectEntity.name!),
        centerTitle: true,
        actions: [
          Image.asset(AppImage.downloadIcon),
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
                      subjectEntity: widget.subjectEntity, category: "cours"));
                },
                leading: SvgPicture.asset(
                  AppImage.courseInactive,
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
                      subjectEntity: widget.subjectEntity,
                      category: "travauxdiriges"));
                },
                leading: SvgPicture.asset(
                  AppImage.pencil
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
                      subjectEntity: widget.subjectEntity,
                      category: "controlcontinus"));
                },
                leading: SvgPicture.asset(
                  AppImage.courseMark,
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
