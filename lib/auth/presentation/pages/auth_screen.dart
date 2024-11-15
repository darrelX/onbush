import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:onbush/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:onbush/auth/presentation/widgets/auh_switcher_widget.dart';
import 'package:onbush/auth/presentation/widgets/register_widget.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_input.dart';
import 'package:onbush/shared/widget/app_snackbar.dart';

import '../../../service_locator.dart';
import '../../../shared/application/cubit/application_cubit.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneLoginController = TextEditingController();
  final TextEditingController _phoneSignUpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _academicLevelController =
      TextEditingController();
  final TextEditingController _majorStudyController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final AuthCubit _cubit = AuthCubit();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  DateTime? _selectedDate;
  int _currentIndex = 0;
  // final bool _isChecked = false;
  // final _networkCubit = getIt.get<NetworkCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is LoginFailure) {
            AppSnackBar.showError(
              message: state.message,
              context: context,
            );
            ////////////////////////
            // getIt.get<ApplicationCubit>().setUser(state.user);
            // context.router.push(
            //   const ApplicationRoute(),
            //   // predicate: (route) => false,
            // );
            ////////////////////
          }

          if (state is LoginSuccess) {
            getIt.get<ApplicationCubit>().setUser(state.user);
            context.router.pushAndPopUntil(
              const ApplicationRoute(),
              predicate: (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Container(
            // height: context.height,
            padding: EdgeInsets.symmetric(
              horizontal: 25.w,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(50.h),
                    Image.asset(
                      "assets/images/onbush.png",
                      width: 200.w,
                      // height: 300,
                    ),
                    Gap(25.h),
                    AuhSwitcherWidget(
                      pageController: _pageController,
                      currentIndex: _currentIndex,
                    ),
                    Gap(25.h),
                    SizedBox(
                      height: 520.h,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (int page) => setState(() {
                          _currentIndex = page;
                        }),
                        children: [
                          Column(
                            children: [
                              Text(
                                "Accède rapidement à tes cours et à tes révisions en quelques clics.",
                                style: context.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Gap(100.h),
                              AppInput(
                                controller: _phoneLoginController,
                                // label: 'Tel',
                                hint: 'Numero de telephone',
                                labelColors: AppColors.black.withOpacity(0.7),
                                keyboardType: TextInputType.phone,
                                validators: [
                                  FormBuilderValidators.required(
                                    errorText: 'Numero de telephone requis',
                                  ),
                                  FormBuilderValidators.numeric()
                                ],
                              ),
                            ],
                          ),
                          RegisterWidget(
                            firstNameController: _firstNameController,
                            lastNameController: _lastNameController,
                            phoneController: _phoneSignUpController,
                            dateController: _dateController,
                            genderController: _genderController,
                            schoolController: _schoolController,
                            academicLevelController: _academicLevelController,
                            majorStudyController: _majorStudyController,
                          ),
                        ],
                      ),
                    ),
                    Gap(20.h),
                    _currentIndex == 0
                        ? AppButton(
                            loading: state is LoginLoading,
                            width: context.width,
                            bgColor: AppColors.primary,
                            text: "Connectez-vous",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _cubit.login(
                                  phone: _phoneLoginController.text,
                                  password: _passwordController.text,
                                );
                              }
                            },
                          )
                        : AppButton(
                            loading: state is LoginLoading,
                            width: context.width - 25.w,
                            bgColor: AppColors.primary,
                            text: "incrivez-vous",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.router.pushAll([
                                  OTPInputRoute(
                                      number: _phoneSignUpController.text)
                                ]);
                                // _cubit.register(
                                //   phone: _phoneLoginController.text,
                                //   password: _passwordController.text,
                                // );
                              }
                            },
                          ),
                    Gap(5.h),
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
