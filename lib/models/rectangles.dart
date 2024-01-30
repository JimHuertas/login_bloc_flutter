import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class RectangleAPI extends Equatable{
  final Uuid id;
  final double width;
  final double height;

  const RectangleAPI({
    this.id = const Uuid(),
    required this.width,
    required this.height
  });

  RectangleAPI copyWith({
    final Uuid? id,
    final double? width,
    final double? height
  }) => RectangleAPI(
    id: id ?? this.id,
    width: width ?? this.width, 
    height: height ?? this.height
  );

  @override
  List<Object?> get props => [width, height, id];
}

class Rectangles{
  final List<RectangleAPI> items;
  final RectangleAPI stockSize;
  final String grainDirection;
  final List<RectangleAPI>? resultItems;

  const Rectangles({
    required this.items,
    required this.stockSize,
    required this.grainDirection,
    this.resultItems
  });

  Rectangles copyWith({
    final List<RectangleAPI>? items,
    final RectangleAPI? stockSize,
    final String? grainDirection,
  }) => Rectangles(
    items: this.items, 
    stockSize: this.stockSize, 
    grainDirection: this.grainDirection
  );


  ///return a string of [List] items from class [Rectangles]
  ///example: 
  ///
  ///from: 
  ///```dart
  ///List<Rectangle> [Rectangle(1200, 1200),Rectangle(123,135),Rectangle(145,165)];
  ///```
  ///
  ///to:
  ///
  ///```dart
  ///"[{\"width\": 1200, \"height\": 1200},
  ///{\"width\": 123, \"height\": 135},
  ///{\"width\": 145, \"height\": 165},]";
  ///```
  String _toJsonFromItems(){
    String result = "";
    for (var woodItem in items) {
      result += "{\"width\": ${woodItem.width}, \"height\": ${woodItem.height}},";
    }
    //Eliminar la ultima coma del string
    result = result.substring(0, result.length - 1);
    
    return result;
  }

  Map<String, dynamic> toJson() => {
    "rectangles": [_toJsonFromItems()],
    "stock" : {
      "width" : stockSize.width,
      "height": stockSize.height
    },
    "grainDirection": grainDirection
  };

  // factory Rectangles.fromJson(Map<String,dynamic> json){
  //   return Rectangles(
  //     grainDirection: '',
  //     items: [],
  //     stockSize: Rectangle(width: 0, height: 0),
  //     resultItems: 
  //   );
  // }
}