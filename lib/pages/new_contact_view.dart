// ignore_for_file: prefer_const_literals_to_create_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_state_management/pages/home_page.dart';

/// +-------------------------------------------------------------------------------------------------------------+
/// | Here, we'll work on a way to ADD new contacts to our app and for that, we'll create a new STATE FULL WIDGET.|
/// | => We'll create a new STF and will call it "NewContactView",                                                |
/// | => Now this will have just a simple scaffold with a column. This new view will contain a simple text field  |
/// |    and a button. The text field will allow the user enter the name of the contact they want to add and the  |
/// |    button will be the CTA which will add the name into the ContactBook. This is the reason why we chose     |
/// |    a STATEFUL WIDGET as we need to actually manage a text editing controller.                               |
/// | => So, in order to control or, in order to grab the text out of the textfield, we will create a text        |
/// |    editing controller. For that, we'll go to the STATE object and and create the controller.                |
/// | => After we have our controller, we also have to go to the initState to initialize it and upon dispose      |
/// |    to get rid of the controller.                                                                            |
/// | => Then, we'll create a textfield in the column children which will be used to grab a user's input. The     |
/// |    text controller for this textField will be "_controller".                                                |
/// | => We'll add a CTA button as well which is just going to be a text button. This button when pressed will    |
/// |    take the name from the input field and will add the name to the ComtactBook. The textButton will add the |
/// |    contact upon pressing it andpop back too! |
/// +-------------------------------------------------------------------------------------------------------------+
class NewContactView extends StatefulWidget {
  const NewContactView({super.key});

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new contact'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter a new contact here...',
            ),
          ),
          TextButton(
            onPressed: () {
              final contact = Contact(name: _controller.text);
              ContactBook().add(contact: contact);
              Navigator.of(context).pop();
            },
            child: const Text('Add contact'),
          )
        ],
      ),
    );
  }
}
