import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/onboarding/pages/price_screen.dart';
import 'package:onbush/shared/application/cubit/application_cubit.dart';
import 'package:onbush/shared/application/cubit/data_state.dart';
import 'package:onbush/shared/application/data/models/course_model.dart';
import 'package:onbush/shared/application/data/models/subject_model.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';

@RoutePage()
class CourseScreen extends StatefulWidget {
  final SubjectModel subjectModel;
  final String instruction;
  const CourseScreen(
      {super.key, required this.subjectModel, required this.instruction});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ApplicationCubit>().fetchCourseModel(
        subjectId: widget.subjectModel.id!, instruction: widget.instruction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.subjectModel.name!),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(30.h),
            Text(
              widget.subjectModel.name!,
              style: context.textTheme.displaySmall!.copyWith(),
            ),
            Gap(50.h),
            BlocBuilder<ApplicationCubit, ApplicationState>(
              builder: (context, state) {
                if (state.listCourseModel!.status == Status.failure) {
                  return AppButton(
                    text: "Retry",
                    onPressed: () => context
                        .read<ApplicationCubit>()
                        .fetchCourseModel(
                            subjectId: widget.subjectModel.id!,
                            instruction: widget.instruction),
                  );
                }
                if (state.listCourseModel!.status == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.listCourseModel!.status == Status.success) {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Gap(20.h),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: AppColors.white,
                          ),
                          child: ListTile(
                            onTap: () {
                              context.router.push(PdfViewRoute(
                                  pdfUrl:
                                      state.listCourseModel!.data![index].pdf));
                            },
                            leading: Image.asset(
                              "assets/icons/course.png",
                              color: AppColors.primary,
                            ),
                            title: Text(
                              state.listCourseModel!.data![index].name,
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
                        );
                      },
                      itemCount: state.listCourseModel!.data!.length,
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
