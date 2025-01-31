import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/presentation/dashboard/profil/widgets/user_profil_widget.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/application/cubit/data_state.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/theme/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
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
    _cubit = context.read<ApplicationCubit>();
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
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.quaternaire,
          body: SingleChildScrollView(
            child: Container(
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
                        return UserProfileWidget(
                          filiere: getIt
                              .get<ApplicationCubit>()
                              .userModel
                              .majorSchoolName!,
                          name: getIt.get<ApplicationCubit>().userModel.name!,
                          level: getIt
                              .get<ApplicationCubit>()
                              .userModel
                              .academiclevel!,
                          sigle: getIt.get<ApplicationCubit>().userModel.sigle!,
                        );
                      }),
                    ),
                    Gap(10.h),
                    AppButton(
                      width: double.infinity,
                      text: "Modifier mon profil",
                      textColor: AppColors.secondary,
                      onPressed: () {
                        context.router.push(const EditProfilRoute());
                      },
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
                          context.router.push(const LanguageRoute());
                        },
                        leading: SvgPicture.asset("assets/icons/language.svg"),
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
                        leading: SvgPicture.asset("assets/icons/message.svg"),
                        title: Text(
                          'Faire une sugestion',
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
                          'Signalez un bug',
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
                    Gap(50.h),
                    AppButton(
                      width: double.infinity,
                      loading: state.loading!.status == Status.loading,
                      text: "Deconnexion",
                      onPressed: () async {
                        // getIt.get<LocalStorage>().remove('device');
                        await context.read<ApplicationCubit>().logout();

                        context.router.popAndPush(const AuthRoute());
                      },
                      textColor: Colors.redAccent,
                      borderColor: Colors.redAccent,
                    ),
                    Gap(20.h),
                  ],
                )),
          ),
        );
      },
    );
  }
}
