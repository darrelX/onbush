import 'package:onbush/presentation/views/dashboard/course/enums/category.dart';

extension CategoryEnumExtension on CategoryEnum {
  String get label => switch (this) {
        CategoryEnum.cours => "Cours",
        CategoryEnum.td => "Travaux Dirigés",
        CategoryEnum.assessments => "Epreuves",
        CategoryEnum.solutions => "Solutions",
        CategoryEnum.cc => "Contrôle Continu",
        CategoryEnum.other => "Autre",
      };

  String get apiLabel => switch (this) {
        CategoryEnum.cours => "cours",
        CategoryEnum.td => "travauxdiriges",
        CategoryEnum.assessments => "epreuves",
        CategoryEnum.solutions => "solutions",
        CategoryEnum.cc => "controlcontinus",
        CategoryEnum.other => "autre",
      };
}
