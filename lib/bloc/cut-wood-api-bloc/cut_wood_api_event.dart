part of 'cut_wood_api_bloc.dart';

abstract class CutWoodApiEvent extends Equatable {
  const CutWoodApiEvent();

  @override
  List<Object> get props => [];
}

class SendDataToAPI extends CutWoodApiEvent{
  final Rectangles cutsToSend;
  const SendDataToAPI(this.cutsToSend);
}

class UpdateListCuts extends CutWoodApiEvent{
  final Rectangles newCut;
  const UpdateListCuts(this.newCut);
}