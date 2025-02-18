import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/domain/entities/subject/subject_entity.dart';

class SubjectTileWidget extends StatelessWidget {
  final List<SubjectEntity> listSubjectEntity;

  const SubjectTileWidget({
    super.key,
    required this.listSubjectEntity,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, item) {
        return ListTile(
          onTap: () => context.router.push(CourseSelectionMenuRoute(
            subjectEntity: listSubjectEntity[item],
          )),

          // leading: Icon(Icons.star),
          title: Text(
            listSubjectEntity[item].name!,
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
      itemCount: listSubjectEntity.length,
    );
  }
}
