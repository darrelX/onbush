import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/shared/widget/app_input.dart';
import 'package:onbush/core/shared/widget/bottom_sheet/app_bottom_sheet.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/theme/app_colors.dart';
import 'package:onbush/presentation/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:onbush/presentation/dashboard/profil/cubit/mentee_cubit.dart';
import 'package:onbush/presentation/dashboard/profil/widgets/editable_avatar_widget.dart';
import 'package:onbush/service_locator.dart';

@RoutePage()
class EditProfilScreen extends StatefulWidget {
  const EditProfilScreen({super.key});

  @override
  State<EditProfilScreen> createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController academicLevelController = TextEditingController();
  final TextEditingController majorStudyController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final Map<String, int> listId = {};
  final TextEditingController studentIdController = TextEditingController();
  DateTime? _selectedDate;
  int gender = 1;
  PhoneNumber? _number = PhoneNumber(isoCode: "CM");
  final MenteeCubit _menteeCubit = MenteeCubit();

  Future<void> initialValues() async {
    emailController.text = getIt.get<ApplicationCubit>().userModel.email!;
    userNameController.text = getIt.get<ApplicationCubit>().userModel.name!;
    phoneController.text = getIt.get<ApplicationCubit>().userModel.phoneNumber!;
    birthdayController.text = getIt.get<ApplicationCubit>().userModel.birthday!;
    genderController.text = getIt.get<ApplicationCubit>().userModel.gender!;
    // schoolController.text = getIt.get<ApplicationCubit>().userModel.schoolId!;
    majorStudyController.text = "";
    academicLevelController.text =
        getIt.get<ApplicationCubit>().userModel.academiclevel.toString();
    studentIdController.text =
        getIt.get<ApplicationCubit>().userModel.majorSchoolId.toString();
  }

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
        birthdayController.text =
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
    initialValues();
  }

  @override
  void dispose() {
    phoneController.dispose();
    birthdayController.dispose();
    genderController.dispose();
    schoolController.dispose();
    majorStudyController.dispose();
    userNameController.dispose();
    academicLevelController.dispose();
    studentIdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Editer Profil"),
          backgroundColor: AppColors.primary,
        ),
        body: BlocConsumer<MenteeCubit, MenteeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          bloc: _menteeCubit,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
                      Gap(20.h),
                      EditableAvatarWidget(),
                      Gap(15.h),
                      AppInput(
                        controller: userNameController,
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
                        controller: emailController,
                        // label: 'Tel',
                        hint: 'Adresse email',
                        labelColors: AppColors.black.withOpacity(0.7),
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        validators: [
                          FormBuilderValidators.required(
                            errorText: 'Entrer votre adresse email',
                          ),
                          FormBuilderValidators.email(
                              errorText: "E-mail est requis")
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

                          textFieldController: phoneController,
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
                              controller: birthdayController,
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
                            controller: genderController,
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
                                            genderController.text = "masculin";
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
                                            genderController.text = "feminin";
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
                            suffixIcon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                          ),
                        ],
                      ),
                      Gap(15.h),
                      AppInput(
                        controller: schoolController,
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
                            controller: academicLevelController,
                            width: 150.w,
                            hint: 'Choisir votre niveau',
                            labelColors: AppColors.black.withOpacity(0.7),
                            readOnly: true,
                            onTap: () async {
                              listId['level'] = await _bottomSheetSelect(
                                  context,
                                  allItems: {
                                    1: "1",
                                    2: "2",
                                    3: "3",
                                    4: "4",
                                    5: "5"
                                  },
                                  controller: academicLevelController,
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
                            controller: studentIdController,
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
                        controller: majorStudyController,
                        hint: 'Choisir votre specialite',
                        labelColors: AppColors.black.withOpacity(0.7),
                        readOnly: true,
                        onTap: () async {
                          await context
                              .read<AuthCubit>()
                              .allSpecialities(schoolId: listId['college']!);
                        },
                        validators: [
                          FormBuilderValidators.required(
                            errorText: "Entrer votre specialite",
                          ),
                          // FormBuilderValidators.()
                        ],
                      ),
                      Gap(25.h),
                      AppButton(
                        text: "Sauvegarder",
                        textColor: AppColors.white,
                        width: context.width,
                        bgColor: AppColors.secondary,
                      )
                    ],
                  )),
            );
          },
        ));
  }
}
