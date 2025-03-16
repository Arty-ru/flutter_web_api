import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_web_api/api_handler.dart';
import 'package:flutter_web_api/model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _formKey = GlobalKey<FormBuilderState>(); 
  ApiHandler _apiHandler = ApiHandler();

  void addData() async {
    if (_formKey.currentState!.saveAndValidate()){
      final data = _formKey.currentState!.value;

      final user = User(
        userId: 0,
        name: data['name'],
        password: data['password']
      );

      await _apiHandler.addData(user: user);
    }
    if (mounted) return
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Отправить данные'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.grey,
        textColor: Colors.black,
        padding: const EdgeInsets.all(20),
        onPressed: addData,
        child: const Text('Отправить'),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,   
        child: Column(
          children: [
            FormBuilderTextField(name: 'name',
            decoration: const InputDecoration(labelText: 'Имя'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required()
              ]),
            ),
            const SizedBox(height: 20),
            FormBuilderTextField(name: 'password',
            decoration: const InputDecoration(labelText: 'Текст'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required()
                ]),
              )
            ],
          ),
        )
      ),
    );
  }
}