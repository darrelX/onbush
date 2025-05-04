import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/shared/widget/app_dialog.dart';
import 'package:onbush/core/shared/widget/base_indicator/app_base_indicator.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/presentation/blocs/auth/auth/auth_cubit.dart';
import 'package:onbush/presentation/views/dashboard/profil/widgets/empty_referral_widget.dart';
import 'package:onbush/presentation/views/dashboard/profil/widgets/referral_overview_card_widget.dart';
import 'package:onbush/presentation/views/dashboard/profil/widgets/sponsor_child_widget.dart';
import 'package:onbush/presentation/views/dashboard/profil/widgets/sponsor_popup_widget.dart';
import 'package:onbush/presentation/views/dashboard/profil/widgets/withdrawal_notice_widget%20.dart';
import 'package:onbush/service_locator.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class AmbassadorSpaceScreen extends StatefulWidget {
  const AmbassadorSpaceScreen({super.key});

  @override
  State<AmbassadorSpaceScreen> createState() => _AmbassadorSpaceScreenState();
}

class _AmbassadorSpaceScreenState extends State<AmbassadorSpaceScreen> {
  int _numberOfMentees = 0;
  double _total = 0;

  @override
  void initState() {
    super.initState();
    getIt<AuthCubit>().getListMentee(
        email: getIt.get<ApplicationCubit>().userEntity!.email!,
        device: getIt.get<LocalStorage>().getString("device")!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is MenteeSuccess && state.listMentees.isNotEmpty) {
          setState(() {
            _total = state.listMentees
                .map((e) => e.amount ?? 0)
                .reduce((value, element) => value + element);
            _numberOfMentees = state.listMentees.length;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.quaternaire,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(height: 15.h),
                _buildHeader(),
                SizedBox(height: 20.h),
                _buildWithdrawButton(),
                SizedBox(height: 10.h),
                _buildReferralCodeCard(),
                SizedBox(height: 25.h),
                _buildMenteesCount(),
                SizedBox(height: 5.h),
                Gap(10.h),
                Expanded(child: _buildMenteesList(state))
                // _buildMenteesList(state)
              ],
            ),
          ),
        );
      },
    );
  }

  /// Header avec l'avatar et les statistiques des filleuls
  Widget _buildHeader() {
    final localStorage = getIt<LocalStorage>();
    return Row(
      children: [
        Image.asset(
          localStorage.getString('avatar') ?? '',
          height: 60.h,
        ),
        const Spacer(),
        ReferralOverviewCardWidget(
            amount: _total, numberOfMentees: _numberOfMentees),
      ],
    );
  }

  /// Bouton de retrait
  Widget _buildWithdrawButton() {
    bool canWithdraw = _numberOfMentees > 0;
    return AppButton(
      text: "Faire un retrait",
      textColor: canWithdraw ? const Color(0xFF07BD56) : AppColors.textGrey,
      bgColor: canWithdraw ? const Color(0xFF9EFFC8) : const Color(0xFFECEEF0),
      width: context.width,
      onPressed: canWithdraw
          ? () => AppDialog.showDialog(
                context: context,
                height: 190.h,
                width: 360.w,
                child: const WithdrawalNoticeWidget(),
              )
          : null,
    );
  }

  /// Carte pour partager le code de parrainage
  Widget _buildReferralCodeCard() {
    final sponsorCode = getIt<ApplicationCubit>().userEntity?.sponsorCode ?? '';
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.white,
      ),
      child: ListTile(
        onTap: () {
          AppDialog.showDialog(
            context: context,
            width: context.width - 30.w,
            height: 380.h,
            child: SponsorPopupWidget(sponsorCode: sponsorCode),
          );
        },
        leading: SvgPicture.asset(AppImage.copy, width: 30, height: 30),
        title: Text(
          'Partager mon code Parrain',
          style: context.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: Color(0xffA7A7AB)),
      ),
    );
  }

  /// Indicateur du nombre de filleuls
  Widget _buildMenteesCount() {
    return Row(
      children: [
        const Text("Filleul(s)", style: TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        Text("$_numberOfMentees",
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  /// Liste des filleuls avec gestion des états
  Widget _buildMenteesList(AuthState state) {
    if (state is MenteePending) {
      return _buildLoadingIndicator();
    }
    if (state is MenteeFailure) {
      return _buildErrorIndicator();
    }
    if (state is MenteeSuccess) {
      if (state.listMentees.isEmpty) {
        log("MenteeSuccess 2");

        return const EmptyReferralWidget();
      }
      return _buildMentees(state.listMentees.length);
    }
    return const EmptyReferralWidget();
  }

  /// Affichage de la liste des filleuls
  Widget _buildMentees(int count) {
    return ListView.separated(
      separatorBuilder: (_, __) => SizedBox(height: 20.h),
      itemCount: count,
      itemBuilder: (_, index) =>
          const SponsoredChildWidget(name: "Darrel Tcho", date: "4h"),
    );
  }

  /// Indicateur de chargement avec effet `Shimmer`
  Widget _buildLoadingIndicator() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        itemCount: 10,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (_, __) => Container(
          width: context.width,
          height: 60.h,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Affichage en cas d'erreur
  Widget _buildErrorIndicator() {
    return AppBaseIndicator.error400(
      message: "Aucun filleul pour le moment",
      size: 170.r,
      button: AppButton(
        text: "Recommencer",
        height: 50.h,
        bgColor: AppColors.primary,
        width: context.width - 90.w,
        onPressed: () => getIt<AuthCubit>().getListMentee(
          email: getIt<ApplicationCubit>().userEntity?.email ?? '',
          device: getIt<LocalStorage>().getString("device") ?? '',
        ),
      ),
    );
  }
}
