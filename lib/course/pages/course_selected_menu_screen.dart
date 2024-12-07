import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/shared/application/data/models/subject_model.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/theme/app_colors.dart';

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
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white,
              ),
              child: ListTile(
                onTap: () {
                  context.router.push(CourseRoute(
                      subjectModel: widget.subjectModel, category: "cours"));
                },
                leading: Image.asset(
                  "assets/icons/leading-icon.png",
                  color: AppColors.primary,
                ),
                title: Text(
                  'Resumes de cours',
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
            ),
            Gap(20.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white,
              ),
              child: ListTile(
                onTap: () {
                  context.router.push(CourseRoute(
                      subjectModel: widget.subjectModel,
                      category: "travauxdiriges"));
                },
                leading: Image.asset(
                  "assets/icons/pencil.png",
                  color: AppColors.primary,
                ),
                title: Text(
                  "Sujets d'examens",
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
            ),
            Gap(20.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white,
              ),
              child: ListTile(
                onTap: () {
                  context.router.push(CourseRoute(
                      subjectModel: widget.subjectModel,
                      category: "controlcontinus"));
                },
                leading: Image.asset(
                  "assets/icons/leading-icon.png",
                  color: AppColors.primary,
                ),
                title: Text(
                  'Fiches de TD',
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
            ),
          ],
        ),
      ),
    );
  }
}
