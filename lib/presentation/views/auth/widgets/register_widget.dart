import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:onbush/presentation/blocs/auth/auth/auth_cubit.dart';
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
  final TextEditingController academyLevelController;
  final TextEditingController majorStudyController;
  final TextEditingController emailController;
  final TextEditingController userNameController;
  final Map<String, int> listId;
  final TextEditingController studentIdController;

  const RegisterWidget({
    super.key,
    required this.birthdayController,
    required this.phoneController,
    required this.genderController,
    required this.schoolController,
    required this.academyLevelController,
    required this.majorStudyController,
    required this.studentIdController,
    required this.emailController,
    required this.userNameController,
    required this.listId,
  });

  @override
  State<RegisterWidget> createState() => RegisterWidgetState();
}

class RegisterWidgetState extends State<RegisterWidget> {
  DateTime? _selectedDate;
  int gender = 1;
  PhoneNumber? _number = PhoneNumber(isoCode: "CM");
  late final AuthCubit _authCubit;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.birthdayController.text =
            DateFormat('dd/MM/yyyy').format(pickedDate);
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
      resultController: controller,
    );
  }

  Map<int, String> generateLevels(int level) {
    return {for (var i = 1; i <= level; i++) i: i.toString()};
  }

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is SearchStateSuccess) {
          if (_authCubit.currentRequest == "colleges") {
            widget.listId['college'] = await _bottomSheetSelect(
              context,
              title: "Sélectionner l'école",
              allItems: state.listCollegeModel.asMap().map(
                    (key, value) => MapEntry(value.id!, value.name!),
                  ),
              controller: widget.schoolController,
            );
          } else if (_authCubit.currentRequest == "specialities") {
            widget.listId['specialitie'] = await _bottomSheetSelect(
              context,
              title: "Sélectionner la spécialité",
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
              message: "Problème de connexion", context: context);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Crée ton compte en un instant et commence à apprendre dès maintenant.",
                style: context.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Gap(15.h),
              _buildUserNameInput(),
              Gap(15.h),
              _buildEmailInput(),
              Gap(15.h),
              _buildPhoneInput(),
              Gap(15.h),
              _buildDateAndGenderInputs(),
              Gap(15.h),
              _buildSchoolInput(),
              Gap(15.h),
              _buildAcademicLevelAndIdInputs(),
              Gap(15.h),
              _buildMajorStudyInput(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserNameInput() {
    return AppInput(
      controller: widget.userNameController,
      hint: 'Noms et prénoms',
      labelColors: AppColors.black.withOpacity(0.7),
      keyboardType: TextInputType.name,
      validators: [
        FormBuilderValidators.required(errorText: 'Entrer votre nom et prénom'),
      ],
    );
  }

  Widget _buildEmailInput() {
    return AppInput(
      controller: widget.emailController,
      hint: 'Adresse email',
      labelColors: AppColors.black.withOpacity(0.7),
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      validators: [
        FormBuilderValidators.required(errorText: 'Entrer votre adresse email'),
        FormBuilderValidators.email(errorText: "L'email est requis"),
      ],
    );
  }

  Widget _buildPhoneInput() {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber value) => _number = value,
      initialValue: _number,
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        useBottomSheetSafeArea: true,
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 10,
      ),
      ignoreBlank: false,
      autofillHints: const [AutofillHints.telephoneNumber],
      inputDecoration: _getPhoneInputDecoration(),
      autoValidateMode: AutovalidateMode.onUserInteraction,
      textFieldController: widget.phoneController,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputBorder: InputBorder.none,
    );
  }

  InputDecoration _getPhoneInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderSide:
            BorderSide(color: Colors.grey.shade500, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Colors.grey.shade500, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10.r),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Colors.grey.shade500, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10.r),
      ),
      hintStyle: TextStyle(color: Colors.grey.shade500),
      hintText: "Numéro de téléphone",
    );
  }

  Widget _buildDateAndGenderInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBirthdayInput(),
        _buildGenderInput(),
      ],
    );
  }

  Widget _buildBirthdayInput() {
    return AppInput(
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
      ],
    );
  }

  Widget _buildGenderInput() {
    return AppInput(
      controller: widget.genderController,
      hint: 'Sexe',
      width: 150.w,
      keyboardType: TextInputType.none,
      readOnly: true,
      onTap: () => _showGenderBottomSheet(context),
      validators: [
        FormBuilderValidators.required(errorText: 'Le sexe est requis'),
      ],
      suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
    );
  }

  void _showGenderBottomSheet(BuildContext context) {
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
            title: const Text("féminin"),
            selected: gender == 0,
            onTap: () {
              setState(() {
                gender = 0;
                widget.genderController.text = "féminin";
                context.router.maybePop();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolInput() {
    return AppInput(
      controller: widget.schoolController,
      hint: 'Choisir votre école/université',
      labelColors: AppColors.black.withOpacity(0.7),
      readOnly: true,
      onTap: () async {
        await context.read<AuthCubit>().allColleges();
        if (!context.mounted) return;
      },
      validators: [
        FormBuilderValidators.required(errorText: "Entrer l'école"),
      ],
    );
  }

  Widget _buildAcademicLevelAndIdInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAcademicLevelInput(),
        _buildStudentIdInput(),
      ],
    );
  }

  Widget _buildAcademicLevelInput() {
    return AppInput(
      controller: widget.academyLevelController,
      width: 150.w,
      hint: 'Choisir votre niveau',
      labelColors: AppColors.black.withOpacity(0.7),
      readOnly: true,
      onTap: () async {
        widget.listId['level'] = await _bottomSheetSelect(
          context,
          allItems: generateLevels(
            _authCubit
                .listAllColleges[widget.listId['college']!].totalStudyLevels!,
          ),
          controller: widget.academyLevelController,
          title: "Sélectionner le niveau",
        );
      },
      validators: [
        FormBuilderValidators.required(errorText: "Entrer votre niveau"),
      ],
    );
  }

  Widget _buildStudentIdInput() {
    return AppInput(
      width: 150.w,
      controller: widget.studentIdController,
      hint: 'Matricule',
      labelColors: AppColors.black.withOpacity(0.7),
      keyboardType: TextInputType.name,
      validators: [
        FormBuilderValidators.required(errorText: 'Entrer votre matricule'),
      ],
    );
  }

  Widget _buildMajorStudyInput() {
    return AppInput(
      controller: widget.majorStudyController,
      hint: 'Choisir votre spécialité',
      labelColors: AppColors.black.withOpacity(0.7),
      readOnly: true,
      onTap: () async {
        await context
            .read<AuthCubit>()
            .allSpecialities(schoolId: widget.listId['college']!);
      },
      validators: [
        FormBuilderValidators.required(errorText: "Entrer votre spécialité"),
      ],
    );
  }
}
