import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/history/logic/history_cubit/game_history_cubit.dart';
import 'package:onbush/history/presentation/widgets/game_history_widget.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/theme/app_colors.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final GameHistoryCubit _cubit = GameHistoryCubit();
  final ScrollController _scrollController = ScrollController();
  final int _page = 1;

  @override
  void initState() {
    super.initState();
    // _cubit.fetch(); // Initial fetch of data
    // _scrollController.addListener(_onScroll);
  }

  // void _onScroll() {
  //   if (_scrollController.position.pixels >=
  //       _scrollController.position.maxScrollExtent) {
  //     _cubit.fetch();
  //   }
  // }

  // Future<void> _onRefresh() async {
  //   await _cubit.fetch(); // Reload data on pull-to-refresh
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      body: BlocBuilder<GameHistoryCubit, GameHistoryState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is GameHistoryStateSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
                    itemCount: _cubit.hasReachedMax
                        ? state.listGameHistory.length
                        : state.listGameHistory.length + 1,
                    separatorBuilder: (context, i) => Gap(26.h),
                    itemBuilder: (context, index) {
                      if (index < state.listGameHistory.length) {
                        final gameHistory = state.listGameHistory[index];
                        return GameHistoryWidget(
                          amount: gameHistory.amount,
                          cote: gameHistory.cote,
                          createdAt: gameHistory.createdAt,
                          gain: gameHistory.gain,
                        );
                      }
                      if (!_cubit.hasReachedMax) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            );
          }
          if (state is GameHistoryStateFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Échec du chargement. Veuillez réessayer."),
                  const SizedBox(height: 16),
                  Text(
                    "Réessayer",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is GameHistoryStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            width: context.width,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(40.h),
                Text(
                  "Votre historique",
                  style: context.textTheme.titleMedium!.copyWith(),
                ),
                Gap(20.h),
                Container(
                  height: 90.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/leading-icon.png",
                        fit: BoxFit.fill,
                        height: 60.h,
                        color: AppColors.black,
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200.w,
                            child: Text(
                              "Lorem ipsum indolors apsum Lorem ipsum indolors apsum 90",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontSize: 14.r, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          // Spacer(),
                          SizedBox(
                            width: 220.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Resume de cours",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 13.r,
                                      color: Colors.grey.shade600),
                                ),
                                Text(
                                  "Il y'a 2h",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 13.r,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 16.r,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
