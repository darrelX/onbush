import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Checkout succesfull",
          textAlign: TextAlign.center,
          style: context.textTheme.headlineMedium?.copyWith(),
        ),
        Text(
          'A ticket has been created with your order in history',
          style: context.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        AppButton(
          bgColor: AppColors.primary,
          text: 'see my ticket',
          onPressed: () {
            context.router.pushAndPopUntil(
              const HistoryRoute(),
              predicate: (route) => false,
            );
          },
        ),
        AppButton(
          borderColor: AppColors.primary,
          text: 'cree un autre tiquet',
          onPressed: () {
            context.router.maybePop();
          },
        )
      ],
    );
  }
}
