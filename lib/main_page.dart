import 'package:flutter/material.dart';
import 'package:flutter_web_api/add_user.dart';
import 'package:flutter_web_api/api_handler.dart';
import 'package:flutter_web_api/edit_page.dart';
import 'package:flutter_web_api/model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  ApiHandler _apiHandler = ApiHandler();
  late List<User> _users = [];

  void getData() async {
    _users = await _apiHandler.getUserData();
    setState(() {});
  }

  @override
  void initState(){
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Работа с API'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.grey,
        textColor: Colors.black,
        padding: const EdgeInsets.all(20),
        onPressed: getData,
        child: const Text('Получить данные'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddData()),);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(user: _users[index])));
                },
                leading: Text("${_users[index].userId}"),
                title: Text(_users[index].password),
                subtitle: Text(_users[index].password),
              );
            }
          )
        ]
      ),  
    );
  }
}