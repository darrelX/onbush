import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/application/cubit/data_state.dart';
import 'package:onbush/core/application/data/models/subject_model.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/shared/widget/base_indicator/app_base_indicator.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';

@RoutePage()
class CourseScreen extends StatefulWidget {
  final SubjectModel subjectModel;
  final String category;
  const CourseScreen(
      {super.key, required this.subjectModel, required this.category});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ApplicationCubit>().fetchCourseModel(
        subjectId: widget.subjectModel.id!, category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.subjectModel.name!,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(30.h),
            Text(
              widget.subjectModel.name!,
              style: context.textTheme.headlineMedium!.copyWith(),
            ),
            Gap(50.h),
            Expanded(
              child: BlocBuilder<ApplicationCubit, ApplicationState>(
                builder: (context, state) {
                  if (state.listCourseModel!.status == Status.failure) {
                    return AppBaseIndicator.error400(
                      message: "Vous avez un probleme de connexion ressayer",
                      button: AppButton(
                        text: "Recommencer",
                        bgColor: AppColors.primary,
                        width: context.width,
                        onPressed: () => context
                            .read<ApplicationCubit>()
                            .fetchCourseModel(
                                subjectId: widget.subjectModel.id!,
                                category: widget.category),
                      ),
                    );
                  }
                  if (state.listCourseModel!.status == Status.loading) {
                    return Center(
                      child: SizedBox(
                          width: 100.0.r, // Largeur personnalisée
                          height: 100.0.r, // Hauteur personnalisée
                          child: const CircularProgressIndicator()),
                    );
                  }
                  if (state.listCourseModel!.status == Status.success) {
                    if (state.listCourseModel!.data!.isEmpty) {
                      return AppBaseIndicator.unavailableFileDisplay(
                          message: "Aucun cours disponible pour le moment");
                    }
                    return ListView.separated(
                      separatorBuilder: (context, index) => Gap(20.h),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.r),
                            // color: AppColors.white,
                          ),
                          child: ListTile(
                            onTap: () {
                              context.router.push(PdfViewRoute(
                                  category: widget.category,
                                  courseModel:
                                      state.listCourseModel!.data![index]));
                            },
                            leading: SvgPicture.asset(
                              "assets/icons/course_not_downloaded.svg",
                              // color: AppColors.primary,
                            ),
                            title: Text(
                              state.listCourseModel!.data![index].name,
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,
                                size: 16.r, color: AppColors.sponsorButton),
                          ),
                        );
                      },
                      itemCount: state.listCourseModel!.data!.length,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UnavailableFileDisplayWidget extends StatelessWidget {
  const UnavailableFileDisplayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/images/error_400.svg"),
        Gap(50.h),
        Text(
          "Le fichier que vous chercher n'est pas encore disponible",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.r,
          ),
          textAlign: TextAlign.center,
        ),
        Gap(70.h),
      ],
    );
  }
}
