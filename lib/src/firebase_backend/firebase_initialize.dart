import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseInitSingleton {
  FirebaseInitSingleton._();

  static final FirebaseInitSingleton _instance = FirebaseInitSingleton._();

  factory FirebaseInitSingleton() => _instance;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final Stream<User?> authState = FirebaseAuth.instance.userChanges();
//final String? userId = FirebaseAuth.instance.currentUser?.uid;
}
