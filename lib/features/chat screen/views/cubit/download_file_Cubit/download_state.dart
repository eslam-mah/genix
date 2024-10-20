part of 'download_cubit.dart';

class DownloadState {
  final bool isDownloading;
  final double progress;
  final String loadingMessage;

  DownloadState({
    required this.isDownloading,
    required this.progress,
    this.loadingMessage = '',
  });
}

class DownloadInitial extends DownloadState {
  DownloadInitial() : super(isDownloading: false, progress: 0.0);
}

class DownloadLoading extends DownloadState {
  DownloadLoading({required String loadingMessage})
      : super(isDownloading: true, progress: 0.0, loadingMessage: loadingMessage);
}

class DownloadSuccess extends DownloadState {
  DownloadSuccess() : super(isDownloading: false, progress: 1.0);
}

class DownloadFailure extends DownloadState {
  final String error;

  DownloadFailure({required this.error}) : super(isDownloading: false, progress: 0.0);
}


