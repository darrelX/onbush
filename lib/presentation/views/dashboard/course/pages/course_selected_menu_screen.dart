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
import 'package:onbush/presentation/views/dashboard/course/enums/category.dart';

enum Category { cours, td, examen, other }

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
            _buildCourseItem(
              title: 'Resumes de cours',
              iconPath: AppImage.courseInactive,
              category: CategoryEnum.cours,
              onTap: () {
                context.router.push(CourseRoute(
                  subjectEntity: widget.subjectEntity,
                  category: CategoryEnum.cours,
                ));
              },
            ),
            Gap(20.h),
            _buildCourseItem(
              title: 'Session Normale',
              iconPath: AppImage.pencil,
              category: CategoryEnum.sn,
              onTap: () {
                context.router.push(CourseRoute(
                    subjectEntity: widget.subjectEntity,
                    category: CategoryEnum.sn));
              },
            ),
            Gap(20.h),
            _buildCourseItem(
              title: 'Fiches de TD',
              iconPath: AppImage.courseMark,
              category: CategoryEnum.td,
              onTap: () {
                context.router.push(CourseRoute(
                    subjectEntity: widget.subjectEntity,
                    category: CategoryEnum.td));
              },
            ),
            Gap(20.h),
            _buildCourseItem(
              title: 'Controle Continu',
              iconPath: AppImage.pencil,
              category: CategoryEnum.cc,
              onTap: () {
                context.router.push(CourseRoute(
                    subjectEntity: widget.subjectEntity,
                    category: CategoryEnum.cc));
              },
            ),
            Gap(20.h),
            _buildCourseItem(
              title: 'Rattrapage',
              iconPath: AppImage.pencil,
              category: CategoryEnum.retake,
              onTap: () {
                context.router.push(CourseRoute(
                    subjectEntity: widget.subjectEntity,
                    category: CategoryEnum.retake));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseItem({
    required String title,
    required String iconPath,
    required CategoryEnum category,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.r),
        color: AppColors.white,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
        onTap: onTap,
        leading: SvgPicture.asset(iconPath),
        title: Text(
          title,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: AppColors.sponsorButton),
      ),
    );
  }
}
