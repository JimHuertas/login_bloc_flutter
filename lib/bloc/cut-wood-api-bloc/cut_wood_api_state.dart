part of 'cut_wood_api_bloc.dart';

enum CutWoodApiStatus {offline, loading, dataReaded}

abstract class CutWoodApiState extends Equatable {
  //List of cuts in main wood
  final Rectangles cuts;
  final List<dynamic>? resultCutsFromApi;
  final CutWoodApiStatus status;

  const CutWoodApiState._({
    required this.status,
    this.cuts = const Rectangles(
      items: [],
      stockSize: RectangleAPI(height: 0, width: 0),
      grainDirection: 'horizontal',
    ), 
    this.resultCutsFromApi
  });
  
  const CutWoodApiState.offline() : this._(
    status: CutWoodApiStatus.offline
  );

  const CutWoodApiState.loading() : this._(
    status: CutWoodApiStatus.loading
  );

  const CutWoodApiState.dataReaded(Rectangles newData) : this._(
    cuts: newData,
    status: CutWoodApiStatus.dataReaded
  );

  @override
  List<Object> get props => [cuts, resultCutsFromApi!];
}

class Offline extends CutWoodApiState{
  const Offline.offline() : super.offline();
}

class Loading extends CutWoodApiState {
  const Loading.loading() : super.loading();
}

class DataReaded extends CutWoodApiState{
  const DataReaded.dataReaded(super.newData) : super.dataReaded();
}

