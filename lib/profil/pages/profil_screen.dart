import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';

import '../../shared/routing/app_router.dart';

@RoutePage()
class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      body: Container(
          width: context.width,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(10.h),
              Container(
                height: 140.h,
                // decoration: BoxDecoration(color: Colors.red),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/account_image.png",
                      height: 105.h,
                      fit: BoxFit.fitHeight,
                    ),
                    Gap(10.w),
                    SizedBox(
                      height: 105.h,
                      width: 239.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Annastasie Irene NGATCHOU",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.r,
                                  shadows: [
                                    const Shadow(
                                      offset: Offset(0.5, 0.5),
                                      blurRadius: 3.0,
                                      color: Color(0xFF969DAC),
                                    ),
                                  ]),
                              overflow: TextOverflow.ellipsis),
                          const Spacer(),
                          Text(
                            "Niveau: 4",
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontSize: 14.r,
                              color: Color(0xFF969DAC),
                            ),
                          ),
                          Container(
                            width: 200.w,
                            child: Text(
                              "Filiere: Genie Informatique et telecommunication",
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontSize: 14.r,
                                height: 1.3.h,
                                color: Color(0xFF969DAC),
                              ),
                              maxLines: 2,
                            ),
                          ),
                          Text(
                            "ENSPD",
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontSize: 14.r,
                                color: Color(0xFF969DAC),
                                shadows: [
                                  const Shadow(
                                    offset: Offset(0.5, 0.5),
                                    blurRadius: 2.0,
                                    color: Color(0xFF969DAC),
                                  ),
                                ],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Gap(10.h),
              AppButton(
                width: double.infinity,

                text: "Modifier mon profil",
                textColor: AppColors.secondary,
                height: 45.h,
                // width: 200.w,
                bgColor: AppColors.ternary,
              ),
              Gap(30.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ListTile(
                  onTap: () {
                    context.router.push(const AmbassadorSpaceRoute());
                  },
                  leading: Icon(Icons.star),
                  title: Text(
                    'Espace ambassadeur',
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
              Gap(10.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ListTile(
                  onTap: () {
                    // context.router.push(const TopUpRoute());
                  },
                  leading: Icon(Icons.language_outlined),
                  title: Text(
                    'Langue',
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
              Gap(10.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ListTile(
                  onTap: () {
                    // context.router.push(const TopUpRoute());
                  },
                  leading: Icon(Icons.warning),
                  title: Text(
                    'A propos',
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
              Gap(10.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ListTile(
                  onTap: () {
                    // context.router.push(const TopUpRoute());
                  },
                  leading: Icon(Icons.message),
                  title: Text(
                    'Nous contacter',
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
              Gap(20.h),
              AppButton(
                width: double.infinity,
                text: "Deconnexion",
                textColor: Colors.redAccent,
                borderColor: Colors.redAccent,
              )
            ],
          )),
    );
  }
}
