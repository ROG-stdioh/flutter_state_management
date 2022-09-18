// ignore_for_file: prefer_const_constructors, unused_element, unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
  final String id;

  // Constructor
  Contact({
    required this.name,
  }) : id = const Uuid().v4();
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
/// +                                                                                                                             +
/// +                                                     STATE MANAGEMENT PART                                                   +
/// +                                                                                                                             +
/// +-----------------------------------------------------------------------------------------------------------------------------+
/// | Now, for the state management part, we'll talk about ValueNotifier which will be used to notify HomePage about the changes  |
/// | in the ContactBook. A ValueNotifier is a class that can manage a single value, in this case, the array of contacts. At any  |
/// | point this value changes, this'll send a notification outsideto ALL its "listeners". So, it is kind of a pattern where it   |
/// | contains a value and other class can listen to the changes to that value and update their logic accordingly.                |
/// | => What we need to do now is, since our ContactBook class manages only one value, so, it is not managing series of changes  |
/// |    it is managing the contact list in the class. We'll use ValueNotifier here. So, let's convert ContactBook class here to  |
/// |    a ValueNotifier of List<Contact>. (Below is the ContactBook class that'll be converted so as to listen to the changes.)  |
//  |                                                                                                                             |
//  |                                  class ContactBook {                                                                        |
//  |                                    ContactBook._sharedInstance();                                                           |
//  |                                    static final ContactBook _shared = ContactBook._sharedInstance();                        |
//  |                                    factory ContactBook() => _shared;                                                        |
//  |                                                                                                                             |
//  |                                    final List<Contact> _contacts = [];                                                      |
//  |                                                                                                                             |
//  |                                    int get length => _contacts.length;                                                      |
//  |                                                                                                                             |
//  |                                    // contact add function                                                                  |
//  |                                    void add({required Contact contact}) {                                                   |
//  |                                      _contacts.add(contact);                                                                |
//  |                                    }                                                                                        |
//  |                                                                                                                             |
//  |                                    // contact remove function                                                               |
//  |                                    void remove({required Contact contact}) {                                                |
//  |                                      _contacts.remove(contact);                                                             |
//  |                                    }                                                                                        |
//  |                                                                                                                             |
//  |                                    // Contact at a specific index                                                           |
//  |                                    Contact? contact({required int atIndex}) =>                                              |
//  |                                        _contacts.length > atIndex ? _contacts[atIndex] : null;                              |
//  |                                  }                                                                                          |
//  |                                                                                                                             |
/// | => After converting, we can see now, it basically says that,"we are extending ValueNotifier but it has a CONSTRUCTOR. So,   |
/// |    we have to pass the value that we are managing". So, in the `ContactBook.sharedInstance()`, we currently manage an empty |
/// |    list. SO, to begin with, the ContactBook has no value and this is our chance in here, for instance, to provide if you    |
/// |    want to read your contacts from some storage provide them here.                                                          |
/// | => The next thing we have to do is to identify contacts because what we are going to do is when we list these contacts on   |
/// |    the screen we're also gonna allow the user to delete these contacts. And for that, we are going to use the widget in     |
/// |    Flutter called `DISMISSIBLE` which needs key for every contact. So, it needs to `uniquely` identify every contact upon   |
/// |    deleting which it will tell you that "THIS ITEM IS DELETED WITH THIS ID". S, for that we need to be able to identify our |
/// |    contacts and "name" is not a good identiier as there can be same names in the ContactBook. So, we'll use the `UUID`      |
/// |    package in "PUBSEC" and then import it here.                                                                             |
/// | => What we need now is to go to our Contact and actually add an ID to it. But we are not gonna expose a UUID but a string   |
/// |    (check line number: 19). Here, the v4 does not return a constant so, we cannot have a const Contact.                     |
/// | => Now that we have converted our ContactBook to a ValueNotifier it can't have its own contact listing, simply because when |
/// |    you say a ValueNotifier and `super([])`, this ValueNotifier in itself actually now has a property called `value`. So,    |
/// |    if you just say `value` we can see it is a "LIST of contact". So, that value is managed by "super. SO, when a class is   |
/// |    converted to a ValueNotifier, the ValueNotifier itself has a value which is specified, i.e.,                             |
/// |                                                                                                                             |
/// |                                  :                                                                                          |
/// |                                  :                                                                                          |
/// |                                  :                                                                                          |
/// |                                  class ContactBook extends ValueNotifier<List<Contact>> {                                   |
/// |                                    ContactBook._sharedInstance() : super([]);                                               |
/// |                                    static final ContactBook _shared = ContactBook._sharedInstance();                        |
/// |                                    factory ContactBook() => _shared;                                                        |
/// |                                                                                                                             |
/// |                                    final List<Contact> _contacts = [];                                                      |
/// |                                  :                                                                                          |
/// |                                  :                                                                                          |
/// |                                                                                                                             |
/// |    here, `ValueNotifier<List<Contact>>` has `List<Contact>` as a specified value. So, we don't have to manage               |
/// |    `final List<Contact> _contacts = [];` anymore.                                                                           |
/// | => Now. let's obsolete that contact list. So, now insted of saying `_contacts.length`, we'll sau `value.lenght`.            |
/// | => Secondly, we'll update our "add" function and insted of using `_contacts`, we'll use `value`.                            |
/// |    The important thing to mention here is that, when we look at the source code of ValueNotifier, it has a setter for value |
/// |    which means that when you change the entire value, it's gonna notify the listeners. But, here we are actually changing   |
/// |    not the value itseld but the "INTERNALS" of values. So, the source code doesn't send any "Setter" signals to our change  |
/// |    notifier. Now, there are various ways of doing that like, manually notifying the listeners: `notifyListeners();` or, be  |
/// |    more explicit as shown.                                                                                                  |
/// | => After this, we'll update `remove(...)` function to use `value`. It'll be similar to the `add(...)` fucntion updation.    |
/// | => The fourth thing we have to do is to update `contact(...)` function to use `value` instead. After all this, we won't     |
/// |    have to have separate list `final List<Contact> _contacts = [];`                                                         |
/// +-----------------------------------------------------------------------------------------------------------------------------+

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance() : super([]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  int get length => value.length;

  // contact add function
  void add({required Contact contact}) {
    final contacts = value;
    contacts.add(contact);
    notifyListeners();
  }

  // contact remove function
  void remove({required Contact contact}) {
    final contacts = value;
    if (contacts.contains(contact)) {
      contacts.remove(contact);
      notifyListeners();
    }
  }

  // Contact at a specific index
  Contact? contact({required int atIndex}) =>
      value.length > atIndex ? value[atIndex] : null;
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
/// |    change the function to "await", and its child is going to be an ADD button for obvious reasons. Perform hot restart.         |
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
          // here, new-contact is the "ROUTE NAME"
          Navigator.of(context).pushNamed('/new-contact');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
