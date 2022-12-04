import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Cadastro';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  RegisterPeopleScreen createState() {
    return RegisterPeopleScreen();
  }
}

class RegisterPeopleScreen extends State {
  //Instancia Firestore
  FirebaseFirestore db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: "Nome completo",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),
          
          const SizedBox(height: 20),

          TextFormField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: "Idade",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: "E-mail",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _stateController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: "Estado",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _cityController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: "Cidade",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _addressController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: "Endereço",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: "Telefone",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),

          const SizedBox(height: 52),

          SizedBox(
            width: 232,
            height: 40,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                textStyle: const TextStyle(
                  fontSize: 12,
                ),
              ),
              onPressed: () => sendData(),
              child: const Text("CADASTRAR"),
            ),
          ),
        ],
      ),
    );
  }

  void sendData() {
    String id = const Uuid().v1();

    db.collection('people').doc(id).set({
      'name': _nameController.text,
      'age': _ageController.text,
      'email': _emailController.text,
      'state': _stateController.text,
      'city': _cityController.text,
      'address': _addressController.text,
      'phone': _phoneController.text,
    });

    const snackBar = SnackBar(
      content: Text('Salvo!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
