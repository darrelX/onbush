import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/shared/widget/app_dialog.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/presentation/views/dashboard/profil/cubit/mentee_cubit.dart';
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
  final MenteeCubit _cubit = MenteeCubit();
  int _numberOfMentees = 0;
  double _total = 0;

  @override
  void initState() {
    super.initState();
    _cubit.getListMentee(
        email: getIt.get<ApplicationCubit>().userEntity!.email!,
        appareil: getIt.get<LocalStorage>().getString("device")!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenteeCubit, MenteeState>(
      listener: (context, state) {
        print(state);
        if (state is MenteeSuccess) {
          if (state.listMentees.isNotEmpty) {
            setState(() {
              _total = state.listMentees
                  .map((element) => element.amount!)
                  .toList()
                  .reduce((value, element) => value + element);
              _numberOfMentees = state.listMentees.length;
            });
          }
        }
      },
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.quaternaire,
          body: Container(
              width: context.width,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  Gap(15.h),
                  Row(
                    children: [
                      Image.asset(
                        getIt.get<LocalStorage>().getString('avatar')!,
                        height: 60.h,
                      ),
                      const Spacer(),
                      ReferralOverviewCardWidget(
                        amount: _total,
                        numberOfMentees: _numberOfMentees,
                      ),
                    ],
                  ),
                  Gap(20.h),
                  AppButton(
                    text: "Faire un retrait",
                    textColor: _numberOfMentees > 0
                        ? const Color(0xFF07BD56)
                        : AppColors.textGrey,
                    width: context.width,
                    // bgColor: Color(0xFFECEEF0),
                    bgColor: _numberOfMentees > 0
                        ? const Color(0xFF9EFFC8)
                        : const Color(0xFFECEEF0),
                    onPressed: () => _numberOfMentees > 0
                        ? AppDialog.showDialog(
                            height: 190.h,
                            width: 360.w,
                            child: const WithdrawalNoticeWidget(),
                            context: context)
                        : null,
                    // textColor: ,
                  ),
                  Gap(10.h),
                  Container(
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
                            child: SponsorPopupWidget(
                                sponsorCode: getIt
                                    .get<ApplicationCubit>()
                                    .userEntity!
                                    .sponsorCode!));
                      },
                      leading: SvgPicture.asset(
                        AppImage.copy,
                        width: 30,
                        height: 30,
                      ),
                      title: Text(
                        'Partager mon code Parrain',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xffA7A7AB),
                      ),
                    ),
                  ),
                  Gap(40.h),
                  Row(
                    children: [
                      const Text(
                        "filleul(s)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        "$_numberOfMentees",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Gap(40.h),
                  Expanded(
                    child: Builder(builder: (context) {
                      if (state is MenteePending) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Column(children: [
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: context.width,
                                      height: 60.h,
                                      color: Colors.white,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      Gap(10.h),
                                  itemCount: 10),
                            )
                          ]),
                        );
                      }
                      if (state is MenteeFailure) {
                        return AppButton(
                            child: const Icon(Icons.refresh),
                            onPressed: () => _cubit.getListMentee(
                                email: getIt
                                    .get<ApplicationCubit>()
                                    .userEntity!
                                    .email!,
                                appareil: getIt
                                    .get<LocalStorage>()
                                    .getString("device")!));
                      }
                      if (state is MenteeSuccess) {
                        if (state.listMentees.isEmpty) {
                          return const EmptyReferralWidget();
                        }
                        return ListView.separated(
                          separatorBuilder: (context, index) => Gap(20.h),
                          itemBuilder: (context, index) {
                            return const SponsoredChildWidget(
                              name: "Darrel Tcho",
                              date: "4h",
                            );
                          },
                          itemCount: state.listMentees.length,
                        );
                      }
                      return Column(
                        children: [
                          Gap(30.h),
                          const EmptyReferralWidget(),
                          // const SponsoredChildWidget(
                          //   name: "Darrel Tcho",
                          //   date: "4h",
                          // )
                        ],
                      );
                    }),
                  ),
                ],
              )),
        );
      },
    );
  }
}
