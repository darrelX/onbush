import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:onbush/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:onbush/auth/presentation/widgets/auh_switcher_widget.dart';
import 'package:onbush/auth/presentation/widgets/register_widget.dart';
import 'package:onbush/shared/device_info/device_info.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_snackbar.dart';

import '../../../service_locator.dart';
import '../../../shared/application/cubit/application_cubit.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneLoginController = TextEditingController();
  final TextEditingController _phoneSignUpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _academicLevelController =
      TextEditingController();
  final TextEditingController _majorStudyController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final AuthCubit _cubit = AuthCubit();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  final DeviceInfo _deviceInfo = DeviceInfo.init();
  final Map<String, dynamic> info = {};
  int _currentIndex = 0;
  PhoneNumber? _phoneNumber = PhoneNumber(isoCode: 'CM');

  void deviceInfo() {
    _deviceInfo.fetchDeviceInfo(info);
  }

  @override
  void initState() {
    super.initState();
    deviceInfo();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _phoneLoginController.dispose();
    _academicLevelController.dispose();
    _genderController.dispose();
    _schoolController.dispose();
    _majorStudyController.dispose();
    _birthdayController.dispose();
    _phoneSignUpController.dispose();
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
          return SingleChildScrollView(
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
                    height: 545.h,
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
                                    .copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Gap(100.h),
                              InternationalPhoneNumberInput(
                                  onInputChanged: (PhoneNumber value) {
                                    setState(() {
                                      _phoneNumber = value;
                                    });
                                  },
                                  initialValue: _phoneNumber,
                                  selectorConfig: const SelectorConfig(
                                    selectorType:
                                        PhoneInputSelectorType.BOTTOM_SHEET,
                                    useBottomSheetSafeArea: true,
                                    setSelectorButtonAsPrefixIcon: true,
                                    leadingPadding: 10,
                                  ),
                                  ignoreBlank: false,
                                  inputDecoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      // enabledBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade500),
                                      hintText: "Numero de telephone"),
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  // selectorTextStyle: TextStyle(color: Colors.grey.shade500),
                                  // textStyle: TextStyle(color: Colors.grey.shade500),

                                  textFieldController: _phoneLoginController,
                                  // formatInput: true,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                  inputBorder: InputBorder.none),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.w,
                          ),
                          child: RegisterWidget(
                            emailController: _emailController,
                            userNameController: _userNameController,
                            phoneController: _phoneSignUpController,
                            birthdayController: _birthdayController,
                            genderController: _genderController,
                            schoolController: _schoolController,
                            studentIdController: _studentIdController,
                            academicLevelController: _academicLevelController,
                            majorStudyController: _majorStudyController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Gap(3.h),
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
                                // _cubit.login(
                                //   phone: _phoneLoginController.text,
                                //   password: _passwordController.text,
                                // );
                                if (!mounted) return;
                                context.router
                                    .pushAll([const ApplicationRoute()]);
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
                                final Map<String, dynamic> a = {
                                  "appareil": info['fingerprint'],
                                  "matricule": _studentIdController.text
                                      .split('')
                                      .join(),
                                  "nom":
                                      _userNameController.text.split('').join(),
                                  "sexe":
                                      _genderController.text.split('').join(),
                                  "naissance":
                                      _birthdayController.text.split('').join(),
                                  "email":
                                      _emailController.text.split('').join(),
                                  "telephone": _phoneSignUpController.text
                                      .split('')
                                      .join(),
                                  "niveau": _academicLevelController.text
                                      .split('')
                                      .join(),
                                  "filiere_id": _majorStudyController.text
                                      .split('')
                                      .join(),
                                  "etablissement_id":
                                      _schoolController.text.split('').join(),
                                  "code_parrain": 0,
                                  "role": "etudiant"
                                };
                                print(a);
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
                  ),
                  Gap(5.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
