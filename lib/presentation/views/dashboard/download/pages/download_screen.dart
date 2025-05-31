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
  String _searchQuery = '';
  final List<String> _category = ["Tout", "cours", "TD", "normales"];
  final TextEditingController _courseController = TextEditingController();
  late final PdfFileCubit _pdfFileCubit = getIt<PdfFileCubit>();

  Widget _buildCategorySelector() {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => Gap(5.w),
        itemCount: _category.length,
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
              bgColor:
                  index == _currentIndex ? AppColors.primary : AppColors.grey,
              onPressed: () {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      actions: [
        Image.asset(AppImage.downloadIconCircle),
        Gap(20.w),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: _buildAppBar(),
      body: BlocProvider.value(
        value: _pdfFileCubit..getPdfFile(maxResults: -1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text("Vos téléchargements",
                  style: context.textTheme.headlineSmall),
            ),
            // Gap(20.h),
            // _buildCategorySelector(),
            Gap(20.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: _buildPdfFileBloc(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -- FONCTIONS MODULAIRES -- //

  Widget _buildPdfFileBloc() {
    return BlocConsumer<PdfFileCubit, PdfFileState>(
      listener: (_, __) {},
      builder: (context, state) {
        if (state is FetchPdfFileFailure) {
          return _buildErrorIndicator("Aucun fichier disponible");
        }

        if (state is FetchPdfFilePending) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FetchPdfFileSuccess) {
          final filteredList = state.listPdfFileEntity.where((pdf) {
            final matchCategory =
                _currentIndex == 0 || pdf.category == _category[_currentIndex];
            final matchSearch =
                pdf.name!.toLowerCase().contains(_searchQuery.toLowerCase());
            return matchCategory && matchSearch;
          }).toList();

          return _buildPdfList(filteredList, state.listPdfFileEntity.isEmpty);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPdfList(List<PdfFileEntity> filteredList, bool isEmptyList) {
    if (isEmptyList) {
      return _buildErrorIndicator("Aucun fichier téléchargé");
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          AppInput(
            hint: "Chercher un cours",
            width: context.width,
            controller: _courseController,
            colorBorder: AppColors.textGrey,
            onChange: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
            prefix: const Icon(Icons.search),
          ),
          Gap(20.h),
          Expanded(
            child: ListView.separated(
              itemCount: filteredList.length,
              separatorBuilder: (_, __) => Gap(20.h),
              itemBuilder: (context, index) {
                return PdfFileWidget(pdfFileEntity: filteredList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorIndicator(String message) {
    return Center(
      child: AppBaseIndicator.error400(
        message: message,
        spacing: 20.h,
        button: AppButton(
          text: "Recommencer",
          bgColor: AppColors.primary,
          width: context.width,
          onPressed: () => _pdfFileCubit.getPdfFile(),
        ),
      ),
    );
  }
}
