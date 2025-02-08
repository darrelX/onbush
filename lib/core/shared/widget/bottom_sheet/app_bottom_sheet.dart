
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/shared/widget/app_input.dart';

import '../../../constants/colors/app_colors.dart';

class AppBottomSheet {
  static showBottomSheet({
    required BuildContext context,
    required Widget builder,
    AnimationController? transitionController,
    Color? backgroundColor,
    double? height,
  }) async {
    await showModalBottomSheet(
        context: context,
        transitionAnimationController: transitionController,
        // backgroundColor: backgroundColor,
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: height ?? context.height * .8,
          minWidth: 0.0,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (modalContext) {
          return Container(
            width: modalContext.width,
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(10.h),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 6.h,
                        bottom: 30.h,
                      ),
                      child: Container(
                        height: 5.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  builder
                ],
              ),
            ),
          );
        });
  }

  static showSearchBottomSheet({
    required Map<int, String> allItems,
    required BuildContext context,
    required TextEditingController resultController,
    bool isLoading = false,
    bool error = false,
    String? title,
    String? hint,
    Widget? child,
  }) async {
    // Completer<T> completer = Completer<T>();

    // Controller pour la recherche
    final TextEditingController searchController = TextEditingController();
    int? selectedCheckboxIndex;
    List<MapEntry<int, String>> filteredItems = allItems.entries.toList();

    return await showModalBottomSheet(
        context: context,
        // backgroundColor: backgroundColor,
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: context.height * .8,
          minWidth: 0.0,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return Container(
            width: context.width,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(10.h),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 6.h,
                        bottom: 30.h,
                      ),
                      child: Container(
                        height: 5.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setModalState) {
                      assert(
                        (child == null && title != null) ||
                            (child != null && title == null),
                        "Either `child` must be non-null and `title` null, or `title` non-null and `child` null.",
                      );
                      void filterItems() {
                        final query = searchController.text.toLowerCase();
                        setModalState(() {
                          filteredItems = allItems.entries
                              .where((item) =>
                                  item.value.toLowerCase().contains(query))
                              .toList();
                        });
                      }

                      // Ajoute le listener au contrôleur
                      searchController.addListener(filterItems);
                      return Expanded(
                        child: child ??
                            Column(
                              children: [
                                // Titre et bouton de retour
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: AppButton(
                                            onPressed: () =>
                                                context.router.popForced(),
                                            child: const Icon(Icons.arrow_back),
                                          ),
                                        ),
                                      ),
                                      if (title != null)
                                        Text(
                                          title,
                                          style: context.textTheme.titleLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      const Spacer()
                                    ],
                                  ),
                                ),
                                Gap(20.h),
                                // Champ de recherche
                                AppInput(
                                  controller: searchController,
                                  prefix: const Icon(Icons.search),
                                  hint: hint ?? "Chercher ...",
                                ),
                                Gap(20.h),
                                Expanded(
                                    child: !isLoading
                                        ? ListView.separated(
                                            itemCount: filteredItems.length,
                                            separatorBuilder: (_, __) =>
                                                Gap(10.h),
                                            itemBuilder: (context, index) {
                                              final item = filteredItems[index];
                                              return CheckboxListTile(
                                                checkboxShape:
                                                    const CircleBorder(),
                                                value: selectedCheckboxIndex ==
                                                    index,
                                                side: const BorderSide(
                                                    color: AppColors.primary,
                                                    width: 2),
                                                onChanged: (bool? isSelected) {
                                                  if (isSelected == true) {
                                                    setModalState(() {
                                                      selectedCheckboxIndex =
                                                          index;
                                                      resultController.text =
                                                          filteredItems[index]
                                                              .value;
                                                    });
                                                    Navigator.pop(
                                                        context,
                                                        filteredItems[index]
                                                            .key);
                                                  } else {
                                                    setModalState(() {
                                                      selectedCheckboxIndex =
                                                          null;
                                                      resultController.clear();
                                                    });
                                                  }
                                                },
                                                title: Text(
                                                  item.value,
                                                  style: context
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator()))
                              ],
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });


  }
}
