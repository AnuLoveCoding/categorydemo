import 'package:flutter/material.dart';

class SeconPage extends StatefulWidget {

  String name;
  String img;
   SeconPage({Key? key,required this.name,required this.img}) : super(key: key);

  @override
  State<SeconPage> createState() => _SeconPageState();
}

class _SeconPageState extends State<SeconPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.name),),

    body: Column(
      children: [

        ListTile(title: Text(widget.name),),
        Image.network(widget.img,)

      ],
    ),
    );
  }
}
