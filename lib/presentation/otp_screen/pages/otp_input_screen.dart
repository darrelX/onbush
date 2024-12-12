import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/presentation/otp_screen/logic/otp_cubit/otp_bloc.dart';
import 'package:onbush/presentation/auth/widgets/pin_code_widget.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/theme/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/shared/widget/app_input.dart';
import 'package:onbush/core/shared/widget/app_snackbar.dart';

@RoutePage()
class OTPInputScreen extends StatefulWidget {
  final String email;
  final String type;

  const OTPInputScreen({
    super.key,
    this.type = 'register',
    required this.email,
  });

  @override
  State createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OTPInputScreen> {
  final GlobalKey<FormState> _formField = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  bool _isExpired = false;
  String? _error;
  String? _currentText;
  late final OtpBloc _bloc = context.read<OtpBloc>();

  String _formatSeconds(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2)}:${seconds.toString().padLeft(2, "0")}min';
  }

  @override
  void initState() {
    super.initState();
    _bloc.add(const OtpInitialized());
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _reFresh() async {
    _bloc.add(const OtpInitialized());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "Verification du numero",
          style: context.textTheme.titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
      ),
      body: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is OtpSendFailure) {
            setState(() {
              _error = state.errorMessage;
              AppSnackBar.showError(
                message: state.errorMessage,
                context: context,
              );
            });
          }
          if (state is OtpExpired) {
            setState(() {
              _isExpired = true;
            });
          }
          if (state is OtpSentInProgress && _isExpired == true) {
            setState(() {
              _isExpired = false;
            });
          }
          if (state is OtpVerificationSuccess) {
            if (state.user == null) {
              context.router.push(PriceRoute(email: widget.email));
            } else {
              getIt.get<ApplicationCubit>().setUser(state.user!);
              context.router.push(const AppInitRoute());
            }
          }
        },
        builder: (context, state) {
          print("state $state ");
          if (state is OtpLoadingState) {
            return Container(
              decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.vertical(
                  //   top: Radius.circular(30),
                  // ),
                  color: Colors.white),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          // if (state is OtpSendFailure && _isExpired) {
          //   return Container(
          //     decoration: const BoxDecoration(
          //         borderRadius: BorderRadius.vertical(
          //           top: Radius.circular(30),
          //         ),
          //         color: Colors.white),
          //     child: Center(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const Text("Échec du chargement. Veuillez réessayer."),
          //           const SizedBox(height: 16),
          //           ElevatedButton(
          //             onPressed: _reFresh,
          //             child: Text(
          //               "Réessayer",
          //               style: context.textTheme.bodyMedium?.copyWith(
          //                 color: AppColors.black,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   );
          // }

          return SafeArea(
            child: Form(
              key: _formField,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 35.w,
                ),
                height: context.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Gap(30.h),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: context.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  'Un code à 6 chiffres a été envoyé à ton adresse email ',
                            ),
                            TextSpan(
                              text: widget.email,
                              style: TextStyle(
                                color:
                                    AppColors.primary, // Met le texte en bleu
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  '. Veuillez entrer le code pour valider ton inscription.',
                            ),
                          ],
                        ),
                      ),
                      Gap(40.h),
                      AppInput(
                        hint: "Code",
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        validators: [
                          FormBuilderValidators.numeric(),
                          // FormBuilderValidators.equalLength(6, errorText: ""),
                          FormBuilderValidators.required(
                              errorText: "Veillez entrer le code"),
                        ],
                      ),
                      Gap(10.h),
                      Visibility(
                        visible: !_isExpired,
                        child: SizedBox(
                          width: 250.w,
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    const TextSpan(text: "Temps restants :"),
                                    TextSpan(
                                        text: _formatSeconds(state.countDown),
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.bold))
                                  ])),
                        ),
                      ),
                      Gap(170.h),
                      Opacity(
                        opacity: _isExpired ? 0.5 : 1,
                        child: IgnorePointer(
                          ignoring: _isExpired,
                          child: AppButton(
                              bgColor: AppColors.primary,
                              width: double.infinity,
                              loading: state is OtpVerifying,
                              text: "Valider",
                              onPressed: () {
                                if (_formField.currentState!.validate()) {
                                  context.read<OtpBloc>().add(OtpSubmitted(
                                      type: widget.type,
                                      otp: int.parse(_codeController.text
                                          .replaceAll(' ', '')),
                                      device: getIt
                                          .get<LocalStorage>()
                                          .getString('device')!,
                                      email: widget.email));
                                }
                              }),
                        ),
                      ),
                      Gap(20.h),
                      Opacity(
                        opacity: !_isExpired ? 0.5 : 1,
                        child: IgnorePointer(
                          ignoring: !_isExpired,
                          child: AppButton(
                              bgColor: AppColors.primary,
                              width: double.infinity,
                              loading: state is OtpVerifying,
                              text: "Renvoyer le code OTP",
                              onPressed: () {
                                setState(() {
                                  context.read<OtpBloc>().add(OtpReset(
                                      type: widget.type,
                                      device: getIt
                                          .get<LocalStorage>()
                                          .getString('device')!,
                                      email: widget.email));

                                  if (state is OtpVerificationSuccess) {
                                    print("Success");
                                  } else if (state is OtpVerificationFailure) {
                                    print("No Success");
                                  }
                                });
                              }),
                        ),
                      ),
                      Gap(140.h),
                      Image.asset(
                        "assets/images/onbush.png",
                        height: 50.h,
                      ),
                      Gap(20.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
