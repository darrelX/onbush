import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/database/key_storage.dart';
import 'package:onbush/presentation/blocs/auth/auth/auth_cubit.dart';
import 'package:onbush/presentation/views/auth/widgets/auh_switcher_widget.dart';
import 'package:onbush/presentation/views/auth/widgets/register_widget.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/shared/widget/app_input.dart';
import 'package:onbush/core/shared/widget/app_snackbar.dart';

import '../../../../service_locator.dart';
import '../../../../core/application/cubit/application_cubit.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailSignUpController = TextEditingController();
  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _academyLevelController = TextEditingController();
  final TextEditingController _majorStudyController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  final GlobalKey<RegisterWidgetState> _registerWidgetState =
      GlobalKey<RegisterWidgetState>();
  int _currentIndex = 0;
  final Map<String, int> _listId = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailSignUpController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _academyLevelController.dispose();
    _genderController.dispose();
    _schoolController.dispose();
    _majorStudyController.dispose();
    _emailLoginController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthCubit, AuthState>(
        // bloc: _cubit,
        listener: (context, state) {
          if (state is LoginFailure) {
            if (state.message == "compte bloqué") {
              context.router.push(PriceRoute(
                  email: _emailLoginController.text.replaceAll(' ', '')));
            }
            AppSnackBar.showError(
              message: state.message,
              context: context,
            );
          }

          if (state is RegisterFailure) {
            AppSnackBar.showError(
              message: state.message,
              context: context,
            );
          }

          if (state is OTpStateSuccess) {
            context.router
                .popAndPush(OTPInputRoute(type: 'login', email: state.email));
          }

          if (state is LoginSuccess) {
            //
            context.read<ApplicationCubit>().setUser(state.user);
            context.router.push(
              const ApplicationRoute(),
              // predicate: (route) => false,
            );
          }
          if (state is RegisterSuccess) {
            context.router.push(
              OTPInputRoute(
                  type: 'register',
                  email: _emailSignUpController.text.replaceAll(' ', '')),
              // predicate: (route) => false
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SafeArea(
              child: IgnorePointer(
                ignoring: state is SearchStateLoading,
                child: Stack(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Gap(30.h),
                          SvgPicture.asset(
                            AppImage.onBush,
                            width: 80.w,
                            // height: 300,
                          ),
                          Gap(25.h),
                          AuhSwitcherWidget(
                            pageController: _pageController,
                            currentIndex: _currentIndex,
                          ),
                          Gap(25.h),
                          SizedBox(
                            height: 0.63.sh,
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (int page) => setState(() {
                                _currentIndex = page;
                              }),
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 25.w,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Accède rapidement à tes cours et à tes révisions en quelques clics.",
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      Gap(100.h),
                                      AppInput(
                                        controller: _emailLoginController,
                                        // label: 'Tel',
                                        hint: 'Adresse email',
                                        labelColors:
                                            AppColors.black.withOpacity(0.7),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        autofillHints: const [
                                          AutofillHints.email
                                        ],
                                        validators: [
                                          FormBuilderValidators.required(
                                            errorText:
                                                'Entrer votre adresse email',
                                          ),
                                          FormBuilderValidators.email(
                                              errorText: "E-mail est requis")
                                          // FormBuilderValidators.()
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 25.w,
                                  ),
                                  child: RegisterWidget(
                                    key: _registerWidgetState,
                                    listId: _listId,
                                    emailController: _emailSignUpController,
                                    userNameController: _userNameController,
                                    phoneController: _phoneController,
                                    birthdayController: _birthdayController,
                                    genderController: _genderController,
                                    schoolController: _schoolController,
                                    studentIdController: _studentIdController,
                                    academyLevelController:
                                        _academyLevelController,
                                    majorStudyController: _majorStudyController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25.w,
                            ),
                            child: _currentIndex == 0
                                ? AppButton(
                                    loading: state is LoginLoading,
                                    width: context.width,
                                    bgColor: AppColors.primary,
                                    text: "Connectez-vous",
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().login(
                                              appareil: getIt
                                                  .get<LocalStorage>()
                                                  .getString('device')!,
                                              email: _emailLoginController.text
                                                  .replaceAll(' ', ''),
                                            );
                                      }
                                    },
                                  )
                                : AppButton(
                                    loading: state is LoginLoading ||
                                        state is RegisterLoading,
                                    width: context.width - 25.w,
                                    bgColor: AppColors.primary,
                                    text: "incrivez-vous",
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // sauvegarder les données
                                        context
                                            .read<ApplicationCubit>()
                                            .setUserGender(_genderController
                                                .text
                                                .replaceAll(' ', ''));

                                        context.read<AuthCubit>().register(
                                              name: _userNameController.text
                                                  .trim(),
                                              email: _emailSignUpController.text
                                                  .trim(),
                                              birthDate: _birthdayController
                                                  .text
                                                  .replaceAll(' ', ''),
                                              gender: _genderController.text
                                                  .replaceAll(' ', ''),
                                              phone: _phoneController.text
                                                  .replaceAll(' ', ''),
                                              device: getIt
                                                  .get<LocalStorage>()
                                                  .getString(
                                                      StorageKeys.deviceId)!,
                                              role: 'etudiant',
                                              academyLevel: _listId["level"]!,
                                              majorStudy:
                                                  _listId["specialitie"]!,
                                              schoolId: _listId["college"]!,
                                              studentId: _studentIdController
                                                  .text
                                                  .trim(),
                                            );
                                      }
                                    },
                                  ),
                          ),
                          Gap(20.h),
                        ],
                      ),
                    ),
                    if (state is SearchStateLoading)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black
                              .withOpacity(0.5), // Assombrir l'écran
                          child: const Center(
                            child:
                                CircularProgressIndicator(), // Indicateur de chargement
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
