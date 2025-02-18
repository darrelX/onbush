part of 'course_cubit.dart';

sealed class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

final class CourseInitial extends CourseState {}
