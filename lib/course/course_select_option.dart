import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/theme/app_colors.dart';

class CourseSelectOption extends StatefulWidget {
  const CourseSelectOption({super.key});

  @override
  State<CourseSelectOption> createState() => _CourseSelectOptionState();
}

class _CourseSelectOptionState extends State<CourseSelectOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        title: Text("Theorie de la decision"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                // context.router.push(const AmbassadorSpaceRoute());
              },
              leading: Icon(Icons.star),
              title: Text(
                'Espace ambassadeur',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xffA7A7AB),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
