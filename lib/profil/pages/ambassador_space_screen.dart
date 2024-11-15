import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/home/pages/home_screen.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';

@RoutePage()
class AmbassadorSpaceScreen extends StatefulWidget {
  const AmbassadorSpaceScreen({super.key});

  @override
  State<AmbassadorSpaceScreen> createState() => _AmbassadorSpaceScreenState();
}

class _AmbassadorSpaceScreenState extends State<AmbassadorSpaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        title: const Text("Espace ambassadeur"),
        centerTitle: true,
      ),
      body: Container(
          width: context.width,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                  Container(
                    height: 60.h,
                    width: 280.w,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5.r),
                      border:
                          Border.all(width: 0.3.w, color: AppColors.ternary),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // width: 50.w,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/Icon.svg"),
                              Gap(10.w),
                              Column(
                                children: [
                                  const Spacer(),
                                  Text(
                                    "0",
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                            fontSize: 20.r,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Francs CFA",
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                            fontSize: 9.r,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/person_icon.svg"),
                            Gap(10.w),
                            Column(
                              children: [
                                const Spacer(),
                                Text(
                                  "0",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 20.r,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Filleul(s)",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 9.r,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Gap(50.h),
              AppButton(
                text: "Faire un retrait",
                width: context.width,
                bgColor: AppColors.grey,
                // textColor: ,
              ),
              Gap(40.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.white,
                ),
                child: ListTile(
                  onTap: () {
                    // context.router.push(const TopUpRoute());
                  },
                  leading: Image.asset(
                    'assets/icons/coins.png',
                    width: 30,
                    height: 30,
                  ),
                  title: Text(
                    'Code anbassadeur',
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
              Container(
                height: 200.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF88C9FF),
                ),
              ),
              Gap(10.h),
              SizedBox(
                width: 200.w,
                child: const Text(
                  "Tu n'as pas encore de filleuls. Partage ton lien ambassadeur et commence à gagner des récompenses dès maintenant !",
                  style: TextStyle(color: Color(0xff969DAC)),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )),
    );
  }
}
