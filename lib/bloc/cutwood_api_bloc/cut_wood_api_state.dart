part of 'cut_wood_api_bloc.dart';

enum CodeNumberStatus{loading, dataCompleted}

abstract class CodeNumberState extends Equatable {
  final CodeNumberStatus status;
  final String actualValue;
  final List<CodeNumberPhone> codeNumber;
  
  const CodeNumberState._({
    required this.status,
    this.actualValue = "🇵🇪 +51",
    this.codeNumber = const []
  });

  const CodeNumberState.loading() : this._(
    status: CodeNumberStatus.loading, 
  );
  const CodeNumberState.dataCompleted(List<CodeNumberPhone> codeNumberlist, String actulValue) : this._(
    status: CodeNumberStatus.dataCompleted,
    actualValue: actulValue,
    codeNumber: codeNumberlist
  );

  @override
  List<Object?> get props => [status, codeNumber, actualValue];
}

class Loading extends CodeNumberState {
  const Loading.loading() : super.loading();
}

class DataCompleted extends CodeNumberState{
  const DataCompleted.dataCompleted(
    List<CodeNumberPhone> listCodesNumber, String actualValue) 
    : super.dataCompleted(listCodesNumber, actualValue);
}

