part of 'cut_wood_api_bloc.dart';

abstract class CodeNumberEvent extends Equatable {
  const CodeNumberEvent();

  @override
  List<Object> get props => [];

}

class DecodeDataFromJsonEvent extends CodeNumberEvent{
  const DecodeDataFromJsonEvent();

}

class ChangeActualValue extends CodeNumberEvent{
  final String newValue;
  final List<CodeNumberPhone> newList;
  const ChangeActualValue(this.newList, this.newValue);
}
