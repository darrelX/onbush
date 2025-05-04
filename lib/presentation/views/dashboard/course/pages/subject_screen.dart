import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/shared/widget/app_input.dart';
import 'package:onbush/core/shared/widget/base_indicator/app_base_indicator.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/domain/entities/subject/subject_entity.dart';
import 'package:onbush/presentation/blocs/academic/academy/academy_cubit.dart';
import 'package:onbush/presentation/views/dashboard/course/widgets/academic_semester_tab.dart';
import 'package:onbush/presentation/views/dashboard/course/widgets/subject_tile_widget.dart';
import 'package:onbush/service_locator.dart';

@RoutePage()
class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final _carouselController = CarouselSliderController();
  late final AcademyCubit _academyCubit;
  List<SubjectEntity> _filteredSubjects = [];
  int _currentIndex = 0;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _academyCubit = getIt<AcademyCubit>();
    if (_academyCubit.listSubjectEntity.isEmpty) {
      _academyCubit.fetchSubjectEntity();
    }
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value.toLowerCase();
    });
  }

  void _onSemesterSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _academyCubit,
      child: Scaffold(
        backgroundColor: AppColors.quaternaire,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20.h),
              Text(
                "Mes matieres",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
              Gap(20.h),
              Expanded(
                child: BlocBuilder<AcademyCubit, AcademyState>(
                  builder: (context, state) {
                    if (state is SubjectStateFailure) {
                      return _buildErrorState();
                    }

                    if (state is SubjectStateLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (_academyCubit.listSubjectEntity.isNotEmpty) {
                      _filteredSubjects = _getFilteredSubjects();

                      return Column(
                        children: [
                          _buildSemesterTabs(),
                          Gap(20.h),
                          _buildSearchInput(),
                          Gap(20.h),
                          _buildSubjectList(),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return AppBaseIndicator.error400(
      message: "Vous avez un problème de connexion. Réessayez.",
      button: AppButton(
        text: "Recommencer",
        bgColor: AppColors.primary,
        width: context.width,
        onPressed: _academyCubit.fetchSubjectEntity,
      ),
    );
  }

  Widget _buildSemesterTabs() {
    return AcademySemesterTab(
      selectedText: AppColors.white,
      selectedIndex: _currentIndex,
      selectedColor: AppColors.primary,
      carouselController: _carouselController,
      onPressed: _onSemesterSelected,
      listSemester: [
        "Tous",
        ..._academyCubit.listSubjectEntity
            .map((item) => item.semester)
            .whereType<int>() // Évite les valeurs nulles
            .toSet()
            .map((item) => "Semestre $item"),
      ],
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
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: SvgPicture.asset(AppImage.searchIcon),
      ),
    );
  }

  Widget _buildSubjectList() {
    return Expanded(
      child: SubjectTileWidget(
        listSubjectEntity: _filteredSubjects,
      ),
    );
  }

  List<SubjectEntity> _getFilteredSubjects() {
    return _academyCubit.listSubjectEntity.where((subject) {
      final isMatchingSemester =
          _currentIndex == 0 || subject.specialityId == _currentIndex;
      final isMatchingSearch =
          subject.name?.toLowerCase().contains(_searchQuery) ?? false;
      return isMatchingSemester && isMatchingSearch;
    }).toList();
  }
}
