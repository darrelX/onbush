import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:onbush/presentation/views/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/bottom_sheet/app_bottom_sheet.dart';
import 'package:onbush/core/shared/widget/app_input.dart';
import 'package:onbush/core/shared/widget/app_snackbar.dart';

class RegisterWidget extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController birthdayController;
  final TextEditingController genderController;
  final TextEditingController schoolController;
  final TextEditingController academicLevelController;
  final TextEditingController majorStudyController;
  final TextEditingController emailController;
  final TextEditingController userNameController;
  final Map<String, int> listId;
  final TextEditingController studentIdController;

  const RegisterWidget(
      {super.key,
      required this.birthdayController,
      required this.phoneController,
      required this.genderController,
      required this.schoolController,
      required this.academicLevelController,
      required this.majorStudyController,
      required this.studentIdController,
      required this.emailController,
      required this.userNameController,
      required this.listId});

  @override
  State<RegisterWidget> createState() => RegisterWidgetState();
}

class RegisterWidgetState extends State<RegisterWidget> {
  DateTime? _selectedDate;
  int gender = 1;
  PhoneNumber? _number = PhoneNumber(isoCode: "CM");

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900), // Date de début pour limiter la sélection
      lastDate:
          DateTime.now(), // Limite à aujourd'hui pour éviter les dates futures
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.birthdayController.text =
            DateFormat('dd/MM/yyyy').format(pickedDate); // Formatage de la date
      });
    }
  }

  Future<int> _bottomSheetSelect(
    BuildContext context, {
    String? title,
    required Map<int, String> allItems,
    required TextEditingController controller,
  }) async {
    return await AppBottomSheet.showSearchBottomSheet(
        allItems: allItems,
        context: context,
        title: title,
        resultController: controller);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      // bloc: _cubit,
      listener: (context, state) async {
        if (state is SearchStateSuccess) {
          if (authCubit.currentRequest == "colleges") {
            widget.listId['college'] = await _bottomSheetSelect(
              context,
              title: "Sélectionner l'école",
              allItems: state.listCollegeModel.asMap().map(
                    (key, value) => MapEntry(value.id!, value.name!),
                  ),
              controller: widget.schoolController,
            );
          } else if (authCubit.currentRequest == "specialities") {
            widget.listId['specialitie'] = await _bottomSheetSelect(
              context,
              title: "Sélectionner la specialite",
              allItems: state.listSpeciality.asMap().map(
                    (key, value) => MapEntry(value.id!, value.name!),
                  ),
              controller: widget.majorStudyController,
            );
          }
        }
        if (state is SearchStateFailure) {
          if (!context.mounted) return;
          AppSnackBar.showError(
              message: "Probleme de connexion", context: context);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Crée ton compte en un instant et commence à apprendre dès maintenant.",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Gap(15.h),
              AppInput(
                controller: widget.userNameController,
                hint: 'Noms et prenoms',
                labelColors: AppColors.black.withOpacity(0.7),
                keyboardType: TextInputType.name,
                validators: [
                  FormBuilderValidators.required(
                    errorText: 'Entrer votre noms et prenoms',
                  ),
                  // FormBuilderValidators.()
                ],
              ),
              Gap(15.h),
              AppInput(
                controller: widget.emailController,
                // label: 'Tel',
                hint: 'Adresse email',
                labelColors: AppColors.black.withOpacity(0.7),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validators: [
                  FormBuilderValidators.required(
                    errorText: 'Entrer votre adresse email',
                  ),
                  FormBuilderValidators.email(errorText: "E-mail est requis")
                  // FormBuilderValidators.()
                ],
              ),
              Gap(15.h),
              InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber value) {
                    _number = value;
                    // });
                  },
                  initialValue: _number,
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    useBottomSheetSafeArea: true,
                    setSelectorButtonAsPrefixIcon: true,
                    leadingPadding: 10,
                  ),
                  ignoreBlank: false,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  inputDecoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade500,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.r)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade500,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.r)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade500,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.r)),
                      // enabledBorder: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      hintText: "Numero de telephone"),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  // selectorTextStyle: TextStyle(color: Colors.grey.shade500),
                  // textStyle: TextStyle(color: Colors.grey.shade500),

                  textFieldController: widget.phoneController,
                  // formatInput: true,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: InputBorder.none),
              Gap(15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppInput(
                      width: 150.w,
                      controller: widget.birthdayController,
                      hint: "DD/MM/AA",
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      validators: [
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez sélectionner votre date de naissance';
                          }
                          return null;
                        },
                      ]),
                  AppInput(
                    controller: widget.genderController,
                    hint: 'Sexe',
                    width: 150.w,
                    keyboardType: TextInputType.none,
                    readOnly: true,
                    onTap: () {
                      AppBottomSheet.showBottomSheet(
                          context: context,
                          builder: Column(
                            children: [
                              ListTile(
                                title: const Text("masculin"),
                                selected: gender == 1,
                                onTap: () {
                                  setState(() {
                                    gender = 1;
                                    widget.genderController.text = "masculin";
                                    context.router.maybePop();
                                  });
                                },
                              ),
                              ListTile(
                                title: const Text("feminin"),
                                selected: gender == 0,
                                onTap: () {
                                  setState(() {
                                    gender = 0;
                                    widget.genderController.text = "feminin";
                                    context.router.maybePop();
                                  });
                                },
                              ),
                            ],
                          ));
                    },
                    validators: [
                      FormBuilderValidators.required(
                        errorText: 'Gender is required',
                      ),
                    ],
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                ],
              ),
              Gap(15.h),
              AppInput(
                controller: widget.schoolController,
                hint: 'Choisir votre ecole/universite',
                labelColors: AppColors.black.withOpacity(0.7),
                readOnly: true,
                onTap: () async {
                  await context.read<AuthCubit>().allColleges();
                  if (!context.mounted) return;
                },
                validators: [
                  FormBuilderValidators.required(
                    errorText: "Entrer l'ecole",
                  ),
                  // FormBuilderValidators.()
                ],
              ),
              Gap(15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppInput(
                    controller: widget.academicLevelController,
                    width: 150.w,
                    hint: 'Choisir votre niveau',
                    labelColors: AppColors.black.withOpacity(0.7),
                    readOnly: true,
                    onTap: () async {
                      widget.listId['level'] = await _bottomSheetSelect(context,
                          allItems: {1: "1", 2: "2", 3: "3", 4: "4", 5: "5"},
                          controller: widget.academicLevelController,
                          title: "Selectionner le niveau");
                    },
                    validators: [
                      FormBuilderValidators.required(
                        errorText: "Entrer votre niveau",
                      ),
                    ],
                  ),
                  AppInput(
                    width: 150.w,
                    controller: widget.studentIdController,
                    hint: 'Matricule',
                    labelColors: AppColors.black.withOpacity(0.7),
                    keyboardType: TextInputType.name,
                    validators: [
                      FormBuilderValidators.required(
                        errorText: 'Entrer votre matricule',
                      ),
                      // FormBuilderValidators.()
                    ],
                  ),
                ],
              ),
              Gap(15.h),
              AppInput(
                controller: widget.majorStudyController,
                hint: 'Choisir votre specialite',
                labelColors: AppColors.black.withOpacity(0.7),
                readOnly: true,
                onTap: () async {
                  await context
                      .read<AuthCubit>()
                      .allSpecialities(schoolId: widget.listId['college']!);
                },
                validators: [
                  FormBuilderValidators.required(
                    errorText: "Entrer votre specialite",
                  ),
                  // FormBuilderValidators.()
                ],
              ),
              Gap(15.h),
            ],
          ),
        );
      },
    );
  }
}
