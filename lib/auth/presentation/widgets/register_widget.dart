import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_bottom_sheet.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_input.dart';

class RegisterWidget extends StatefulWidget {
  final TextEditingController lastNameController;
  final TextEditingController firstNameController;
  final TextEditingController phoneController;
  final TextEditingController dateController;
  final TextEditingController genderController;
  final TextEditingController schoolController;
  final TextEditingController academicLevelController;
  final TextEditingController majorStudyController;

  const RegisterWidget(
      {super.key,
      required this.dateController,
      required this.lastNameController,
      required this.firstNameController,
      required this.phoneController,
      required this.genderController,
      required this.schoolController,
      required this.academicLevelController,
      required this.majorStudyController});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  DateTime? _selectedDate;
  int gender = 1;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allItems = [
    'Pomme',
    'Banane',
    'Orange',
    'Mangue',
    'Ananas',
    'Raisin',
    'Papaye',
    'Citron',
  ];

  List<String> _filteredItems = [];

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
        widget.dateController.text =
            DateFormat('dd/MM/yyyy').format(pickedDate); // Formatage de la date
      });
    }
  }

  Future<void> _selectSchool(BuildContext context) async {
    AppBottomSheet.showModelBottomSheet(
        context: context,
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          void filterItems() {
            final query = _searchController.text.toLowerCase();
            setModalState(() {
              _filteredItems = _allItems
                  .where((item) => item.toLowerCase().contains(query))
                  .toList();
            });
          }

          _searchController.addListener(filterItems);
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppButton(
                    onPressed: () => context.router.popForced(),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  Text(
                    "Choississez votre\necole/universite",
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer()
                ],
              ),
              Gap(20.h),
              AppInput(
                controller: _searchController,
                prefix: const Icon(Icons.search),
                hint: "Chercher ...",
                validators: [],
              ),
              Gap(20.h),
              Expanded(
                child: ListView.separated(
                  itemCount: _filteredItems.length,
                  separatorBuilder: (context, i) => Gap(20.h),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: Checkbox(
                                value: true,
                                side: BorderSide.none,
                                shape: const CircleBorder(),
                                onChanged: (value) {})),
                        Container(
                            constraints: BoxConstraints(maxWidth: 280.w),
                            child: Text(
                              _filteredItems[index],
                              style: context.textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ))
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    // widget.firstNameController.dispose();
    // widget.lastNameController.dispose();
    // widget.phoneController.dispose();
    // widget.dateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Gap(30.h),
          Text(
            "Crée ton compte en un instant et commence à apprendre dès maintenant.",
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Gap(20.h),
          AppInput(
            controller: widget.lastNameController,
            border: false,
            hint: 'Nom(s)',
            labelColors: AppColors.black.withOpacity(0.7),
            keyboardType: TextInputType.phone,
            validators: [
              FormBuilderValidators.required(
                errorText: 'Entrer votre nom',
              ),
              // FormBuilderValidators.()
            ],
          ),
          Gap(20.h),
          AppInput(
            controller: widget.firstNameController,
            // label: 'Tel',
            border: false,
            hint: 'Prenom(s)',
            labelColors: AppColors.black.withOpacity(0.7),
            keyboardType: TextInputType.phone,
            validators: [
              FormBuilderValidators.required(
                errorText: 'Entrer votre nom',
              ),
              // FormBuilderValidators.()
            ],
          ),
          Gap(20.h),
          AppInput(
            controller: widget.phoneController,
            // label: 'Tel',
            border: false,
            hint: 'Numero de telephone (Whatsapp)',
            labelColors: AppColors.black.withOpacity(0.7),
            keyboardType: TextInputType.phone,
            validators: [
              FormBuilderValidators.required(
                errorText: 'Entrer votre nom',
              ),
              // FormBuilderValidators.()
            ],
          ),
          Gap(20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppInput(
                  width: 150.w,
                  controller: widget.dateController,
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
                hint: 'Gender',
                width: 150.w,
                keyboardType: TextInputType.none,
                readOnly: true,
                onTap: () {
                  AppBottomSheet.showModelBottomSheet(
                    context: context,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text("Male"),
                          selected: gender == 1,
                          onTap: () {
                            setState(() {
                              gender = 1;
                              widget.genderController.text = "Male";
                              context.router.maybePop();
                            });
                          },
                        ),
                        ListTile(
                          title: const Text("Female"),
                          selected: gender == 0,
                          onTap: () {
                            setState(() {
                              gender = 0;
                              widget.genderController.text = "Female";
                              context.router.maybePop();
                            });
                          },
                        ),
                      ],
                    ),
                  );
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
          Gap(20.h),
          AppInput(
            controller: widget.schoolController,
            hint: 'Choisir votre ecole/universite',
            labelColors: AppColors.black.withOpacity(0.7),
            readOnly: true,
            onTap: () => _selectSchool(context),
            // keyboardType: TextInputType.phone,

            validators: [
              FormBuilderValidators.required(
                errorText: "Entrer l'ecole",
              ),
              // FormBuilderValidators.()
            ],
          ),
        ],
      ),
    );
  }
}
