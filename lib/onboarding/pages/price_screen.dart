import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:onbush/auth/presentation/widgets/pin_code_widget.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_input.dart';
import 'package:onbush/shared/widget/app_radio_list_tile.dart';

@RoutePage()
class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _sponsorCodeController = TextEditingController();
  final TextEditingController _codePromoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _error;
  PhoneNumber? _number;

  String? _pm;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // width: context.width,
          // padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 3),
                        child: Image.asset(
                          "assets/images/2.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 60.h,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: context.height,
                child: PageView(
                  allowImplicitScrolling: true,
                  controller: _pageController,
                  physics: _currentIndex == 1 && _pm == null
                      ? const NeverScrollableScrollPhysics()
                      : null,
                  onPageChanged: (page) {
                    setState(() {
                      _currentIndex = page;
                    });
                  },
                  children: [
                    Container(
                      width: context.width,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      // height: 600.h,
                      // color: Colors.red,
                      child: Column(
                        children: [
                          Gap(290.h),
                          Text(
                            "Apprends sans limites avec OnBush",
                            style: context.textTheme.headlineMedium!.copyWith(
                                color: AppColors.primary,
                                shadows: [
                                  const Shadow(
                                    offset: Offset(0.5, 0.5),
                                    blurRadius: 1.0,
                                    color: Colors.grey,
                                  ),
                                ],
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.center,
                          ),

                          Gap(30.h),
                          const _Widget(
                              title:
                                  "Profitez de tous les cours, fiches TD, et corrigés disponibles."),
                          Gap(5.h),
                          const _Widget(
                              title:
                                  "Téléchargez vos contenus pour étudier sans connexion Internet."),
                          Gap(5.h),
                          const _Widget(
                              title:
                                  "Recevez des alertes pour les nouveaux cours et les examens à venir.."),
                          Gap(5.h),
                          const _Widget(
                              title:
                                  "Téléchargez vos contenus pour étudier sans connexion Internet."),
                          Gap(5.h),
                          const _Widget(
                              title:
                                  "Visualisez vos progrès académiques grâce à notre tableau de bord interactif."),
                          Gap(25.h),
                          Text(
                            "à seulement 5.000 Fcfa / an.",
                            style: context.textTheme.titleLarge!
                                .copyWith(color: AppColors.secondary),
                          ),
                          // Gap(20.h),
                        ],
                      ),
                    ),
                    Container(
                      width: 350.w,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          Gap(290.h),
                          Text(
                            "Choisis ton moyen de paiement",
                            style: context.textTheme.headlineMedium!.copyWith(
                                color: AppColors.black,
                                shadows: [
                                  const Shadow(
                                    offset: Offset(0.5, 0.5),
                                    blurRadius: 1.0,
                                    color: Colors.grey,
                                  ),
                                ],
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.center,
                          ),
                          Gap(45.h),
                          AppRadioListTile(
                            activeColor: AppColors.primary,
                            groupeValue: _pm,
                            title: "Orange Money",
                            selectedColor: AppColors.primary,
                            onChanged: (String? value) {
                              setState(() {
                                _pm = value!;
                              });
                            },
                            value: "Orange Money",
                          ),
                          Gap(20.h),
                          AppRadioListTile(
                            title: "Mobile Money",
                            activeColor: AppColors.primary,
                            groupeValue: _pm,
                            selectedColor: AppColors.primary,
                            onChanged: (String? value) {
                              setState(() {
                                _pm = value!;
                              });
                            },
                            value: "Mobile Money",
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Gap(290.h),
                            Row(
                              children: [
                                AppButton(
                                  child: const Icon(Icons.arrow_back),
                                  onPressed: () {
                                    _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.linear);
                                  },
                                ),
                                const Spacer(),
                                Text(
                                  "Paiement",
                                  style: context.textTheme.headlineMedium!
                                      .copyWith(
                                          color: AppColors.black,
                                          shadows: [
                                            const Shadow(
                                              offset: Offset(0.5, 0.5),
                                              blurRadius: 1.0,
                                              color: Colors.grey,
                                            ),
                                          ],
                                          fontWeight: FontWeight.w900),
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer()
                              ],
                            ),
                            Gap(30.h),
                            InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber value) {
                                setState(() {
                                  _number = value;
                                });
                              },
                              hintText: '',
                              initialValue: PhoneNumber(isoCode: 'CM'),
                              selectorConfig: const SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                                useBottomSheetSafeArea: true,
                                setSelectorButtonAsPrefixIcon: true,
                                leadingPadding: 10,
                              ),
                              inputBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              inputDecoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              )
                                  // contentPadding:
                                  //     context.theme.inputDecorationTheme.contentPadding,
                                  ),
                              ignoreBlank: false,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),
                              textFieldController: _phoneController,
                              formatInput: true,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),

                              // inputBorder: context.theme.inputDecorationTheme.border!
                              //     .copyWith(
                              //         borderSide: BorderSide(color: Colors.red)),
                            ),
                            Gap(10.h),
                            AppInput(
                              width: context.width,
                              hint: "Code de reduction",
                              controller: _sponsorCodeController,
                              keyboardType: TextInputType.number,
                              colorBorder: AppColors.black,
                              validators: [
                                FormBuilderValidators.required(
                                  errorText: 'Code de reduction requis',
                                ),
                              ],
                            ),
                            Gap(10.h),
                            AppInput(
                              width: context.width,
                              hint: "Code de parrainage",
                              colorBorder: AppColors.black,
                              controller: _codePromoController,
                              keyboardType: TextInputType.number,
                              validators: [
                                FormBuilderValidators.required(
                                  errorText: 'Code de parrainage requis',
                                ),
                              ],
                            ),
                            Gap(30.h),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Montant",
                                  style: context.textTheme.titleLarge!.copyWith(
                                      color: AppColors.black,
                                      shadows: [
                                        const Shadow(
                                          offset: Offset(0.5, 0.5),
                                          blurRadius: 5.0,
                                          color: Colors.grey,
                                        ),
                                      ],
                                      fontWeight: FontWeight.w900),
                                ),
                                const Spacer(),
                                Text(
                                  "5000 Fcfa",
                                  style: context.textTheme.titleLarge!.copyWith(
                                      shadows: [
                                        const Shadow(
                                          offset: Offset(0.5, 0.5),
                                          blurRadius: 5.0,
                                          color: Colors.grey,
                                        ),
                                      ],
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w900),
                                )

                                // Text("5000 Fcfa"),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 20.h,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Opacity(
                    opacity: (_currentIndex == 0 ||
                            _currentIndex == 2 ||
                            (_currentIndex == 1 && _pm != null))
                        ? 1
                        : 0.5,
                    child: IgnorePointer(
                      ignoring: (_currentIndex == 0 ||
                              _currentIndex == 2 ||
                              (_currentIndex == 1 && _pm != null))
                          ? false
                          : true,
                      child: AppButton(
                        text: _currentIndex == 0 ? "Continuer" : "Valider",
                        height: 50.h,
                        onPressed: () {
                          if (_currentIndex == 0) {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                          }
                          if (_currentIndex == 1) {
                            if (_pm != null) {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear);
                            }
                          }
                          if (_currentIndex == 2) {
                            if (_formKey.currentState!.validate()) {
                              context.router.pushAndPopUntil(
                                const ApplicationRoute(),
                                predicate: (route) => false,
                              );
                            }
                          }
                        },
                        width: context.width - 20.w,
                        textColor: AppColors.white,
                        bgColor: AppColors.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Widget extends StatelessWidget {
  final String title;
  const _Widget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle,
          color: AppColors.primary,
          size: 30.r,
        ),
        Gap(15.w),
        SizedBox(
          width: 240.w,
          child: Text(
            title,
            style: context.textTheme.labelLarge!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w900,
              shadows: [
                const Shadow(
                  offset: Offset(0.5, 0.5),
                  blurRadius: 1.0,
                  color: Colors.grey,
                ),
              ],
            ),
            maxLines: 2,
          ),
        )
      ],
    );
  }
}
