import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/report_form.dart';
import 'package:genix/features/home%20screen/data/repos/report_repository.dart';

part 'post_report_state.dart';

class PostReportCubit extends Cubit<PostReportState> {
  PostReportCubit() : super(PostReportInitial());
  final ReportRepository postReportRepo = ReportRepository();
  Future<void> postReport({required ReportForm data}) async {
    emit(PostReportLoading());
    final result = await postReportRepo.postReport(data: data.toJson());
    result.fold((l) => emit(PostReportError()), (r) {
      final report = ReportForm.fromJson(data.toJson());
      emit(PostReportSuccess(report: report));
    });
  }
}
