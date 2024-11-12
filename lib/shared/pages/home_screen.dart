import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/application/cubit/application_cubit.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/utils/const.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_dialog.dart';
import 'package:onbush/shared/widget/app_input.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            width: context.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20.h),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/account_image.png",
                      height: 43.h,
                      fit: BoxFit.fitHeight,
                    ),
                    Gap(5.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Salut",
                          style: context.textTheme.titleMedium!.copyWith(),
                        ),
                        Text(
                          "Annastasie",
                          style: context.textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Niveau : 4",
                          style: context.textTheme.titleMedium!.copyWith(),
                        ),
                        Text(
                          "Enspd",
                          style: context.textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(20.h),
                Stack(
                  children: [
                    Container(
                      height: 180.h,
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 180.w,
                                  child: Text(
                                    "Deviens Ambassadeur, Partage et Récolte des Récompenses !",
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            fontSize: 18.r,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white),
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                  )),
                              AppButton(
                                text: "Devenir Ambassadeur",
                                bgColor: AppColors.sponsorButton,
                                width: 160.w,
                                height: 35.h,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.r,
                                    color: AppColors.white),
                              )
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Positioned(
                        right: 10.r,
                        bottom: 0,
                        child: Image.asset(
                          "assets/images/5.png",
                          height: 190.h,
                          fit: BoxFit.fitHeight,
                        )),
                  ],
                ),
                Gap(25.h),
                Text(
                  "Vos progrès",
                  style: context.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Gap(10.h),
                Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5.r, color: AppColors.primary),
                    color: AppColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 60.w,
                        height: 59.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/course.png",
                              width: 27.w,
                              fit: BoxFit.fitWidth,
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "10",
                                  style: context.textTheme.headlineMedium!
                                      .copyWith(
                                          fontSize: 24.r,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary),
                                ),
                                // Gap(5.h),
                                Text(
                                  "Cours",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      fontSize: 10.r,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 90.w,
                        height: 50.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/pencil.png",
                              height: 36.h,
                              fit: BoxFit.fitHeight,
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "6",
                                  style: context.textTheme.headlineMedium!
                                      .copyWith(
                                          fontSize: 24.r,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary),
                                ),
                                // Gap(5.h),
                                Text(
                                  "Sujets traites",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      fontSize: 10.r,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 90.w,
                        height: 59.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/course.png",
                              width: 27.w,
                              fit: BoxFit.fitWidth,
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "13",
                                  style: context.textTheme.headlineMedium!
                                      .copyWith(
                                          fontSize: 24.r,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary),
                                ),
                                // Gap(5.h),
                                Text(
                                  "Fiches de TD",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      fontSize: 10.r,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(20.h),
                Text(
                  "Raccourci",
                  style: context.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // CarouselView(itemExtent: itemExtent, children: [
          //   Container(height: ,)
          // ])
        ],
      ),
    );
  }
}

class PlaceABetWidget extends StatefulWidget {
  const PlaceABetWidget({
    super.key,
  });

  @override
  State<PlaceABetWidget> createState() => _PlaceABetWidgetState();
}

class _PlaceABetWidgetState extends State<PlaceABetWidget> {
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      bloc: getIt.get<ApplicationCubit>(),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(padding16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Placer un pari",
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: 26,
                  ),
                ),
                // Gap(20.h),
                AppInput(
                  width: 300.w,
                  controller: _amountController,
                  label: 'Montant',
                  labelColors: AppColors.primary,
                  // maxLines: null,
                  minLines: 1,
                  hint: "Min: 300",
                  keyboardType: TextInputType.number,
                  showHelper: true,
                  errorMaxLines: 2,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  autoValidate: AutovalidateMode.onUserInteraction,

                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.min(300,
                        errorText: "Le montant entree est inferieur a 300"),
                    (value) {
                      if (value != null && value.isNotEmpty) {
                        final number = double.parse(value);
                        if (number > state.user!.balance!) {
                          return "Le montant doit etre inferieur au solde";
                        }
                      }
                      return null;
                    },
                  ],
                ),
                // Gap(40.h),
                AppButton(
                  bgColor: AppColors.primary,
                  text: "Commencer le jeu",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {}
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
