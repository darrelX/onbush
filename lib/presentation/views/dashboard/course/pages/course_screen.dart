import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/extensions/course_screen_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/shared/widget/app_input.dart';
import 'package:onbush/core/shared/widget/app_snackbar.dart';
import 'package:onbush/core/shared/widget/base_indicator/app_base_indicator.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/domain/entities/course/course_entity.dart';
import 'package:onbush/domain/entities/subject/subject_entity.dart';
import 'package:onbush/presentation/blocs/academic/academy/academy_cubit.dart';
import 'package:onbush/presentation/blocs/pdf/pdf_file/pdf_file_cubit.dart';
import 'package:onbush/presentation/views/dashboard/course/enums/category.dart';
import 'package:onbush/presentation/views/dashboard/course/widgets/academic_semester_tab.dart';
import 'package:onbush/service_locator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

@RoutePage()
class CourseScreen extends StatefulWidget {
  final SubjectEntity subjectEntity;
  final CategoryEnum category;

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
  int _currentIndex = 0;
  String _searchQuery = "";
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _academyCubit = getIt<AcademyCubit>();
    _fetchCourses();
  }

  Future<void> _fetchCourses({bool fullRefresh = true}) async {
    final subjectId = widget.subjectEntity.id;
    if (subjectId != null) {
      await _academyCubit.fetchCourseEntity(
        subjectId: subjectId,
        category: widget.category.apiLabel,
        fullRefresh: fullRefresh,
      );
      setState(() {});
    }
  }

  Future<void> _onRefresh() async => _fetchCourses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        title: Text(widget.subjectEntity.name ?? 'Inconnu'),
        actions: [
          AppButton(
            child: Image.asset(AppImage.downloadIcon),
            onPressed: () => context.router.pushAndPopUntil(
              const DownloadRoute(),
              predicate: (_) => false,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                widget.category.label,
                style: context.textTheme.headlineSmall,
              ),
            ),
            Gap(25.h),
            Expanded(child: _buildCourseList())
          ],
        ),
      ),
    );
  }

  Widget _buildCourseList() {
    return BlocBuilder<AcademyCubit, AcademyState>(
      bloc: _academyCubit,
      builder: (context, state) {
        if (state is CourseStateFailure) return _buildErrorState();
        if (state is CourseStateLoading) return _buildLoadingIndicator();

        final courses = _getFilteredCourses();

        if (courses.isEmpty) {
          return AppBaseIndicator.unavailableFileDisplay(
            message: "Aucune ressource disponible pour le moment",
            button: AppButton(
              text: "Recommencer",
              bgColor: AppColors.primary,
              width: context.width,
              onPressed: _onRefresh,
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: _buildSearchInput(),
            ),
            // Gap(20.h),
            // if (widget.category == CategoryEnum.examen ||
            //     widget.category == CategoryEnum.cc)
            //   _buildSemesterTabs(),
            Gap(20.h),
            // widget.category == CategoryEnum.cc ||
            //         widget.category == CategoryEnum.examen
            //     ? _buildSemesterTabs()
            //     : const SizedBox.shrink(),
            Gap(20.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                separatorBuilder: (_, __) => Gap(10.h),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return BlocProvider(
                    create: (_) => getIt<PdfFileCubit>(),
                    child: _buildCourseItem(courses[index]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchInput() {
    return AppInput(
      hint: "Chercher un cours",
      hintStyle: const TextStyle(color: AppColors.textGrey),
      width: context.width,
      colorBorder: AppColors.transparent,
      contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      onChange: _onSearchChanged,
      prefix: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: SvgPicture.asset(AppImage.searchIcon),
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

  Widget _buildErrorState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: AppBaseIndicator.unavailableFileDisplay(
        message: "Aucune ressource disponible pour le moment",
        button: AppButton(
          text: "Recommencer",
          bgColor: AppColors.primary,
          width: context.width,
          onPressed: _onRefresh,
        ),
      ),
    );
  }

  Widget _buildSemesterTabs() {
    return AcademySemesterTab(
      selectedText: AppColors.white,
      selectedIndex: _currentIndex,
      selectedColor: AppColors.primary,
      carouselController: _carouselController,
      onPressed: (index) {
        setState(() => _currentIndex = index);
        _fetchCourses();
      },
      listSemester: const ["Controle Continu", "Examens", "Rattrapage"],
    );
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value.toLowerCase();
    });
  }

  List<CourseEntity> _getFilteredCourses() {
    return _academyCubit.listCourseEntity.where((course) {
      return course.name?.toLowerCase().contains(_searchQuery) ?? false;
    }).toList();
  }

  Widget _buildCourseItem(CourseEntity course) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(9.r)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          log(course.status.toString());
          if (course.status != Status.notDownloaded) {
            context.router
                .push(
                  PdfViewRoute(
                    // category: "widget.category",
                    category: widget.category.label.toLowerCase(),
                    courseEntity: course,
                  ),
                )
                .then((_) => _fetchCourses(fullRefresh: false));
          }
        },
        leading: _buildDownloadButton(course),
        title: Text(
          course.name ?? 'Cours inconnu',
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 21.r,
            color: course.status == Status.isOpened
                ? AppColors.primary
                : AppColors.black,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios,
            size: 16.r, color: AppColors.sponsorButton),
      ),
    );
  }

  Widget _buildDownloadButton(CourseEntity course) {
    return BlocConsumer<PdfFileCubit, PdfFileState>(
      listener: (context, state) {
        if (state is SavePdfFileSuccess) {
          log("Téléchargement terminé pour ${course.name}");
          _fetchCourses(fullRefresh: false);
        }
        if (state is PdfFileFailed) {
          AppSnackBar.showError(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        final isDownloading =
            state is PdfFileLoading && course.status == Status.notDownloaded;
        final progress = isDownloading ? state.percent / 100 : 0.0;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isDownloading)
              CircularPercentIndicator(
                radius: 19.r,
                lineWidth: 2.r,
                percent: progress,
                center: Text("${(progress * 100).toInt()}%",
                    style: TextStyle(fontSize: 10.r)),
                progressColor: AppColors.secondary,
              ),
            if (!isDownloading)
              AppButton(
                bgColor: AppColors.grey,
                onPressed: () {
                  final pdfCubit = context.read<PdfFileCubit>();
                  if (course.pdfUrl != null && course.name != null) {
                    pdfCubit.downloadAndSaveFile(
                      url: course.pdfUrl!,
                      category: widget.category.apiLabel.toLowerCase(),
                      name: course.name!,
                    );
                  }
                },
                child: SvgPicture.asset(
                  _getCourseIcon(course.status),
                  height: 30.r,
                  width: 30.r,
                ),
              ),
          ],
        );
      },
    );
  }

  String _getCourseIcon(Status status) {
    return switch (status) {
      Status.downloaded || Status.isOpened => AppImage.courseOpened,
      _ => AppImage.courseDownloadedIcon,
    };
  }
}
