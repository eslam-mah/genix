import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadState(isDownloading: false, progress: 0.0));

  Future<void> downloadFile(String url, String savePath) async {
    emit(DownloadState(isDownloading: true, progress: 0.0, loadingMessage: 'Downloading...'));

    try {
      Dio dio = Dio();
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            emit(DownloadState(
              isDownloading: true,
              progress: received / total,
              loadingMessage: 'Downloading... ${((received / total) * 100).toStringAsFixed(0)}%',
            ));
          }
        },
      );

      emit(DownloadSuccess());
    } catch (e) {
      emit(DownloadFailure(error: "Failed to download file"));
    }
  }
}