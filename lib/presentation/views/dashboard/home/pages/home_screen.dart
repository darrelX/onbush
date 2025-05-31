import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/presentation/views/dashboard/home/widgets/ads_widget.dart';
import 'package:onbush/presentation/views/dashboard/home/widgets/dashboard_summary_widget.dart';
import 'package:onbush/presentation/views/dashboard/home/widgets/user_info_card_widget.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/presentation/blocs/pdf/pdf_manager/pdf_manager_cubit.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with RouteAware {
  late final ApplicationCubit _cubit;
  late final PdfManagerCubit _pdfManagerCubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ApplicationCubit>();
    _pdfManagerCubit = context.read<PdfManagerCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _pdfManagerCubit..loadAll(maxResults: 3),
      child: Scaffold(
        backgroundColor: AppColors.quaternaire,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10.h),
              UserInfoCardWidget(cubit: _cubit),
              Gap(15.h),
              const AdsWidget(),
              Gap(20.h),
              Text(
                "Données disponibles",
                style: context.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Gap(10.h),
              DashboardSummaryWidget(
                numberOfCourses: 12,
                numberOfTD: 13,
                processedTopics: 6,
                onPressed: () => context.router.pushAndPopUntil(
                  const SubjectRoute(),
                  predicate: (route) => true,
                ),
              ),
              Gap(20.h),
              Text(
                "Reprends où tu t'es arrêté(e).",
                style: context.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Gap(10.h),
              Expanded(
                child: BlocBuilder<PdfManagerCubit, PdfManagerState>(
                  builder: (context, state) {
                    return _buildRecentPdfList(context, state);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentPdfList(BuildContext context, PdfManagerState state) {
    final listPdfEntity = context.watch<PdfManagerCubit>().allPdfs;
    if (state is PdfManagerLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is PdfManagerError) {
      return Center(child: Text("Erreur: ${state.message}"));
    }

    if (state is PdfManagerLoaded) {
      if (!state.filtered.any((pdf) => pdf.isOpened == true)) {
        return _buildNoneFilesWidget();
      }

      final recentPdfs =
          state.filtered.where((pdf) => pdf.isOpened == true).toList();

      return ListView.separated(
        itemCount: recentPdfs.length,
        separatorBuilder: (_, __) => Gap(4.h),
        itemBuilder: (_, index) {
          final pdf = recentPdfs[index];
          return ListTile(
            leading: SvgPicture.asset(AppImage.courseOpened),
            title: Text(pdf.name ?? "Nom inconnu"),
            onTap: () {
              context.router.push(DownloadPdfViewRoute(pdfFileEntity: pdf));
            },
          );
        },
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildNoneFilesWidget() {
    return Opacity(
      opacity: 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(20.h),
          SvgPicture.asset(
            AppImage.onBush,
            width: 80.r,
            height: 80.r,
          ),
          Gap(20.h),
          const Text(
            "Tu n'as pas encore ouvert tes cours. Tes 3 derniers cours ouverts s'affichent ici !",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
