import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments ?? 'No data';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: Center(
        child: Text( '$args' , style: const TextStyle(fontSize: 30)),
        // child: Text( 'Message Screen'  , style: TextStyle(fontSize: 30)),
      ),
    );
  }
}