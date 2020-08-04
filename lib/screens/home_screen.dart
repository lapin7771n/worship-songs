import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: Firestore.instance.collection('songs').snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Waiting...');
            }

            return ListView.builder(
              itemBuilder: (c, index) {
                var document = snapshot.data.documents[index].data;
                return ListTile(
                  title: Text(document['title']),
                  subtitle: Text(document['text']),
                );
              },
              itemCount: snapshot.data.documents.length,
            );
          },
        ),
      ),
    );
  }
}
