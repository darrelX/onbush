import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/presentation/auth/data/models/specialty_model.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/application/cubit/data_state.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/theme/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/routing/app_router.dart';

@RoutePage()
class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  late final ApplicationCubit _cubit;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ApplicationCubit>()..addSpecialty();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse('https://onbush237.com'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplicationCubit, ApplicationState>(
      // bloc: getIt.get<ApplicationCubit>(),
      listener: (context, state) {
        // if (state is LogoutFailure) {
        //   print("Probleme");
        // }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.quaternaire,
          body: Container(
              width: context.width,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(10.h),
                  SizedBox(
                    height: 109.h,
                    // decoration: BoxDecoration(color: Colors.red),
                    child: Builder(builder: (context) {
                      if (state.speciality.status == Status.loading) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Row(
                            children: [
                              Container(
                                width: 105.w,
                                height: 109.h,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 239.w,
                                height: 109.h,

                                color: Colors.white,

                                // height: 109.h,
                                padding: const EdgeInsets.all(16.0),
                              ),
                            ],
                          ),
                        );
                      } else if (state.speciality.status == Status.failure) {
                        return Opacity(
                          opacity: 0.3,
                          child: Center(
                              child: AppButton(
                            child: Icon(
                              Icons.refresh,
                              size: 45.r,
                            ),
                            borderColor: AppColors.black,
                            onPressed: () async {
                              await context
                                  .read<ApplicationCubit>()
                                  .addSpecialty();
                            },
                          )),
                        );
                      } else if (state.speciality.status == Status.success) {
                        return Row(
                          children: [
                            Image.asset(
                              "assets/images/account_image.png",
                              height: 105.h,
                              fit: BoxFit.fitHeight,
                            ),
                            Gap(8.w),
                            SizedBox(
                              height: 109.h,
                              width: 239.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_cubit.userModel.name!,
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.r,
                                              shadows: [
                                            const Shadow(
                                              offset: Offset(0.5, 0.5),
                                              blurRadius: 3.0,
                                              color: Color(0xFF969DAC),
                                            ),
                                          ]),
                                      overflow: TextOverflow.ellipsis),
                                  const Spacer(),
                                  Text(
                                    "Niveau: ${_cubit.userModel.academiclevel}",
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 14.r,
                                      color: const Color(0xFF969DAC),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200.w,
                                    child: Text(
                                      "Filiere: ${state.speciality.data!.name}",
                                      style:
                                          context.textTheme.bodyLarge!.copyWith(
                                        fontSize: 14.r,
                                        height: 1.3.h,
                                        color: const Color(0xFF969DAC),
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Text(
                                    "ENSPD",
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                            fontSize: 14.r,
                                            color: const Color(0xFF969DAC),
                                            shadows: [
                                              const Shadow(
                                                offset: Offset(0.5, 0.5),
                                                blurRadius: 2.0,
                                                color: Color(0xFF969DAC),
                                              ),
                                            ],
                                            fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        );
                      }
                      return Opacity(
                        opacity: 0.3,
                        child: Center(
                            child: AppButton(
                          text: "Text",
                          onPressed: () async {
                            await context
                                .read<ApplicationCubit>()
                                .addSpecialty();
                          },
                        )),
                      );
                    }),
                  ),
                  Gap(10.h),
                  AppButton(
                    width: double.infinity,
                    text: "Modifier mon profil",
                    textColor: AppColors.secondary,
                    height: 45.h,
                    // width: 200.w,
                    bgColor: AppColors.ternary,
                  ),
                  Gap(30.h),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ListTile(
                      onTap: () {
                        context.router.push(const AmbassadorSpaceRoute());
                      },
                      leading: const Icon(Icons.star),
                      title: Text(
                        'Espace Parrain',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xffA7A7AB),
                      ),
                    ),
                  ),
                  Gap(10.h),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ListTile(
                      onTap: () {
                        context.router.push(const LanguageRoute());
                      },
                      leading: const Icon(Icons.language_outlined),
                      title: Text(
                        'Langue',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xffA7A7AB),
                      ),
                    ),
                  ),
                  Gap(10.h),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ListTile(
                      onTap: () {
                        // context.router.push(const TopUpRoute());
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                WebViewWidget(controller: _controller)));
                      },
                      leading: const Icon(Icons.warning),
                      title: Text(
                        'A propos',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xffA7A7AB),
                      ),
                    ),
                  ),
                  Gap(10.h),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ListTile(
                      onTap: () {
                        // context.router.push(const TopUpRoute());
                      },
                      leading: const Icon(Icons.message),
                      title: Text(
                        'Nous contacter',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xffA7A7AB),
                      ),
                    ),
                  ),
                  Gap(20.h),
                  AppButton(
                    width: double.infinity,
                    loading: state.loading!.status == Status.loading,
                    text: "Deconnexion",
                    onPressed: () async {
                      // getIt.get<LocalStorage>().remove('device');
                      await getIt.get<ApplicationCubit>().logout();

                      context.router.popAndPush(const AuthRoute());
                    },
                    textColor: Colors.redAccent,
                    borderColor: Colors.redAccent,
                  )
                ],
              )),
        );
      },
    );
  }
}
