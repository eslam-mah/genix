part of 'post_report_cubit.dart';

sealed class PostReportState extends Equatable {
  const PostReportState();

  @override
  List<Object> get props => [];
}

final class PostReportInitial extends PostReportState {}

final class PostReportLoading extends PostReportState {}

final class PostReportSuccess extends PostReportState {
  final ReportForm report;
  const PostReportSuccess({required this.report});
}

final class PostReportError extends PostReportState {}
