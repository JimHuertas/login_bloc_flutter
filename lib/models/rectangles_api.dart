class Rectangle{
  final double width;
  final double height;
  Rectangle({
    required this.width,
    required this.height
  });
}

class Rectangles{
  final List<Rectangle> items;
  final Rectangle stockSize;
  final String grainDirection;

  const Rectangles({
    required this.items,
    required this.stockSize,
    required this.grainDirection
  });

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
    items.forEach((woodItem) {
      result += "{\"width\": ${woodItem.width}, \"height\": ${woodItem.height}},";
    });
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

}