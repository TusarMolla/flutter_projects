import 'package:flutter/material.dart';

class BlankPage extends StatefulWidget {
   BlankPage({super.key,required this.title});
  String title;

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(widget.title),),
    );
  }
}
