import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/presentation/dashboard/profil/widgets/editable_avatar_widget.dart';

@RoutePage()
class EditAvatarScreen extends StatefulWidget {
  const EditAvatarScreen({super.key});

  @override
  State<EditAvatarScreen> createState() => _EditAvatarScreenState();
}

class _EditAvatarScreenState extends State<EditAvatarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Editer Ambassadeur"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          children: [
            EditableAvatarWidget(),
            Gap(30.h),
            Text("Choisir ton avatar"),
            GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Nombre de colonnes
                childAspectRatio: 1.0, // Ratio hauteur/largeur pour des carrés
                mainAxisSpacing: 10, // Espacement vertical entre les lignes
                crossAxisSpacing:
                    10, // Espacement horizontal entre les colonnes
              ),
              children: [
                
              ],
            )
          ],
        ),
      ),
    );
  }
}
