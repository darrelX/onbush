import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/shared/widget/base_indicator/app_base_indicator.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:onbush/presentation/blocs/pdf/pdf_file/pdf_file_cubit.dart';
import 'package:onbush/presentation/views/dashboard/download/widgets/pdf_file_widget.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/shared/widget/app_input.dart';
import 'package:onbush/service_locator.dart';

@RoutePage()
class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  int _currentIndex = 0;
  List<PdfFileEntity> _filterListPdfFile = [];
  final List<String> _category = ["Tout", "cours", "TD", "normales"];
  final TextEditingController _courseControler = TextEditingController();
  String _searchQuery = '';
  late final PdfFileCubit _pdfFileCubit = getIt<PdfFileCubit>();

  @override
  void initState() {
    super.initState();
    // context.read<PdfFileCubit>().downloadAllPdfs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [
          Image.asset(AppImage.downloadIconCircle),
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
          Container(
            height: 45.h,
            // padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return Gap(5.w);
              },
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 7.w),
                  child: AppButton(
                    text: _category[index],
                    width: 90.w,
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
          BlocProvider.value(
            value: _pdfFileCubit..getPdfFile(maxResults: -1),
            child: Expanded(
              child: BlocConsumer<PdfFileCubit, PdfFileState>(
                listener: (context, state) async {},
                builder: (context, state) {
                  print(state);
                  if (state is FetchPdfFileFailure) {
                    return AppBaseIndicator.error400(
                      message: "Aucun fichier disponible",
                      button: AppButton(
                        text: "Recommencer",
                        bgColor: AppColors.primary,
                        width: context.width,
                        onPressed: () => _pdfFileCubit..getPdfFile(),
                      ),
                    );
                  }
                  if (state is FetchPdfFilePending) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is FetchPdfFileSuccess) {
                    _filterListPdfFile =
                        state.listPdfFileEntity.where((pdfFileEntity) {
                      final matcheCourse = _currentIndex == 0 ||
                          pdfFileEntity.category == _category[_currentIndex];
                      final matchesSearch = pdfFileEntity.name!
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase());
                      return matcheCourse && matchesSearch;
                    }).toList();

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          state.listPdfFileEntity.isEmpty
                              ? Expanded(
                                  child: Center(
                                    child:
                                        AppBaseIndicator.unavailableFileDisplay(
                                      message:
                                          "Vous avez un probleme de connexion ressayer",
                                      button: AppButton(
                                        text: "Recommencer",
                                        bgColor: AppColors.primary,
                                        width: context.width,
                                        onPressed: () =>
                                            _pdfFileCubit..getPdfFile(),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AppInput(
                                          hint: "Chercher un cours",
                                          width: context.width,
                                          colorBorder: AppColors.textGrey,
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
                                                    pdfFileEntity:
                                                        _filterListPdfFile[
                                                            index]);
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return Gap(20.h);
                                              },
                                              itemCount:
                                                  _filterListPdfFile.length),
                                        )
                                        //  PdfFileWidget(pdfFileModel : ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
