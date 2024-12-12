import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/presentation/dashboard/home/pages/home_screen.dart';
import 'package:onbush/core/theme/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/presentation/dashboard/profil/widgets/empty_referral_widget.dart';
import 'package:onbush/presentation/dashboard/profil/widgets/referral_overview_card_widget.dart';
import 'package:onbush/presentation/dashboard/profil/widgets/sponsor_child_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class AmbassadorSpaceScreen extends StatefulWidget {
  const AmbassadorSpaceScreen({super.key});

  @override
  State<AmbassadorSpaceScreen> createState() => _AmbassadorSpaceScreenState();
}

class _AmbassadorSpaceScreenState extends State<AmbassadorSpaceScreen> {
  Future<void> _shareWithSubject() async {
    final result = await Share.share(
      'Découvrez Flutter !',
      subject: 'Découvrez cette technologie géniale',
    );
    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing my website!');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  const ReferralOverviewCardWidget(
                    amount: 100,
                    numberOfMentees: 20,
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
                    // context.router.push(const TopUpRoute());
                    _shareWithSubject();
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
              Gap(30.h),
              Container(
                child: const Row(
                  children: [
                    Text(
                      "filleul(s)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "0",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Gap(30.h),
              // EmptyReferralWidget(),
              const SponsoredChild(
                name: "Darrel Tcho",
                date: "4h",
              )
            ],
          )),
    );
  }
}
