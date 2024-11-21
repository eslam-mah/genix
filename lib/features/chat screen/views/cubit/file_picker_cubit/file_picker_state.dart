part of 'file_picker_cubit.dart';

abstract class FilePickerState {}

class FilePickerInitial extends FilePickerState {}

class FilePickerLoading extends FilePickerState {}

class FilePickerSuccess extends FilePickerState {
  final List<File> files;

  FilePickerSuccess(this.files);
}

class FilePickerFailure extends FilePickerState {
  final String error;

  FilePickerFailure(this.error);
}
