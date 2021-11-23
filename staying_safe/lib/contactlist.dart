import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

class ContactList extends StatelessWidget {
  final Contact contact;
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
      ]));
}