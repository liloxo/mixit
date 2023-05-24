import 'package:get/get.dart';
import 'package:notes/view/auth/login.dart';
import 'package:notes/view/auth/signup.dart';
import 'package:notes/view/auth/verifyemail.dart';
import 'package:notes/view/home/homepage.dart';
import 'package:notes/view/home/pages/notes/addnote.dart';
import 'package:notes/view/home/pages/notes/viewnote.dart';
import 'package:notes/view/home/pages/recorder/addrecord.dart';
import 'package:notes/view/home/pages/todos/addtodo.dart';
import 'package:notes/view/home/pages/todos/viewtodo.dart';

List<GetPage<dynamic>> routes = [

  //====================Auth=====================
  GetPage(name: '/signup', page: ()        => const SignUp()),
  GetPage(name: '/login', page: ()         => const LogIn()),
  GetPage(name: '/verifyemail', page: ()   => const VerifyEmail()),
  //====================Home======================
  GetPage(name: '/homepage', page: () => const HomePage()),
  //====================Notes==================
  GetPage(name: '/addnote', page: ()  => const AddNote()),
  GetPage(name: '/viewnote', page: () => const ViewNote()),
  //====================ToDos==================
  GetPage(name: '/addtodo', page: ()  => const AddTodo()),
  GetPage(name: '/viewtodo', page: () => const ViewTodo()),
  //====================Recorder==================
  GetPage(name: '/addrecord', page: ()     => const AddRecord()),
  
];