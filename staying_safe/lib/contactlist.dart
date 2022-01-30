import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class ContactList extends StatelessWidget {
  final Contact contact;
  final database = FirebaseDatabase.instance.ref();
  ContactList(this.contact);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(contact.displayName)),
      body: Column(children: [
        Text('First Name: ${contact.name.first}'),
        Text('Last Name: ${contact.name.last}'),
        Text(
            'Phone Number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'),
        Text(
            'Email Address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
        ElevatedButton(
          onPressed: () async {
            database
                .set("Hello")
                .then((_) => print("database updated"))
                .catchError((error) => print("Error occurred + $error"));
          },
          child: const Text("database"),
        )
      ]));
}
