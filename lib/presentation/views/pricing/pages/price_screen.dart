import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:onbush/presentation/blocs/payment/payment_cubit.dart';
import 'package:onbush/presentation/views/pricing/widgets/payment_bottom_navigation.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/shared/widget/app_input.dart';
import 'package:onbush/core/shared/widget/app_radio_list_tile.dart';
import 'package:onbush/core/shared/widget/app_snackbar.dart';
import 'package:onbush/service_locator.dart';

@RoutePage()
class PriceScreen extends StatelessWidget {
  final String email;
  const PriceScreen({super.key, required this.email});

  // @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<PaymentCubit>(),
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
  int _amount = 5000;

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
        await _handlePaymentState(context, state);
      },
      builder: (context, state) {
        print("state $state");
        // _isLoading = false;
        return Scaffold(
          body: SafeArea(
            child: Form(
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
                            height: context.height - 50.h,
                            child: PageView(
                              allowImplicitScrolling: true,
                              controller: _pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              onPageChanged: (page) {
                                setState(() {
                                  _currentIndex = page;
                                });
                              },
                              children: [
                                _buildIntroPage(context),
                                _buildCodeInputPage(context),
                                _buildPaymentPage(context),
                              ],
                            ),
                          ),
                          PaymentBottomNavigation(
                              amount: _amount,
                              paymentCubit: paymentCubit,
                              state: state,
                              currentIndex: _currentIndex,
                              pm: _pm,
                              isValid1: _isValid1,
                              pageController: _pageController,
                              phoneKey: _phoneKey,
                              widget: widget,
                              phoneController: _phoneController,
                              sponsorCodeController: _sponsorCodeController,
                              discountCodeController: _discountCodeController,
                              isValid2: _isValid2),
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
          ),
        );
      },
    );
  }

  Widget _buildIntroPage(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Gap(290.h),
          Text(
            "Apprends sans limite avec OnBush",
            style: context.textTheme.headlineMedium!.copyWith(
              color: AppColors.primary,
              shadows: [
                const Shadow(
                    offset: Offset(0.5, 0.5),
                    blurRadius: 1.0,
                    color: Colors.grey)
              ],
              fontWeight: FontWeight.w900,
            ),
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
        ],
      ),
    );
  }

  Widget _buildCodeInputPage(BuildContext context) {
    return Container(
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
                  onPressed: () => _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  ),
                ),
                const Spacer(),
                Text(
                  "Code de reduction ou de\nParrainage",
                  maxLines: 2,
                  style: context.textTheme.headlineSmall!.copyWith(
                    color: AppColors.black,
                    shadows: [
                      const Shadow(
                          offset: Offset(0.5, 0.5),
                          blurRadius: 1.0,
                          color: Colors.grey)
                    ],
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
              ],
            ),
            Gap(30.h),
            _buildCodeInputField(
              context,
              hint: "Entrer code de reduction si vous en avez un",
              controller: _discountCodeController,
              isDisabled: _discountCodeValue,
              onChanged: (value) {
                setState(() {
                  print("value 1 $value");
                  _sponsorCodeValue = value.isNotEmpty;
                });
              },
            ),
            Gap(30.h),
            _buildCodeInputField(
              context,
              hint: "Entrer code de Parrainage si vous en avez un",
              controller: _sponsorCodeController,
              isDisabled: _sponsorCodeValue,
              onChanged: (value) {
                print("value 2 $value");

                _discountCodeValue = value.isNotEmpty;
              },
            ),
            Gap(30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeInputField(BuildContext context,
      {required String hint,
      required TextEditingController controller,
      required bool isDisabled,
      required void Function(String) onChanged}) {
    return IgnorePointer(
      ignoring: isDisabled,
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1,
        child: AppInput(
          hint: hint,
          onChange: onChanged,
          controller: controller,
          keyboardType: TextInputType.text,
          validators: [FormBuilderValidators.required()],
          onInputValidated: (value) {
            setState(() {
              _isValid2 = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildPaymentPage(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Gap(290.h),
          _buildPaymentHeader(context),
          Gap(45.h),
          _buildPhoneInput(context),
          Gap(20.h),
          _buildPaymentOption("Orange Money", "orange"),
          Gap(20.h),
          _buildPaymentOption("Mobile Money", "mtn"),
          Gap(30.h),
          _buildAmountDisplay(context),
          Gap(30.h),
        ],
      ),
    );
  }

  Widget _buildPaymentHeader(BuildContext context) {
    return Row(
      children: [
        AppButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
          },
        ),
        const Spacer(),
        Container(
          constraints: BoxConstraints(maxWidth: context.width - 100.w),
          child: Text(
            "Choisis ton moyen de paiement",
            style: context.textTheme.headlineSmall!.copyWith(
              color: AppColors.black,
              shadows: [
                const Shadow(
                    offset: Offset(0.5, 0.5),
                    blurRadius: 1.0,
                    color: Colors.grey)
              ],
              fontWeight: FontWeight.w900,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildPhoneInput(BuildContext context) {
    return Opacity(
      opacity: _pm != null ? 1 : 0.3,
      child: IgnorePointer(
        ignoring: _pm == null,
        child: InternationalPhoneNumberInput(
          fieldKey: _phoneKey,
          onInputChanged: (_) {},
          onInputValidated: (value) {
            setState(() {
              _isValid1 = value;
            });
          },
          initialValue: PhoneNumber(isoCode: 'CM'),
          errorMessage: "Numero de telephone invalide",
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            useBottomSheetSafeArea: true,
            setSelectorButtonAsPrefixIcon: true,
            leadingPadding: 10,
          ),
          inputDecoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(10.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.black),
              borderRadius: BorderRadius.circular(10.r),
            ),
            hintStyle: TextStyle(color: Colors.grey.shade500),
            hintText: "Numero de telephone",
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectorTextStyle: const TextStyle(color: Colors.black),
          textFieldController: _phoneController,
          formatInput: true,
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, String value) {
    return AppRadioListTile(
      title: title,
      activeColor: AppColors.primary,
      groupeValue: _pm,
      selectedColor: AppColors.primary,
      onChanged: (String? val) {
        setState(() {
          _pm = val!;
        });
      },
      value: value,
    );
  }

  Widget _buildAmountDisplay(BuildContext context) {
    return Row(
      children: [
        Text(
          "Montant",
          style: context.textTheme.titleLarge!.copyWith(
            color: AppColors.black,
            shadows: [
              const Shadow(
                  offset: Offset(0.5, 0.5), blurRadius: 5.0, color: Colors.grey)
            ],
            fontWeight: FontWeight.w900,
          ),
        ),
        const Spacer(),
        Text(
          "$_amount Fcfa",
          style: context.textTheme.titleLarge!.copyWith(
            shadows: [
              const Shadow(
                  offset: Offset(0.5, 0.5), blurRadius: 5.0, color: Colors.grey)
            ],
            color: AppColors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Future<void> _handlePaymentState(BuildContext context, dynamic state) async {
    int verificationAttempts = 0;
    bool isVerifying = false;

    if (state is PaymentSuccess) {
      if (state.user != null) {
        setState(() {
          _isLoading = false;
        });

        AppSnackBar.showSuccess(
          message: "Transaction réussie",
          context: context,
        );

        context.read<ApplicationCubit>().setUser(state.user);
        await Future.delayed(const Duration(milliseconds: 1000));
        context.router.push(const ApplicationRoute());
      }

      if (state.transactionId == null) {
        AppSnackBar.showSuccess(
          message: "Transaction réussie",
          context: context,
        );

        await Future.delayed(const Duration(milliseconds: 1300));
        context.router.popAndPush(const ApplicationRoute());
      } else {
        isVerifying = true;

        setState(() {
          _isLoading = true;
          hasShownError = false;
        });

        Completer<void> verificationCompleter = Completer<void>();
        await paymentCubit.verifying(transactionId: state.transactionId!);

        _timer = Timer.periodic(const Duration(seconds: 15), (timer) async {
          setState(() {});
          verificationAttempts++;

          await paymentCubit.verifying(transactionId: state.transactionId!);

          if (verificationAttempts == 2) {
            timer.cancel();
            setState(() {
              _isLoading = false;
            });

            verificationCompleter.complete();
          }
        });

        await verificationCompleter.future;
        isVerifying = false;
      }
    }

    if (state is PercentStateFailure) {
      AppSnackBar.showError(
        message: "Code de réduction incorrect",
        context: context,
      );
    }

    if (state is PaymentFailure) {
      AppSnackBar.showError(
        message: state.message,
        context: context,
      );
    }

    if (state is PercentStateSucess) {
      setState(() {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );

        _amount = state.percent;
      });
    }

    if (state is VerifyingPaymentFailure) {
      if (state.message != "Transaction en cours") {
        if (verificationAttempts == 2) {
          setState(() {
            _isLoading = false;
          });
        }

        setState(() {
          _isLoading = true;
        });

        if (!(_timer?.isActive ?? false)) {
          AppSnackBar.showError(
            message: state.message,
            context: context,
          );
        }
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

        if (!(_timer?.isActive ?? false)) {
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
