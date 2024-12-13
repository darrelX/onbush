import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/shared/widget/app_dialog.dart';
import 'package:onbush/presentation/dashboard/home/pages/home_screen.dart';
import 'package:onbush/core/theme/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/presentation/dashboard/profil/cubit/mentee_cubit.dart';
import 'package:onbush/presentation/dashboard/profil/widgets/empty_referral_widget.dart';
import 'package:onbush/presentation/dashboard/profil/widgets/referral_overview_card_widget.dart';
import 'package:onbush/presentation/dashboard/profil/widgets/sponsor_child_widget.dart';
import 'package:onbush/presentation/dashboard/profil/widgets/sponsor_popup_widget.dart';
import 'package:onbush/service_locator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class AmbassadorSpaceScreen extends StatefulWidget {
  const AmbassadorSpaceScreen({super.key});

  @override
  State<AmbassadorSpaceScreen> createState() => _AmbassadorSpaceScreenState();
}

class _AmbassadorSpaceScreenState extends State<AmbassadorSpaceScreen> {
  final MenteeCubit _cubit = MenteeCubit();
  int _numberOfMentees = 0;
  Future<void> _shareWithSubject() async {
    const textToShare = 'Découvrez Flutter !';
    const subjectToShare = 'Découvrez cette technologie géniale';

    try {
      await Share.share(
        textToShare,
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 100, 100),
      );
      print('Partage réussi');
    } catch (e) {
      print('Erreur lors du partage : $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _cubit.getListMentee(
        email: getIt.get<ApplicationCubit>().userModel.email!,
        appareil: getIt.get<LocalStorage>().getString("device")!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenteeCubit, MenteeState>(
      listener: (context, state) {
        print(state);
        if (state is MenteeSuccess) {
          setState(() {
            _numberOfMentees = state.listMentees.length;
          });
        }
        // TODO: implement listener
      },
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.quaternaire,
          appBar: AppBar(
            title: const Text("Espace Parrain"),
            centerTitle: true,
          ),
          body: Container(
              width: context.width,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  Gap(15.h),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/account_image.png",
                        height: 60.h,
                      ),
                      const Spacer(),
                      ReferralOverviewCardWidget(
                        amount: _numberOfMentees * 10,
                        numberOfMentees: _numberOfMentees,
                      ),
                    ],
                  ),
                  Gap(20.h),
                  AppButton(
                    text: "Faire un retrait",
                    width: context.width,
                    bgColor: AppColors.grey,
                    // textColor: ,
                  ),
                  Gap(20.h),
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
                            child: SponsorPopupWidget(
                                shareIt: _shareWithSubject,
                                sponsorCode: getIt
                                    .get<ApplicationCubit>()
                                    .userModel
                                    .sponsorCode!));
                      },
                      leading: Image.asset(
                        'assets/icons/coins.png',
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
                  Gap(50.h),
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
                  Gap(60.h),
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
                                    .userModel
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
