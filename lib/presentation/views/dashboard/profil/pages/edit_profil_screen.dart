import 'package:another_flushbar/flushbar.dart';
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
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/shared/widget/app_input.dart';
import 'package:onbush/core/shared/widget/app_snackbar.dart';
import 'package:onbush/core/shared/widget/bottom_sheet/app_bottom_sheet.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/presentation/blocs/auth/auth/auth_cubit.dart';
import 'package:onbush/presentation/views/dashboard/profil/pages/edit_avatar_screen.dart';
import 'package:onbush/presentation/views/dashboard/profil/widgets/editable_avatar_widget.dart';
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
  final TextEditingController academyLevelController = TextEditingController();
  final TextEditingController majorStudyController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final Map<String, int> listId = {};
  final TextEditingController studentIdController = TextEditingController();
  DateTime? _selectedDate;
  int gender = 1;
  PhoneNumber? _number = PhoneNumber(isoCode: "CM");
  late final AuthCubit _authCubit;
  final GlobalKey<EditAvatarScreenState> _avatarGlobalKey =
      GlobalKey<EditAvatarScreenState>();
  // listId['college'] = getIt.get<ApplicationCubit>().userEntity!.schoolId!;

  // final GlobalKey<StatelessWidget> f;

  Future<void> _initialValues() async {
    _authCubit = getIt<AuthCubit>();
    listId['college'] = getIt.get<ApplicationCubit>().userEntity!.schoolId!;
    //
    emailController.text = getIt.get<ApplicationCubit>().userEntity!.email!;
    userNameController.text = getIt.get<ApplicationCubit>().userEntity!.name!;
    phoneController.text =
        getIt.get<ApplicationCubit>().userEntity!.phoneNumber!;
    birthdayController.text =
        getIt.get<ApplicationCubit>().userEntity!.birthday!;
    genderController.text = getIt.get<ApplicationCubit>().userEntity!.gender!;
    schoolController.text =
        getIt.get<ApplicationCubit>().userEntity!.schoolName!;
    majorStudyController.text =
        getIt.get<ApplicationCubit>().userEntity!.majorSchoolName!;
    academyLevelController.text =
        getIt.get<ApplicationCubit>().userEntity!.academyLevel.toString();
    studentIdController.text =
        getIt.get<ApplicationCubit>().userEntity!.studentId.toString();
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

    _initialValues();
  }

  @override
  void dispose() {
    phoneController.dispose();
    birthdayController.dispose();
    genderController.dispose();
    schoolController.dispose();
    majorStudyController.dispose();
    userNameController.dispose();
    academyLevelController.dispose();
    studentIdController.dispose();
    levelController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> listAavatar = [
      AppImage.avatar1,
      AppImage.avatar2,
      AppImage.avatar3,
      AppImage.avatar4,
      AppImage.avatar5,
      AppImage.avatar6,
    ];

    // _avatarGlobalKey.currentState.
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Editer Profil"),
          leading: AppButton(
            onPressed: () => context.router.push(const ProfilRoute()),
            child: const Icon(Icons.arrow_back),
          ),
          backgroundColor: AppColors.primary,
        ),
        backgroundColor: AppColors.quaternaire,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is SearchStateSuccess) {
              if (_authCubit.currentRequest == "colleges") {
                listId['college'] = await _bottomSheetSelect(
                  context,
                  title: "Sélectionner l'école",
                  allItems: state.listCollegeModel.asMap().map(
                        (key, value) => MapEntry(value.id!, value.name!),
                      ),
                  controller: schoolController,
                );
              } else if (_authCubit.currentRequest == "specialities") {
                listId['specialitie'] = await _bottomSheetSelect(
                  context,
                  title: "Sélectionner la specialite",
                  allItems: state.listSpeciality.asMap().map(
                        (key, value) => MapEntry(value.id!, value.name!),
                      ),
                  controller: majorStudyController,
                );
              }
            }
            if (state is SearchStateFailure) {
              if (!context.mounted) return;
              AppSnackBar.showError(
                  message: "Probleme de connexion", context: context);
            }

            if (state is EditSuccess) {
              if (!context.mounted) return;

              AppSnackBar.showConfig(
                  context: context,
                  backgroundColor: AppColors.white,
                  leading: SvgPicture.asset(
                    "assets/icons/onbush_original.svg",
                    // color: AppColors.primary,
                  ),
                  child: const Text(
                    "Sauvegarder avec succes",
                    style: TextStyle(color: AppColors.primary),
                  ),
                  flushbarPosition: FlushbarPosition.BOTTOM);
            }
            if (state is EditFailure) {
              if (!context.mounted) return;

              AppSnackBar.showConfig(
                  context: context,
                  child: const Text("Erreur de sauvegarde"),
                  backgroundColor: AppColors.red);
            }
          },
          bloc: _authCubit,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
                      EditableAvatarWidget(
                        onPressed: () => context.router.pushAll([
                          EditAvatarRoute(
                              key: _avatarGlobalKey, avatarList: listAavatar)
                        ]),
                        image: Image.asset(
                          getIt.get<LocalStorage>().getString("avatar")!,
                          fit: BoxFit.fill,
                          width: 150.r,
                          height: 150.r,
                        ),
                        subIcon: Container(
                            height: 42.r,
                            width: 42.r,
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10.r),
                              child: SvgPicture.asset(
                                "assets/icons/pencil.svg",
                                color: AppColors.white,
                              ),
                            )),
                      ),
                      // Gap(10.h),
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
                            controller: academyLevelController,
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
                                  controller: academyLevelController,
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
                        loading: state is EditLoading,
                        loadingColor: AppColors.white,
                        textColor: AppColors.white,
                        width: context.width,
                        bgColor: AppColors.secondary,
                        onPressed: () {
                          _authCubit.editProfil(
                              device: getIt
                                  .get<LocalStorage>()
                                  .getString('device')!,
                              studentId: studentIdController.text,
                              name: userNameController.text,
                              level: academyLevelController.text,
                              gender: genderController.text,
                              email: emailController.text,
                              birthday: birthdayController.text,
                              role: 'etudiant',
                              phone: phoneController.text,
                              avatar: "",
                              language: "fr");
                        },
                      )
                    ],
                  )),
            );
          },
        ));
  }
}
