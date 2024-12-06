import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/course/pages/course_selected_menu_screen.dart';
import 'package:onbush/course/widgets/academic_semester_tab.dart';
import 'package:onbush/course/widgets/subject_tile_widget.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/application/cubit/application_cubit.dart';
import 'package:onbush/shared/application/cubit/data_state.dart';
import 'package:onbush/shared/application/data/models/subject_model.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_carousel_widget.dart';
import 'package:onbush/shared/widget/app_input.dart';

@RoutePage()
class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final _carouselController = CarouselSliderController();
  String? pm;
  late final ApplicationCubit _cubit;
  List<SubjectModel> _filterListSubjectModel = [];
  int _currentIndex = 0;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ApplicationCubit>()..fetchSubjectModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Text(
              "Mes cours",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
            ),
          ),
          Gap(20.h),
          Expanded(
            child: BlocBuilder<ApplicationCubit, ApplicationState>(
              builder: (context, state) {
                if (state.listSubjectModel!.status == Status.failure) {
                  return const Text("retry");
                }
                if (state.listSubjectModel!.status == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.listSubjectModel!.status == Status.success) {
                  
                  _filterListSubjectModel =
                      state.listSubjectModel!.data!.where((subjectModel) {
                    final matchSubjectModel = _currentIndex == 0 ||
                        subjectModel.specialityId == _currentIndex;
                    final matchesSearch = subjectModel.name!
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase());
                    return matchSubjectModel && matchesSearch;
                  }).toList();
                  // _currentIndex == 0
                  //     ? state.listSubjectModel!.data!
                  //     : state.listSubjectModel!.data!
                  //         .where((subjectMod el) =>
                  //             subjectModel.specialityId == _currentIndex)
                  //         .toList();
                  return Column(
                    children: [
                      AcademicSemesterTab(
                          selectedText: AppColors.white,
                          selectedIndex: _currentIndex,
                          selectedColor: AppColors.primary,
                          carouselController: _carouselController,
                          onPressed: (int index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          listSemester: state.listSubjectModel!.data!.where((item){})
                          
                          //  const [
                          //   "Tous",
                          //   "Semestre 1",
                          // ]),
                      Gap(20.h),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppInput(
                                hint: "Chercher un cours",
                                width: context.width,
                                onChange: (value) {
                                  setState(() {
                                    searchQuery = value;
                                  });
                                },
                                prefix: const Icon(Icons.search),
                              ),
                              Gap(20.h),
                              Expanded(
                                child: SubjectTileWidget(
                                    listSubjectModel: _filterListSubjectModel,
                                    listCourseName: _filterListSubjectModel
                                        .map((item) => item.name!)
                                        .toList()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
