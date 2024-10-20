part of 'add_post_cubit.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object?> get props => [];
}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostSuccess extends AddPostState {
  final Map<String, dynamic> response;

  const AddPostSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class AddPostFailure extends AddPostState {
  final String error;

  const AddPostFailure(this.error);

  @override
  List<Object?> get props => [error];
}
