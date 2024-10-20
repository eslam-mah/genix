part of 'file_picker_cubit.dart';

// State
class FilePickerState {
  List<PlatformFile>? files = [];

  FilePickerState({this.files = const []});

  FilePickerState copyWith({List<PlatformFile>? files}) {
    return FilePickerState(
      files: files ?? this.files,
    );
  }
}

class FilePickerInitial extends FilePickerState {
  final List<PlatformFile> files;
  final bool? loadingState;

  FilePickerInitial({
    this.files = const [],
    this.loadingState = false,
  }) : super(files: []);

  FilePickerInitial copyWith({List<PlatformFile>? files, bool? loadingState}) {
    return FilePickerInitial(
      files: files ?? this.files,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

class FilePickerLoading extends FilePickerState {
  final List<PlatformFile> files;
  final bool? loadingState;

  FilePickerLoading({
    this.files = const [],
    this.loadingState = false,
  }) : super(files: []);

  FilePickerLoading copyWith({List<PlatformFile>? files, bool? loadingState}) {
    return FilePickerLoading(
      files: files ?? this.files,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

class FilePickerSuccess extends FilePickerState {
  final List<PlatformFile> files;
  final bool? loadingState;

  FilePickerSuccess(this.files, {this.loadingState = false});

  FilePickerSuccess copyWith({List<PlatformFile>? files, bool? loadingStat}) {
    return FilePickerSuccess(
      files ?? this.files,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

class FilePickerFailure extends FilePickerState {
  final String error;

  FilePickerFailure(this.error);
}
