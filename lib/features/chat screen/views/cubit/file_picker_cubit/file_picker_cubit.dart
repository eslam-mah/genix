import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'file_picker_state.dart';

// Cubit
class FilePickerCubit extends Cubit<FilePickerState> {
  FilePickerCubit() : super(FilePickerInitial());

  Future<void> pickMultipleFiles() async {
    try {
      emit(FilePickerLoading());

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['jpg', 'png', 'mp4', 'pdf', 'doc'],
      );

      if (result != null) {
        emit(FilePickerSuccess(result.files));
      } else {
        emit(FilePickerFailure('No file picked'));
      }
    } catch (e) {
      emit(FilePickerFailure('Failed to pick files: $e'));
    }
  }

  void onClear() {
    emit(FilePickerInitial());
  }
  void removeFile(int index) {
    final files = (state as FilePickerSuccess).files;
    files.removeAt(index);
    emit(FilePickerSuccess(files));
  }
}
