import 'package:onbush/presentation/views/dashboard/course/enums/category.dart';

extension CategoryEnumExtension on CategoryEnum {
  String get label => switch (this) {
        CategoryEnum.cours => "Cours",
        CategoryEnum.retake => "Rattrapage",
        CategoryEnum.td => "Travaux Dirigés",
        CategoryEnum.sn => "Session Normale",
        CategoryEnum.cc => "Contrôle Continu",
        CategoryEnum.other => "Autre",
      };

  String get apiLabel => switch (this) {
        CategoryEnum.cours => "cours",
        CategoryEnum.retake => "rattrapages",
        CategoryEnum.td => "travauxdiriges",
        CategoryEnum.sn => "sessionnormales",
        CategoryEnum.cc => "controlcontinus",
        CategoryEnum.other => "autre",
      };
}
