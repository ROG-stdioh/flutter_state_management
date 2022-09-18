## **FLUTTER STATE MANAGEMENT - The Basics**

### In this branch of Flutter State Management, I'll be focusing on the basics.

---

## What is state management?

- State management, in a broder spectrum, is managing dependencies in an organized and orchestrated way
- In a simpler world, state management is how one can glue together various layers of an application.
- Usually, it includes going through the service layer, business layer and then to the UI layer; it's how one glues together these three layers.
- One may have more (or less) layers in the application that may or may not depend on the states (or data) coming from the backend. This makes the State Management's definition _"fluid"_ and makes it the user's choice how he/she wishes to interpret.

---

## About this branch

- In this branch, I explored some of the _"built-in"_ ways that flutter allows us to manage the state of the application _"internally"_.
- In this, we'll be working on a very simple appliication in which we'll display the list of contacts defined by their name (FName and LName) _i.e._ a name property that we're going to define on the class called **_contact_** on a **_ListView_** and another view for adding new contacts which will be displayed on the List and remove contacts from the list using **_dismissal_** in Flutter.

---

## Getting Started

Let's setup the project first.

First, in the `main.dart` file, make a `stl` widget that returns a `material app` which has `HomePage.dart` (which returns an empty scaffold) as the home. After this, we'll define all the required classes etc. See the files.

- Note: These are some resources to get you started if this is your first Flutter project:

  - [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
  - [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

---

## This is JUST the start!!

This is one of the classic ways of managing state with a singleton ValueNotifier. Here, we used ValueNotifiers and ChangeNotifiers for managing states in Flutter the, you have some builders that _listens_ to those changes.

This is for **very** simple cases like when we don't want to depend on any external packages and want to do something that is just supported by Flutter.

Remember that Flutter has lot more than just ValueNotifier and ChangeNotifiers which we'll discuss in other branches.

- Note: These are some resources to get you started if this is your first Flutter project:

  - [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
  - [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

---

## **About me**

I am a Third Year, Computer Engineering student at Army Institute of Technology, Pune who loves UI/UX, Flutter, Digital Art and a good slice of Pizza 😊.

![](https://media.giphy.com/media/111ebonMs90YLu/giphy.gif)

Socials: [LinkedIn](https://www.linkedin.com/in/surya2807/) and [Instagram](instagram.com/a.k.a._surya/)

---
