import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/shared/application/cubit/application_cubit.dart';
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
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.quaternaire,
          body: Container(
              width: context.width,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(10.h),
                  SizedBox(
                    height: 140.h,
                    // decoration: BoxDecoration(color: Colors.red),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/account_image.png",
                          height: 105.h,
                          fit: BoxFit.fitHeight,
                        ),
                        Gap(8.w),
                        SizedBox(
                          height: 109.h,
                          width: 239.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.user!.name!,
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
                                "Niveau: ${state.user!.academiclevel}",
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontSize: 14.r,
                                  color: const Color(0xFF969DAC),
                                ),
                              ),
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  "Filiere: ${state.user!.majorSchoolId}",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontSize: 14.r,
                                    height: 1.3.h,
                                    color: const Color(0xFF969DAC),
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Text(
                                "ENSPD",
                                style: context.textTheme.bodyLarge!.copyWith(
                                    fontSize: 14.r,
                                    color: const Color(0xFF969DAC),
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
                      leading: const Icon(Icons.star),
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
                        context.router.push(const LanguageRoute());
                      },
                      leading: const Icon(Icons.language_outlined),
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
                      leading: const Icon(Icons.warning),
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
                      leading: const Icon(Icons.message),
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
                  const AppButton(
                    width: double.infinity,
                    text: "Deconnexion",
                    textColor: Colors.redAccent,
                    borderColor: Colors.redAccent,
                  )
                ],
              )),
        );
      },
    );
  }
}
