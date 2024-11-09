import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/game/logic/bloc/crash_game_bloc.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/application/cubit/application_cubit.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/pages/home_screen.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/onbush_app_bar.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/const.dart';
import '../../../shared/widget/app_dialog.dart';

@RoutePage()
class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
    required this.bet,
  });
  final double bet;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late CrashGameBloc crashGameBloc;
  final ApplicationCubit _applicationCubit = getIt.get<ApplicationCubit>();

  @override
  void initState() {
    crashGameBloc = CrashGameBloc(bet: widget.bet);

    super.initState();
  }

  @override
  void dispose() {
    // crashGameBloc.dispose();
    crashGameBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.router.pushAndPopUntil(
              const HomeRoute(),
              predicate: (route) => false,
            );
          },
          child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.arrow_back_ios_new)),
        ),
        title: const OnbushAppBar(title: 'Home'),
        toolbarHeight: 70.h,
      ),
      body: BlocConsumer<CrashGameBloc, CrashGameState>(
        bloc: crashGameBloc,
        listener: (context, state) {
          if (state is CrashGameLost || state is CrashGameWon) {
            AppDialog.showDialog(
              context: context,
              width: 300,
              height: 270,
              child: _GameResultDialog(
                crashGameBloc: crashGameBloc,
              ),
            );
            Future.delayed(const Duration(milliseconds: 300),
                () async => await _applicationCubit.setUser());
          }
        },
        builder: (context, state) {
          if (state is CrashGameInitial) {
            return Column(
              children: [
                const Spacer(flex: 2),
                Text(
                  "The game starts in 👇",
                  textAlign: TextAlign.center,
                  style: context.textTheme.displayMedium?.copyWith(
                    fontSize: 26.sp,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${state.countDown}",
                      style: context.textTheme.displayLarge?.copyWith(
                        color: AppColors.white,
                        fontSize: 120,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        widget.bet.toStringAsFixed(2),
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "nkap",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),
              ],
            );
          }

          if (state is CrashGamePlaying) {
            return Column(
              children: [
                const Spacer(flex: 2),
                Container(
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      state.multiplier.toStringAsFixed(2),
                      style: context.textTheme.displayLarge?.copyWith(
                        color: AppColors.white,
                        fontSize: 70.sp,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "x",
                      style: context.textTheme.displayLarge?.copyWith(
                        color: AppColors.primary,
                        fontSize: 40.sp,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        (state.bet * state.multiplier).toStringAsFixed(2),
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "nkap",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: padding24,
                  ),
                  child: AppButton(
                    bgColor: AppColors.primary,
                    text: "Stop",
                    onPressed: () {
                      crashGameBloc.add(
                        CashOutCrashGameWinningsEvent(
                          multiplier: state.multiplier,
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(flex: 2),
              ],
            );
          }

          if (state is CrashGameDefault) {
            return SingleChildScrollView(
              child: SizedBox(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height - 70.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const Spacer(flex: 2),
                    Gap(20.h),
                    Center(
                      child: ZoomIn(
                        child: Image.asset(
                          "assets/images/onbush_bet.png",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: padding16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.bet.toStringAsFixed(2),
                            style: context.textTheme.displayLarge?.copyWith(
                              fontSize: 40.sp,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            "nkap",
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    Gap(30.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: padding24,
                      ),
                      child: AppButton(
                        bgColor: AppColors.primary,
                        text: "Start",
                        onPressed: () {
                          crashGameBloc.add(InitializeCrashGameEvent());
                        },
                      ),
                    ),
                    Gap(10.h),
                    // const Spacer(flex: 2),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Spacer(flex: 2),
                Gap(20.h),
                Center(
                  child: ZoomIn(
                    child: Image.asset(
                      "assets/images/onbush_bet.png",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: padding16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.bet.toStringAsFixed(2),
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 40.sp,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        "nkap",
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                Gap(30.h),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: padding24,
                  ),
                  child: AppButton(
                    bgColor: AppColors.primary,
                    text: "Start",
                    onPressed: () {
                      crashGameBloc.add(InitializeCrashGameEvent());
                    },
                  ),
                ),
                Gap(10.h),
                // const Spacer(flex: 2),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GameResultDialog extends StatelessWidget {
  const _GameResultDialog({
    required this.crashGameBloc,
  });
  final CrashGameBloc crashGameBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrashGameBloc, CrashGameState>(
      bloc: crashGameBloc,
      builder: (context, state) {
        if (state is CrashGameLost) {
          return Padding(
            padding: const EdgeInsets.all(padding16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Too bad you lost",
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: 24,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      state.bet.toStringAsFixed(2),
                      style: context.textTheme.displayLarge?.copyWith(
                        color: AppColors.red,
                        fontSize: 35.sp,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "nkap",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        bgColor: AppColors.primary,
                        text: 'New part',
                        onPressed: () {
                          context.router.popForced();
                          AppDialog.showDialog(
                            context: context,
                            width: 300,
                            height: 270,
                            child: const PlaceABetWidget(),
                          );
                        },
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: AppButton(
                        borderColor: AppColors.primary,
                        text: 'Back to home',
                        onPressed: () {
                          context.router.pushAndPopUntil(
                            const HomeRoute(),
                            predicate: (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        if (state is CrashGameWon) {
          return Padding(
            padding: const EdgeInsets.all(padding16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Congratulations you won",
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: 24,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      state.winnings.toStringAsFixed(2),
                      style: context.textTheme.displayLarge?.copyWith(
                        color: AppColors.green,
                        fontSize: 35.sp,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "nkap",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        bgColor: AppColors.primary,
                        text: 'New part',
                        onPressed: () {
                          context.router.popForced();
                          AppDialog.showDialog(
                            context: context,
                            width: 300,
                            height: 270,
                            child: const PlaceABetWidget(),
                          );
                          // crashGameBloc.add(event);
                          // context.router.pushAndPopUntil(
                          //   const HomeRoute(),
                          //   predicate: (route) => false,
                          // );
                        },
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: AppButton(
                        borderColor: AppColors.primary,
                        text: 'Back to home',
                        onPressed: () {
                          context.router.pushAndPopUntil(
                            const HomeRoute(),
                            predicate: (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
