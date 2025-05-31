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
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  int _currentIndex = 0;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _academyCubit = getIt<AcademyCubit>();
    _fetchCourses(); // Chargement initial
  }

  /// Recharge la liste des cours (optionnellement sans forcer le refresh complet)
  Future<void> _fetchCourses({bool fullRefresh = true}) async {
    final subjectId = widget.subjectEntity.id;
    if (subjectId != null) {
      await _academyCubit
          .fetchCourseEntity(
            subjectId: subjectId,
            category: widget.category.apiLabel,
            fullRefresh: fullRefresh,
          )
          .then((_) => setState(() {}));
    }
  }

  Future<void> _onRefresh() async {
    await _fetchCourses(fullRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.subjectEntity.name ?? 'Inconnu',
          style: context.textTheme.titleLarge!.copyWith(color: AppColors.white),
        ),
        actions: [
          AppButton(
            child: Image.asset(AppImage.downloadIcon),
            onPressed: () => context.router.push(const DownloadRoute()),
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
            if (widget.category == CategoryEnum.sn ||
                widget.category == CategoryEnum.retake) ...[
              Gap(20.h),
              _buildSnTabs(),
            ],
            Gap(25.h),
            Expanded(child: _buildCourseList()),
          ],
        ),
      ),
    );
  }

  /// Zone principale affichant la liste des cours
  Widget _buildCourseList() {
    return BlocBuilder<AcademyCubit, AcademyState>(
      bloc: _academyCubit,
      builder: (context, state) {
        if (state is CourseStateFailure) {
          return _buildErrorState();
        } else if (state is CourseStateLoading) {
          return _buildLoadingIndicator();
        }

        final filteredCourses = _getFilteredCourses();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: _buildSearchInput(),
            ),
            Gap(20.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: filteredCourses.length,
                separatorBuilder: (_, __) => Gap(10.h),
                itemBuilder: (context, index) {
                  final course = filteredCourses[index];
                  return BlocProvider(
                    create: (context) => getIt<PdfFileCubit>(),
                    child: Builder(builder: (context) {
                      return _buildCourseItem(course, context);
                    }),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  /// Champ de recherche pour filtrer les cours
  Widget _buildSearchInput() {
    return AppInput(
      hint: 'Chercher un cours',
      hintStyle: const TextStyle(color: AppColors.textGrey),
      width: context.width,
      colorBorder: AppColors.transparent,
      contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      prefix: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: SvgPicture.asset(AppImage.searchIcon),
      ),
      onChange: (value) {
        setState(() {
          _searchQuery = value.trim().toLowerCase();
        });
      },
    );
  }

  /// Indicateur de chargement
  Widget _buildLoadingIndicator() {
    return Center(
      child: SizedBox(
        width: 100.r,
        height: 100.r,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  /// État d’erreur si pas de cours disponibles
  Widget _buildErrorState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: AppBaseIndicator.unavailableFileDisplay(
        message: 'Aucune ressource disponible pour le moment',
        button: AppButton(
          text: 'Recommencer',
          bgColor: AppColors.primary,
          width: context.width,
          onPressed: _onRefresh,
        ),
      ),
    );
  }

  /// Onglets "Épreuves" / "Corrigés" pour CategoryEnum.sn et CategoryEnum.retake
  Widget _buildSnTabs() {
    return AcademySemesterTab(
      selectedText: AppColors.white,
      selectedIndex: _currentIndex,
      selectedColor: AppColors.primary,
      carouselController: _carouselController,
      onPressed: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      listSemester: const ['Épreuves', 'Corrigés'],
    );
  }

  /// Filtre la liste des cours en fonction de l’onglet actif et de la recherche
  List<CourseEntity> _getFilteredCourses() {
    final query = _searchQuery.trim().toLowerCase();
    return _academyCubit.listCourseEntity.where((course) {
      // 1) Filtrage selon l’onglet sélectionné
      final hasEpreuveOrPdfUrl = course.pdfEpreuve?.isNotEmpty == true ||
          course.pdfUrl?.isNotEmpty == true;
      final hasCorrige = course.pdfCorrige?.isNotEmpty == true;

      final matchesTab = (_currentIndex == 0 && hasEpreuveOrPdfUrl) ||
          (_currentIndex == 1 && hasCorrige) ||
          (_currentIndex > 1);

      // 2) Filtrage selon le texte de recherche (sur le nom)
      final nameLower = course.name?.toLowerCase() ?? '';
      final matchesSearch = query.isEmpty || nameLower.contains(query);

      return matchesTab && matchesSearch;
    }).toList();
  }

  /// Affiche un item de cours dans la liste
  Widget _buildCourseItem(CourseEntity course, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          if (course.status == Status.notDownloaded) {
            _downloadCourse(course, context);
          } else {
            _openPdfView(course);
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
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.r,
          color: AppColors.sponsorButton,
        ),
      ),
    );
  }

  /// Bouton indiquant le statut de téléchargement ou l’avancement en pourcentage
  Widget _buildDownloadButton(CourseEntity course) {
    return BlocConsumer<PdfFileCubit, PdfFileState>(
      listener: (context, state) {
        if (state is SavePdfFileSuccess) {
          log('Téléchargement terminé pour ${course.name}');
          _fetchCourses(fullRefresh: false);
        } else if (state is PdfFileFailed) {
          AppSnackBar.showError(
            message: state.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        final isDownloading =
            state is PdfFileLoading && course.status == Status.notDownloaded;
        final progress = isDownloading ? state.percent / 100 : 0.0;

        if (isDownloading) {
          return CircularPercentIndicator(
            radius: 19.r,
            lineWidth: 2.r,
            percent: progress,
            center: Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(fontSize: 10.r),
            ),
            progressColor: AppColors.secondary,
          );
        }

        return SvgPicture.asset(
          _getCourseIcon(course.status),
          height: 30.r,
          width: 30.r,
        );
      },
    );
  }

  /// Lance le téléchargement du fichier PDF pour le cours
  void _downloadCourse(CourseEntity course, BuildContext context) {
    final url = (widget.category == CategoryEnum.sn ||
            widget.category == CategoryEnum.cc)
        ? (_currentIndex == 0 ? course.pdfEpreuve! : course.pdfCorrige!)
        : course.pdfUrl!;

    context.read<PdfFileCubit>().downloadAndSaveFile(
          url: url,
          category: widget.category.label.toLowerCase(),
          name: course.name!,
          id: course.id.toString(),
        );
  }

  /// Ouvre la vue d’affichage du PDF existant
  void _openPdfView(CourseEntity course) {
    context.router
        .push(
      PdfViewRoute(
        category: widget.category.label.toLowerCase(),
        courseEntity: course,
      ),
    )
        .then((_) {
      // Après fermeture, on fait un fetch sans full refresh pour mettre à jour l’état
      _fetchCourses(fullRefresh: false);
    });
  }

  /// Retourne le chemin de l’icône selon le statut
  String _getCourseIcon(Status status) {
    switch (status) {
      case Status.downloaded:
      case Status.isOpened:
        return AppImage.courseOpened;
      case Status.notDownloaded:
      // case Status.isDownloaded: // selon votre enum, adapter si nécessaire
      default:
        return AppImage.courseDownloadedIcon;
    }
  }
}
