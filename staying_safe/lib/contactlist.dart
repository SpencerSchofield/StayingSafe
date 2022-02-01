import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactList extends StatelessWidget {
  final Contact contact;
  final database = FirebaseDatabase.instance.ref("users/");
  final database1 = FirebaseDatabase.instance.ref("users/p_key");
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
                .update({
                  "p_key": contact.id,
                })
                .then((_) => print("database1 updated"))
                .catchError((error) => print("Error occurred + $error"));
            database1.update({"name": contact.displayName});
          },
          child: const Text("database"),
        )
      ]));
}
