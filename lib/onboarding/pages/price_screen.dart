import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:onbush/onboarding/logic/cubit/payment_cubit.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/application/cubit/application_cubit.dart';
import 'package:onbush/shared/device_info/device_info.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/hash/hash.dart';
import 'package:onbush/shared/local/local_storage.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_input.dart';
import 'package:onbush/shared/widget/app_radio_list_tile.dart';
import 'package:onbush/shared/widget/app_snackbar.dart';

@RoutePage()
class PriceScreen extends StatelessWidget {
  final String email;
  const PriceScreen({super.key, required this.email});

  // @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PaymentCubit(),
        child: PaymentWidget(
          email: email,
        ));
  }
}

class PaymentWidget extends StatefulWidget {
  final String email;
  const PaymentWidget({super.key, required this.email});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final PageController _pageController = PageController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _discountCodeController = TextEditingController();
  final TextEditingController _sponsorCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _discountCodeKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _phoneKey = GlobalKey<FormFieldState>();
  bool _isValid1 = false;
  bool _isValid2 = false;
  bool _sponsorCodeValue = false;
  bool _discountCodeValue = false;
  String? _pm;
  int _currentIndex = 0;
  Timer? _timer;
  late PaymentCubit paymentCubit;
  bool _isLoading = false;
  bool hasShownError = false;

  // bool _isValidate = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Sauvegarder la référence au PaymentCubit pour éviter l'utilisation dangereuse du contexte plus tard
    paymentCubit = context.read<PaymentCubit>();
  }

  @override
  void initState() {
    super.initState();
    // _isValid1 = _phoneKey.currentState?.isValid ?? false;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) async {
        int verificationAttempts = 0; // Compteur pour les tentatives

        if (state is PaymentSuccess) {
          setState(() {
            _isLoading = true;
            hasShownError = false;
          });

          await paymentCubit.verifying(transactionId: state.transactionId);

          _timer = Timer.periodic(const Duration(seconds: 25), (timer) async {
            verificationAttempts++;

            // Vérification de l'état
            await paymentCubit.verifying(transactionId: state.transactionId);

            if (verificationAttempts == 2) {
              // Dernière tentative, annule le timer
              setState(() {
                _isLoading = false;
              });
              timer.cancel();
            }
          });
        }

        if (state is PaymentFailure) {
          AppSnackBar.showError(
            message: state.message,
            context: context,
          );
        }

        if (state is VerifyingPaymentFailure) {
          if (state.message != "Transaction en cours") {
            if (_timer!.isActive == false) {
              // Montre une erreur après la dernière tentative si le timer est terminé
              AppSnackBar.showError(
                message: state.message,
                context: context,
              );
            }
          } else if (state.message == "Transaction echouee") {
            _timer!.cancel();
          } else {
            if (!hasShownError) {
              AppSnackBar.showSuccess(
                message: state.message,
                context: context,
              );
            }
            setState(() {
              hasShownError = true;
            });
            if (_timer!.isActive == false) {
              // Montre une erreur après la dernière tentative si le timer est terminé
              AppSnackBar.showError(
                message: state.message,
                context: context,
              );
            }
          }
        }

        if (state is VerifyingPaymentSuccess) {
          if (!context.mounted) return;

          AppSnackBar.showSuccess(
            message: "Transaction réussie",
            context: context,
          );

          context.read<ApplicationCubit>().setUser(state.user);

          await Future.delayed(const Duration(milliseconds: 1000));

          context.router.push(const ApplicationRoute());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: IgnorePointer(
              ignoring: _isLoading,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 3),
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
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
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
                                child: Column(
                                  children: [
                                    Gap(290.h),
                                    Text(
                                      "Apprends sans limites avec OnBush",
                                      style: context.textTheme.headlineMedium!
                                          .copyWith(
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
                                    Gap(45.h),
                                    Opacity(
                                      opacity: _pm != null ? 1 : 0.3,
                                      child: IgnorePointer(
                                        ignoring: _pm != null ? false : true,
                                        child: InternationalPhoneNumberInput(
                                          // key: _phoneKey,
                                          fieldKey: _phoneKey,
                                          onInputChanged:
                                              (PhoneNumber value) {},
                                          onInputValidated: (value) {
                                            setState(() {
                                              _isValid1 = value;
                                            });
                                          },

                                          // validator: (p0) {},
                                          initialValue:
                                              PhoneNumber(isoCode: 'CM'),
                                          errorMessage:
                                              "Numero de telephone invalide",
                                          selectorConfig: const SelectorConfig(
                                            selectorType: PhoneInputSelectorType
                                                .BOTTOM_SHEET,
                                            useBottomSheetSafeArea: true,
                                            setSelectorButtonAsPrefixIcon: true,
                                            leadingPadding: 10,
                                          ),

                                          // inputBorder: const OutlineInputBorder(
                                          //   borderSide:
                                          //       BorderSide(color: Colors.red),
                                          // ),
                                          inputDecoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade500,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors.black,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r)),
                                              disabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade500,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r)),
                                              // enabledBorder: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade500),
                                              hintText: "Numero de telephone"),
                                          ignoreBlank: false,
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          selectorTextStyle: const TextStyle(
                                              color: Colors.black),
                                          textFieldController: _phoneController,

                                          formatInput: true,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(
                                              signed: true, decimal: true),

                                          // inputBorder: context.theme.inputDecorationTheme.border!
                                          //     .copyWith(
                                          //         borderSide: BorderSide(color: Colors.red)),
                                        ),
                                      ),
                                    ),
                                    Gap(20.h),
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
                                      value: "orange",
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
                                      value: "mtn",
                                    ),
                                    Gap(30.h),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Montant",
                                          style: context.textTheme.titleLarge!
                                              .copyWith(
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
                                          style: context.textTheme.titleLarge!
                                              .copyWith(
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
                                    ),
                                    Gap(30.h),
                                  ],
                                ),
                              ),
                              Container(
                                width: context.width,
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
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.linear);
                                            },
                                          ),
                                          const Spacer(),
                                          Text(
                                            "Code de reduction ou de\nparrainage",
                                            maxLines: 2,
                                            style: context
                                                .textTheme.headlineMedium!
                                                .copyWith(
                                                    color: AppColors.black,
                                                    shadows: [
                                                      const Shadow(
                                                        offset:
                                                            Offset(0.5, 0.5),
                                                        blurRadius: 1.0,
                                                        color: Colors.grey,
                                                      ),
                                                    ],
                                                    fontWeight:
                                                        FontWeight.w900),
                                            textAlign: TextAlign.center,
                                          ),
                                          const Spacer()
                                        ],
                                      ),
                                      Gap(30.h),
                                      IgnorePointer(
                                        ignoring: _discountCodeValue,
                                        child: Opacity(
                                          opacity: _discountCodeValue ? 0.5 : 1,
                                          child: AppInput(
                                            formFieldKey: _discountCodeKey,
                                            hint:
                                                "Entrer code de reduction si vous en avez un",
                                            onChange: (value) {
                                              setState(() {
                                                _sponsorCodeValue =
                                                    value.isNotEmpty;
                                              });
                                            },
                                            controller: _discountCodeController,
                                            keyboardType: TextInputType.text,
                                            validators: [
                                              FormBuilderValidators.required()
                                            ],
                                            onInputValidated: (value) {
                                              setState(() {
                                                _isValid2 = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Gap(30.h),
                                      IgnorePointer(
                                        ignoring: _sponsorCodeValue,
                                        child: Opacity(
                                          opacity: _sponsorCodeValue ? 0.5 : 1,
                                          child: AppInput(
                                            hint:
                                                "Entrer code de parrainage si vous en avez un",
                                            onChange: (value) {
                                              _discountCodeValue =
                                                  value.isNotEmpty;
                                            },
                                            controller: _sponsorCodeController,
                                            keyboardType: TextInputType.text,
                                            onInputValidated: (value) {
                                              setState(() {
                                                _isValid2 = value;
                                              });
                                            },
                                            validators: [
                                              FormBuilderValidators.required(),

                                              // FormBuilderValidators.()
                                            ],
                                          ),
                                        ),
                                      ),
                                      Gap(30.h),
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
                                      (_currentIndex == 1 &&
                                          _pm != null &&
                                          _isValid1))
                                  ? 1
                                  : 0.5,
                              child: IgnorePointer(
                                  ignoring: (_currentIndex == 0 ||
                                          _currentIndex == 2 ||
                                          (_currentIndex == 1 &&
                                              _pm != null &&
                                              _isValid1))
                                      ? false
                                      : true,
                                  child: _currentIndex != 2
                                      ? AppButton(
                                          text: _currentIndex == 0
                                              ? "Continuer"
                                              : "Valider",
                                          height: 50.h,
                                          onPressed: () {
                                            if (_currentIndex == 0) {
                                              _pageController.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.linear);
                                            }
                                            if (_currentIndex == 1 &&
                                                _phoneKey.currentState!
                                                    .validate() &&
                                                _pm != null) {
                                              _pageController.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.linear);
                                            }
                                          },
                                          width: context.width - 20.w,
                                          textColor: AppColors.white,
                                          loading: state is PaymentLoading,
                                          bgColor: AppColors.secondary,
                                        )
                                      : Column(
                                          children: [
                                            IgnorePointer(
                                              ignoring: !_isValid2,
                                              child: Opacity(
                                                opacity: !_isValid2 ? 0.3 : 1,
                                                child: AppButton(
                                                  width: context.width,
                                                  text: "Valider mon compte",
                                                  loading:
                                                      state is PaymentLoading,
                                                  onPressed: () {
                                                    context.read<PaymentCubit>().initPayment(
                                                        appareil: getIt
                                                            .get<LocalStorage>()
                                                            .getString(
                                                                'device')!,
                                                        email: widget.email,
                                                        phoneNumber:
                                                            _phoneController
                                                                .text
                                                                .replaceAll(
                                                                    ' ', ''),
                                                        paymentService: _pm!,
                                                        amount: 20,
                                                        sponsorCode:
                                                            _sponsorCodeController
                                                                .text
                                                                .replaceAll(
                                                                    ' ', ''),
                                                        discountCode:
                                                            _discountCodeController
                                                                .text
                                                                .replaceAll(
                                                                    ' ', ''));
                                                  },
                                                  textColor: AppColors.white,
                                                  bgColor: AppColors.primary,
                                                ),
                                              ),
                                            ),
                                            Gap(20.h),
                                            AppButton(
                                              width: context.width,
                                              text: "Pas de compte? Continuer",
                                              loading:
                                                  (state is PaymentLoading),
                                              onPressed: () {
                                                context
                                                    .read<PaymentCubit>()
                                                    .initPayment(
                                                        appareil: getIt
                                                            .get<LocalStorage>()
                                                            .getString(
                                                                'device')!,
                                                        email: widget.email,
                                                        phoneNumber:
                                                            _phoneController
                                                                .text
                                                                .replaceAll(
                                                                    ' ', ''),
                                                        paymentService: _pm!,
                                                        amount: 20,
                                                        sponsorCode: "0",
                                                        discountCode: "0");
                                              },
                                              textColor: AppColors.primary,
                                              bgColor: AppColors.ternary,
                                            )
                                          ],
                                        )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _isLoading
                      ? Positioned.fill(
                          child: Container(
                            color: Colors.black
                                .withOpacity(0.5), // Assombrir l'écran
                            child: const Center(
                              child:
                                  CircularProgressIndicator(), // Indicateur de chargement
                            ),
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        );
      },
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
