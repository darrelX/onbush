import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/shared/widget/app_snackbar.dart';
import 'package:onbush/core/shared/widget/base_indicator/app_base_indicator.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/domain/entities/course/course_entity.dart';
import 'package:onbush/domain/entities/subject/subject_entity.dart';
import 'package:onbush/presentation/blocs/academic/academy/academy_cubit.dart';
import 'package:onbush/presentation/blocs/pdf/pdf_file/pdf_file_cubit.dart';
import 'package:onbush/service_locator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

@RoutePage()
class CourseScreen extends StatefulWidget {
  final SubjectEntity subjectEntity;
  final String category;

  const CourseScreen({
    super.key,
    required this.subjectEntity,
    required this.category,
  });

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final AcademyCubit _academyCubit;

  @override
  void initState() {
    super.initState();
    _academyCubit = getIt<AcademyCubit>();

      _academyCubit.fetchCourseEntity(
        subjectId: widget.subjectEntity.id!,
        category: widget.category,
      );
  }

  Future<void> _onRefresh() async {
    if (widget.subjectEntity.id != null) {
      await _academyCubit.fetchCourseEntity(
        subjectId: widget.subjectEntity.id!,
        category: widget.category,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.subjectEntity.name ?? 'Inconnu'),
      ),
      body: BlocProvider.value(
        value: _academyCubit,
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(30.h),
                Text(
                  widget.subjectEntity.name ?? 'Inconnu',
                  style: context.textTheme.headlineMedium,
                ),
                Gap(20.h),
                Expanded(
                  child: BlocBuilder<AcademyCubit, AcademyState>(
                    builder: (context, state) {
                      if (state is CourseStateFailure) {
                        return _buildErrorState();
                      }
                      if (state is CourseStateLoading) {
                        return _buildLoadingIndicator();
                      }
                      if (state is CourseStateSuccess) {
                        return _buildCourseList(state);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return AppBaseIndicator.error400(
      message: "Vous avez un problème de connexion, réessayez",
      button: AppButton(
        text: "Recommencer",
        bgColor: AppColors.primary,
        width: context.width,
        onPressed: _onRefresh,
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: SizedBox(
        width: 100.0.r,
        height: 100.0.r,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildCourseList(CourseStateSuccess state) {
    if (_academyCubit.listCourseEntity.isEmpty) {
      return AppBaseIndicator.unavailableFileDisplay(
        message: "Aucun cours disponible pour le moment",
      );
    }
    return ListView.separated(
      separatorBuilder: (context, index) => Gap(10.h),
      itemCount: state.listCourseEntity.length,
      itemBuilder: (context, index) {
        final course = state.listCourseEntity[index];

        return BlocProvider(
          create: (context) => getIt<PdfFileCubit>(),
          child: _buildCourseItem(course),
        );
      },
    );
  }

  Widget _buildCourseItem(CourseEntity course) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: ListTile(
        onTap: () {
          if (course.status != Status.notDownloaded) {
            context.router
                .push(
              PdfViewRoute(category: widget.category, courseEntity: course),
            )
                .then((_) {
              _academyCubit.fetchCourseEntity(
                subjectId: widget.subjectEntity.id!,
                category: widget.category,
                fullRefresh: false,
              );
              setState(() {});
            });
          }
        },
        leading: _buildDownloadButton(course),
        title: Text(
          course.name ?? 'Cours inconnu',
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.r,
          color: AppColors.sponsorButton,
        ),
      ),
    );
  }

  Widget _buildDownloadButton(CourseEntity course) {
    return BlocConsumer<PdfFileCubit, PdfFileState>(
      listener: (context, pdfFileState) {
        print("pdfFileState $pdfFileState");

        if (pdfFileState is SavePdfFileSuccess) {
          log("Téléchargement terminé pour ${course.name}");
          _academyCubit.fetchCourseEntity(
            subjectId: widget.subjectEntity.id!,
            category: widget.category,
            fullRefresh: false,
          );
          setState(() {});
        }
        if (pdfFileState is PdfFileFailed) {
          AppSnackBar.showError(
              message: pdfFileState.message, context: context);
        }
      },
      builder: (context, pdfFileState) {
        final isDownloading = pdfFileState is PdfFileLoading &&
            course.status == Status.notDownloaded;
        final double progress = isDownloading ? pdfFileState.percent / 100 : 0;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isDownloading)
              CircularPercentIndicator(
                radius: 19.r,
                lineWidth: 2.r,
                percent: progress,
                center: Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(fontSize: 10.r),
                ),
                progressColor: AppColors.secondary,
              ),
            if (!isDownloading)
              AppButton(
                bgColor: AppColors.grey,
                onPressed: () => _downloadAndSaveFile(
                  context.read<PdfFileCubit>(),
                  pdfUrl: course.pdfUrl,
                  name: course.name,
                ),
                child: SvgPicture.asset(
                  height: 30.r,
                  width: 30.r,
                  _getCourseIcon(course.status),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _downloadAndSaveFile(
    PdfFileCubit pdfFileCubit, {
    required String? pdfUrl,
    required String? name,
  }) async {
    if (pdfUrl != null && name != null) {
      await pdfFileCubit.downloadAndSaveFile(
        url: pdfUrl,
        category: widget.category,
        name: name,
      );
    }
  }
}

String _getCourseIcon(Status status) {
  switch (status) {
    case Status.downloaded:
      return AppImage.courseDownloadedIcon;
    case Status.isOpened:
      return AppImage.courseOpened;
    default:
      return AppImage.downloadButton;
  }
}
