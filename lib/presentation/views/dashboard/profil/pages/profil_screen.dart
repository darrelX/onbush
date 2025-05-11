import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/presentation/blocs/auth/auth/auth_cubit.dart';
import 'package:onbush/presentation/views/dashboard/profil/widgets/user_profil_widget.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../core/routing/app_router.dart';

@RoutePage()
class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  late final AuthCubit _authCubit;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    _initWebViewController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _initWebViewController() {
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
          onProgress: (int progress) {},
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
      ..loadRequest(Uri.parse('https://onbush237.com'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          print("object");
          context.router.push(const AuthRoute());
        }
      },
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
                              .userEntity!
                              .majorSchoolName!,
                          onPressed: () {
                            context.router.push(const EditProfilRoute());
                          },
                          name: getIt.get<ApplicationCubit>().userEntity!.name!,
                          level: getIt
                              .get<ApplicationCubit>()
                              .userEntity!
                              .academyLevel!,
                          sigle:
                              getIt.get<ApplicationCubit>().userEntity!.sigle!,
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
                        leading: SvgPicture.asset(AppImage.languageIcon),
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
                          _shareWithSubject(
                              r"Salut Onbush 👋, je voudrais faire une suggestion 💡 !");
                        },
                        leading: SvgPicture.asset(AppImage.messageIcon),
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
                          _shareWithSubject(
                              r"Salut Onbush 👋, je voudrais signaler un bug 🐞 !");
                        },
                        leading: SvgPicture.asset(AppImage.bugIcon),
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
                    Gap(10.h),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ListTile(
                        onTap: () {
                          context.router.push(const ReminderRoute());
                        },
                        leading: SvgPicture.asset(AppImage.clock),
                        title: Text(
                          'Rappels et alertes',
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
                    Gap(40.h),
                    AppButton(
                      width: double.infinity,
                      loading: state is LogoutPending,
                      text: "Deconnexion",
                      onPressed: () {
                        // getIt.get<LocalStorage>().remove('device');
                        _authCubit.logout();
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

  Future<void> _shareWithSubject(String textToShare) async {
    try {
      await Share.share(
        textToShare,
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 100, 100),
      );
      print('Partage réussi');
    } catch (e) {
      print('Erreur lors du partage : $e');
    }
  }
}
