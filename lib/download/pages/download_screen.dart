import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/download/logic/cubit/download_cubit.dart';
import 'package:onbush/download/logic/data/pdf_file_model.dart';
import 'package:onbush/download/widgets/pdf_file_widget.dart';
import 'package:onbush/history/presentation/widgets/history_widget.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_carousel_widget.dart';
import 'package:onbush/shared/widget/app_input.dart';

@RoutePage()
class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  int _currentIndex = 0;
  List<PdfFileModel> _filterListPdfFile = [];
  List<String> _category = [
    "Tout",
  ];
  final TextEditingController _courseControler = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<DownloadCubit>().downloadAllPdfs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [
          Image.asset("assets/icons/leading-icon-circle.png"),
          Gap(20.w),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Text("Vos telechargements",
                style: context.textTheme.headlineSmall!.copyWith()),
          ),
          Gap(20.h),
          Expanded(
            child: BlocConsumer<DownloadCubit, DownloadState>(
              listener: (context, state) async {
                if (state is DownloadSuccess) {
                  _category.addAll(await context
                      .read<DownloadCubit>()
                      .getFoldersInAppDirectory());
                }
              },
              builder: (context, state) {
                if (state is DownloadFailure) {
                  return AppButton(
                    text: "retry",
                  );
                }
                if (state is DownloadLoading) {
                  return CircularProgressIndicator();
                }
                if (state is DownloadSuccess) {
                  print(_category);
                  _filterListPdfFile = state.listPdfModel.where((pdfFileModel) {
                    final matcheCourse = _currentIndex == 0 ||
                        pdfFileModel.category == _category[_currentIndex];
                    final matchesSearch = pdfFileModel.name!
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase());
                    return matcheCourse && matchesSearch;
                  }).toList();

                  return Column(
                    children: [
                      SizedBox(
                        height: 45.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                left: index == 0 ? 10.w : 0,
                                right: 10.w,
                              ),
                              child: AppButton(
                                text: _category[index],
                                radius: 9.r,
                                textColor: index == _currentIndex
                                    ? Colors.grey.shade200
                                    : Colors.black45,
                                onPressed: () {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                                // width: 110.w,
                                bgColor: index == _currentIndex
                                    ? AppColors.primary
                                    : AppColors.grey,
                              ),
                            );
                            // }
                          },
                          itemCount: _category.length,
                          // shrinkWrap: true,
                        ),
                      ),
                      Gap(30.h),
                      state.listPdfModel.isEmpty
                          ? Container(
                              child: Text("Empty"),
                            )
                          : Expanded(
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
                                          _searchQuery = value;
                                        });
                                      },
                                      controller: _courseControler,
                                      prefix: const Icon(Icons.search),
                                    ),
                                    Gap(20.h),
                                    Expanded(
                                      child: ListView.separated(
                                          itemBuilder: (context, index) {
                                            return PdfFileWidget(
                                                pdfFileModel:
                                                    _filterListPdfFile[index]);
                                          },
                                          separatorBuilder: (context, index) {
                                            return Gap(20.h);
                                          },
                                          itemCount: _filterListPdfFile.length),
                                    )
                                    //  PdfFileWidget(pdfFileModel : ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  );
                }
                return SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}
