import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onbush/core/application/data/models/subject_model.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';

class SubjectTileWidget extends StatelessWidget {
  final List<String> listCourseName;
  final List<SubjectModel> listSubjectModel;

  const SubjectTileWidget({
    required this.listCourseName,
    super.key,
    required this.listSubjectModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, item) {
        return ListTile(
          onTap: () => context.router.push(CourseSelectionMenuRoute(
            subjectModel: listSubjectModel[item],
          )),

          // leading: Icon(Icons.star),
          title: Text(
            listCourseName[item],
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Color(0xffA7A7AB),
          ),
        );
      },
      itemCount: listCourseName.length,
    );
  }
}
