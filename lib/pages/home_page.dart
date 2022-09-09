// ignore_for_file: prefer_const_constructors, unused_element, unused_field

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// +-----------------------------------------------------------------------------------------------+
/// | We'll define the class "Contact" that'll be defined by a final string "name"                  |
/// | VSCode will make a constructor for this which will be a "constant" and a "required" parameter |
/// +-----------------------------------------------------------------------------------------------+
class Contact {
  final String name;

  // Constructor
  const Contact({
    required this.name,
  });
}

/// +-----------------------------------------------------------------------------------------------------------------------------+
/// | Another thing that we need for the state management we're going to use in this branch is a class called "Contact Book"      |
/// | , a singleton class which will have only one instance available in the entire application and "Contact Book" will manage    |
/// | state of the contacts so that one can add or remove contacts, fetch contacts from an index and get lengths of all the       |
/// | available contacts in this class.                                                                                           |
/// | We'll begin with a very simple "VANILLA" contact book class which won't have state management as such but, it'll have a way |
/// | of hiding its internals by not exposing, for instance, the entire list to the outside world.                                |
/// | After this, we'll create a singleton for "ContactBook". We just want one instance of this class in the entire appplication. |
/// | => Now, we'll create a "private constructor" and we call a "shared instance" and we'll create a "static final" and call     |
/// |    we'll call it ContactBook. It'll return "ContactBook" and we say it's "shared"  (*THIS IS ALSO PRIVATE* as it is being   |
/// |    used privately).                                                                                                         |
/// | This is the pattern of creating singletons in dart.                                                                         |
/// | => Then, we'll create a "FACTORY" of ContactBook that reruns the shared static final.                                       |
/// | => Now, we'll create a storage for all the contacts. For this, we'll create an array. And since we are going to be using a  |
/// |    ListView in our application, we basically need to expose the contacts that this ContactBook is holding on to. So, for    |
/// |    the ListView Builder, we'll have to expose the item count to the application.                                            |
/// | => After this, we'll make a simple "add" function that takes the contact and adds it to the contact list.                   |
/// | => After the "add" function, we'll make a simple "remove" function that removes the contact from the contact list.          |
/// | => We'll also have to have a "retrieve" function that can return a contact using its index. (NOTE: we are not going to      |
/// |    expose the contact as subscript using the function, we're actually going to make return an optional contact and it'll    |
/// |    return the contact's index is actually in range). This is an error function so. it doesn't require any return statement. |
/// |    Then, there is a ternary operator and it's saying that "SHOULD the length of the contacts be MORE than the index         |
/// |    provided, then we actually return at that index otherwise we return NULL".                                               |
/// +-----------------------------------------------------------------------------------------------------------------------------+
class ContactBook {
  ContactBook._sharedInstance();
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  final List<Contact> _contacts = [];

  int get length => _contacts.length;

  void add({required Contact contact}) {
    _contacts.add(contact);
  }

  void remove({required Contact contact}) {
    _contacts.remove(contact);
  }

  Contact? contact({required int atIndex}) =>
      _contacts.length > atIndex ? _contacts[atIndex] : null;
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
