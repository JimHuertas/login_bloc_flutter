import 'dart:io';

import 'package:bloc_flutter_login/models/rectangles.dart';
// import 'package:firebase_auth/firebase_auth.dart' as FBAuth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cut-wood-api-bloc/cut_wood_api_bloc.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CutWoodApiBloc, CutWoodApiState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(187, 244, 155, 1),
            title: const Text('Home Page', style: TextStyle(color: Colors.black87)),
          ),
          body: InformacionUsuario(state: state),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(187, 244, 155, 1),
            child: const Icon(Icons.add, color: Colors.black87, size: 35.0),
            onPressed: () => addNewButton(context, state)
          ),
        );
      },
    );
  }

  addNewButton(BuildContext context, CutWoodApiState state) {
    final widthController = TextEditingController();
    final heightController = TextEditingController();
    if (!Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('New Cut on Main Wood:'),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                _customTextField(
                  controller: widthController, 
                  hintText: 'Width: 12 mm.'
                ),
                _customTextField(
                  controller: heightController, 
                  hintText: 'Height: 12 mm.'
                )
              ]
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5,
              onPressed: (){
                // RectangleAPI newCut = RectangleAPI(
                //   width: double.parse(widthController.text), 
                //   height: double.parse(heightController.text)
                // );

              },
              child: const Text('Add')
            ),
            MaterialButton(
              elevation: 5,
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        )
      );
    }
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text('New Cut in Main Wood'),
          content: 
          Column(
          children: [
            const Divider(),
            SizedBox(
              width: 150,
              height: 30,
              child: CupertinoTextField(
                keyboardType: TextInputType.number,
                placeholder: 'Width: 12 mm.',
                controller: widthController,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 150,
              height: 30,
              child: CupertinoTextField(
                keyboardType: TextInputType.number,
                placeholder: 'Height: 12 mm.',
                controller: heightController,
              ),
            ),
          ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Add'),
              onPressed: (){},
              // onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Exit'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      });
  }

  Container _customTextField({required TextEditingController controller, required String hintText}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            // offset: const Offset(5, 5),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hintText,
        ),
        keyboardType: TextInputType.number,
        controller: controller,
      ),
    );
  }
}

class InformacionUsuario extends StatelessWidget {
  final CutWoodApiState state;
  const InformacionUsuario({
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final res = FBAuth.FirebaseAuth.instance;
    // final user = res.currentUser;
    return Container(
      // padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
              itemCount: state.cuts.items.length,
              itemBuilder: (context, index) =>
                  _bandTile(state.cuts.items[index], index)
        ),
        // Column(
        //   // crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     // const Text('General',
        //     //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        //     // const Divider(),
        //     // ListTile(title: Text('Nombre: ${user!.displayName}')),
        //     // ListTile(title: Text('Numero: ${user.phoneNumber}')),
        //     // ListTile(title: Text('Email: ${user.email}')),
        //   ],
    );
  }

  _bandTile(RectangleAPI rectangle, int index) {
    return Dismissible(
      key: Key(rectangle.id.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) {},
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete Band',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child:
                Text('Width: ${rectangle.width}, Height: ${rectangle.height}'),
          ),
          title: Text(state.cuts.items[index].id.toString()),
          trailing: Text(
            '${rectangle.width}',
            style: const TextStyle(fontSize: 20),
          ),
          onTap: () {}),
    );
  }
}
