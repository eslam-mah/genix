import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadState(isDownloading: false, progress: 0.0));

  Future<void> downloadFile(String url, String fileName) async {
    emit(DownloadLoading(loadingMessage: 'Downloading...'));
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$fileName';
    try {
      Dio dio = Dio();
      await dio.download(url, filePath);

      emit(DownloadSuccess());
    } catch (e) {
      emit(DownloadFailure(error: "Failed to download file"));
    }
  }
}
