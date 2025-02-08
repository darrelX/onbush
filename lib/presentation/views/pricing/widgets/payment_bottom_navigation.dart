import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/presentation/views/pricing/logic/cubit/payment_cubit.dart';
import 'package:onbush/presentation/views/pricing/pages/price_screen.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';

class PaymentBottomNavigation extends StatelessWidget {
  const PaymentBottomNavigation({
    super.key,
    required int currentIndex,
    required PaymentCubit paymentCubit,
    required this.amount,
    required String? pm,
    required bool isValid1,
    required PageController pageController,
    required GlobalKey<FormFieldState> phoneKey,
    required this.widget,
    required this.state,
    required TextEditingController phoneController,
    required TextEditingController sponsorCodeController,
    required TextEditingController discountCodeController,
    required bool isValid2,
  })  : _currentIndex = currentIndex,
        _paymentCubit = paymentCubit,
        _pm = pm,
        _isValid1 = isValid1,
        _pageController = pageController,
        _phoneKey = phoneKey,
        _phoneController = phoneController,
        _sponsorCodeController = sponsorCodeController,
        _discountCodeController = discountCodeController,
        _isValid2 = isValid2;

  final int _currentIndex;
  final int amount;
  final PaymentCubit _paymentCubit;
  final String? _pm;
  final PaymentState state;
  final bool _isValid1;
  final PageController _pageController;
  final GlobalKey<FormFieldState> _phoneKey;
  final PaymentWidget widget;
  final TextEditingController _phoneController;
  final TextEditingController _sponsorCodeController;
  final TextEditingController _discountCodeController;
  final bool _isValid2;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.h,
      left: 0,
      right: 0,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: _currentIndex != 1
              ? Opacity(
                  opacity: (_currentIndex == 0 ||
                          (_currentIndex == 2 && _pm != null && _isValid1))
                      ? 1
                      : 0.5,
                  child: IgnorePointer(
                      ignoring: (_currentIndex == 0 ||
                              (_currentIndex == 2 && _pm != null && _isValid1))
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
                          if (_currentIndex == 2 &&
                              _phoneKey.currentState!.validate() &&
                              _pm != null) {
                            context.read<PaymentCubit>().initPayment(
                                appareil: getIt
                                    .get<LocalStorage>()
                                    .getString('device')!,
                                email: widget.email,
                                phoneNumber:
                                    _phoneController.text.replaceAll(' ', ''),
                                paymentService: _pm,
                                amount: amount,
                                sponsorCode: _sponsorCodeController.text
                                    .replaceAll(' ', ''),
                                discountCode: _discountCodeController.text
                                    .replaceAll(' ', ''));
                          }
                        },
                        width: context.width - 20.w,
                        textColor: AppColors.white,
                        loading: state is PaymentLoading,
                        bgColor: AppColors.secondary,
                      )),
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
                          loading: state is PercentStateLoading,
                          onPressed: () {
                            if (_discountCodeController.text.isNotEmpty) {
                              _paymentCubit.percent(
                                  code:
                                      int.parse(_discountCodeController.text));
                            } else {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear);
                            }
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
                      loading: (state is PercentStateLoading),
                      onPressed: () {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      textColor: AppColors.primary,
                      bgColor: AppColors.ternary,
                    )
                  ],
                )),
    );
  }
}
