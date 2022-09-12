// ignore_for_file: prefer_const_constructors, unused_element, unused_field, unused_local_variable

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

  // contact add function
  void add({required Contact contact}) {
    _contacts.add(contact);
  }

  // contact remove function
  void remove({required Contact contact}) {
    _contacts.remove(contact);
  }

  // Contact at a specific index
  Contact? contact({required int atIndex}) =>
      _contacts.length > atIndex ? _contacts[atIndex] : null;
}

/// +---------------------------------------------------------------------------------------------------------------------------------+
/// | Now. after creating the above functions, we'll have to work on out homepage which is currently returning an empty scaffold      |
/// | => We'll create a simple ListView using the Builder and for the "itemCount", we'll use the ContactBook length. Fow working      |
/// |    with the ListView, we'll get our Contact in here so that we have an instance of the "ContactBook", a singleton (IMPORTANT)   |
/// |    so it's not going to be initialized over and over again                                                                      |
/// | => For the body, we'll have the ListView builder and provide it the item count.(= contactBook's length)                         |
/// | => Now, for the "itemBuilder", we need to provide the itemBuilder with the context and index and then, we'll return some        |
/// |    widgets. So, we'll return a ListTile widget and for the ListTile, we'll get the contacts first. So, for every contact, we    |
/// |    want to create a list tile to display in the ListView. So, we'll use the "contact at a specific index" function which will   |
/// |    return an "OPTIONAL" contact but, we'll force unwrap it using "!" and it'll be just an actual contact.                       |
/// | => Now that we have our contact, we'll create a list tile and for a tile, what we're goint to say is just a text of contacts.   |
/// |    But, in my previous commit, we had no contacts here. SO, what we could do is to just test this (optional), we'll create a    |
/// |    contact as follows:                                                                                                          |
/// |                             final List<Contact> _contacts = [const Contact(name: 'Foo Bar')];                                   |
/// |    After this, save and perform a hot reload and you'll be able to see the name visible on the HomePage. But, currently, since  |
/// |    we don't have a way for any contacts to be added to this list, it's empty.                                                   |
/// | => So, what we need is to have a way to add new contacts and the way to do that here is to create a "FLOATING ACTION BUTTON".   |
/// |    Now, in the body, we'll add the FLOATING ACTION BUTTON which "onPressed" (initially returning an empty function), will be    |
/// |    used to navigate to the NewContactView page so that the user can add new contacts. Since, "pushNamed" is a future, we'll     |
/// |    change tje function to "await", and its child is going to be an ADD button for obvious reasons. Perform hot restart.         |
/// | => Currently, when we add contact, we won't see any changes on the screen which is simply because the HomePage has no idea      |
/// |    about how to grab the data and THAT is the fundamental of state management in which, we are trying to glue together two      |
/// |    completely different paths inside our user interface. It IS one of the absolute fundamentals of bridging the gap between     |
/// |    your data and the user interface.. So, we need to work on this and grab the data the NewContactView widget created and after |
/// |    putting it inside Contact, we'll refresh the HomePage.                                                                       |
/// +---------------------------------------------------------------------------------------------------------------------------------+
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final contactBook = ContactBook();
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        title: Center(
          child: const Text('Home Page'),
        ),
      ),

      // BODY
      body: ListView.builder(
        itemCount: contactBook.length,
        itemBuilder: (context, index) {
          final contact = contactBook.contact(atIndex: index)!;
          return ListTile(
            title: Text(contact.name),
          );
        },
      ),

      // ADD new contact
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/new-contact');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
