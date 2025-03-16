import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_web_api/api_handler.dart';
import 'package:flutter_web_api/model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final User user;
  const EditPage({super.key, required this.user});

  @override
  State<EditPage> createState() => _EditPage();
}

class _EditPage extends State<EditPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler _apiHandler = ApiHandler();
  late http.Response _response;

  void updateData() async {
    if (_formKey.currentState!.saveAndValidate()){
      final data = _formKey.currentState!.value;

      final User user = User(
        userId: widget.user.userId,
        name: data['name'],
        password: data['password']
      );

      _response = await _apiHandler.updateUser(widget.user.userId, user);
    }
    if (mounted) return
    Navigator.pop(context);
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменить'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.grey,
        textColor: Colors.black,
        padding: const EdgeInsets.all(20),
        onPressed: updateData,
        child: const Text('Обновить'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          initialValue: {
            'name': widget.user.name,
            'password': widget.user.password
          },
        
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