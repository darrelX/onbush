import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/base_indicator/app_base_indicator.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/presentation/blocs/pdf/pdf_file_cubit.dart';
import 'package:onbush/presentation/views/dashboard/home/widgets/dashboard_summary_widget.dart';
import 'package:onbush/presentation/views/dashboard/home/widgets/user_info_card_widget.dart';
import 'package:onbush/service_locator.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ApplicationCubit _cubit;
  late final PdfFileCubit _pdfFileCubit;
  @override
  void initState() {
    super.initState();
    _pdfFileCubit = getIt<PdfFileCubit>();
    _cubit = getIt<ApplicationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final CarouselSliderController carouselController =
        CarouselSliderController();

    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10.h),
              UserInfoCardWidget(cubit: _cubit),
              Gap(15.h),
              Stack(
                children: [
                  Container(
                    height: 190.h,
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 180.w,
                                child: Text(
                                  "Deviens Parrain, Partage et Récolte des Récompenses !",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                      fontSize: 17.r,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white),
                                  textAlign: TextAlign.left,
                                  maxLines: 3,
                                )),
                            AppButton(
                              text: "Devenir Parrain",
                              bgColor: AppColors.sponsorButton,
                              onPressed: () {
                                context.router
                                    .push(const AmbassadorSpaceRoute());
                              },
                              width: 158.w,
                              height: 35.h,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.r,
                                  color: AppColors.white),
                            )
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Positioned(
                      right: 5.w,
                      bottom: 0,
                      child: Image.asset(
                        "assets/images/5.png",
                        height: 170.h,
                        fit: BoxFit.fitHeight,
                      )),
                ],
              ),
              Gap(20.h),
              Text(
                "Données disponibles",
                style: context.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Gap(10.h),
              const DashboardSummaryWidget(
                numberOfCourses: 12,
                numberOfTD: 13,
                processedTopics: 6,
              ),
              Gap(20.h),
              Text(
                "Reprends où tu t'es arrêté(e).",
                style: context.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Gap(10.h),
              Column(
                children: [
                  BlocBuilder<PdfFileCubit, PdfFileState>(
                    bloc: _pdfFileCubit..getPdfFile(),
                    builder: (context, state) {
                      if (state is FetchPdfFilePending) {
                        return const Text("error");
                      }
                      if (state is FetchPdfFileFailure) {
                        return const Text("Error 1");
                      }
                      if (_pdfFileCubit.listPdfFileEntity.isNotEmpty) {
                        return Column(
                          children: [
                            ..._pdfFileCubit.listPdfFileEntity
                                .map((pdfFilentity) {
                              // print(pdfFilentity.filePath!);
                              return ListTile(
                                leading:
                                    SvgPicture.asset(AppImage.courseDownloaded),
                                title: Text(pdfFilentity.name!),
                                onTap: () {
                                  context.router.push(DownloadPdfViewRoute(
                                      pdfFileEntity: pdfFilentity));
                                },
                              );
                            }),
                          ],
                        );
                      } else {
                        return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text("Vide"),
                              ),
                            ]);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Shortcut extends StatelessWidget {
  final String title;
  final Widget image;
  const _Shortcut({
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      width: 140.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(width: 2.r, color: AppColors.ternary),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 90.h,
            width: context.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(width: 2.r, color: AppColors.ternary),
              color: AppColors.ternary,
            ),
            child: image,
          ),
          Text(
            title,
            style: context.textTheme.bodySmall!
                .copyWith(fontSize: 13.r, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
