import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  final String name;
  final String age;
  final String phone;
  final String uid;
  const AdminPage(this.uid,this.name,this.age,this.phone, {super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Acount',
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('IITB Hospital'),
          centerTitle: true,
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon:const Icon(Icons.arrow_back),
            onPressed:() => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: const BoxDecoration(
                color:Colors.black
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        minRadius: 60.0,
                        child: Icon(
                          Icons.person,
                          size: 80.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(name,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Age',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(age,style: const TextStyle(fontSize: 18)),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Email',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(uid,style: const TextStyle(fontSize: 18,),),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Phone Number',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(phone,style: const TextStyle(fontSize: 18,),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}