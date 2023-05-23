import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Account.dart';
import 'database.dart';

class orders extends StatelessWidget{
  // final String uid;
  // orders({required this.uid});
  orders(this.uid,this.name,this.rollno,this.age);
  final String uid;
  final String name;
  final int rollno;
  final String age;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IITB Pharmacy Interface"),
        centerTitle: true,
        backgroundColor: Colors.black87,
        // leading: IconButton(
        //     icon:const Icon(Icons.logout),
        //     onPressed:() {
        //       try{
        //         FirebaseAuth.instance.signOut();
        //       }catch(error){
        //         print(error.toString());
        //       }
        //       Navigator.of(context).pushReplacementNamed('/home');
        //     }
        // ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img2.jpeg'),
            fit: BoxFit.cover,
          ),
        ),

        child : View1(),
      ),
    drawer: PharmacyDrawer(uid:uid,name:name,rollno:rollno,age:age),
    );
  }
}

class View1 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Table(
        children: [
          TableRow(
              children: [
                SizedBox.fromSize(
                  size: Size(150,150), // button width and height
                  child: ClipRect(
                    child: Material(
                      color: Colors.transparent, // button color
                      child: InkWell(
                        splashColor: Colors.grey, // splash color
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PharmacyHome(),
                          ));
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.shopping_cart,size: 110.0,), // icon
                            Text("Orders",style: TextStyle(fontSize: 25)), // text

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: 150,width: 10,),
              ]
          ),
          TableRow(
              children: [

                SizedBox(height: 15,width: 150,),
                //SizedBox(height: 25,width: 10,),
                //SizedBox(height: 15,width: 150,),

              ]
          ),
          TableRow(
              children: [

                SizedBox.fromSize(
                  size: Size(150,150), // button width and height
                  child: ClipRect(
                    child: Material(
                      color: Colors.transparent, // button color
                      child: InkWell(
                        splashColor: Colors.grey, // splash color
                        onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BillingHome(),
                          ));
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.attach_money,size: 110.0,), // icon
                            Text("Billing",style: TextStyle(fontSize: 25)), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: 150,width: 10,),

              ]
          ),
        ],
      ),
    );
  }
}


class PSignInPage extends StatefulWidget {
  const PSignInPage({super.key});

  @override
  State<PSignInPage> createState() => _PSignInPageState();
}

class _PSignInPageState extends State<PSignInPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('IITB Hospital'.tr),
          centerTitle: true,
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon:const Icon(Icons.arrow_back),
            onPressed:() => Navigator.of(context).pushReplacementNamed('/home'),
          ),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      'IITB Hospital'.tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )
                    ,),
                  Padding(
                    // alignment: Alignment.center,
                      padding: const EdgeInsets.all(30),
                      child: Text(
                        'SignIn as Pharmacist'.tr,
                        style: const TextStyle(fontSize: 20),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Enter Email Address",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email Address';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Enter Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        } else if (value.length < 6) {
                          return 'Password must be atleast 6 characters!';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text(
                      'Forgot Password',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<
                              Color>(Colors.black87)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          logInToFb();
                        }
                      },
                      child: Text('SignIn'.tr),
                    ),
                  ),
                ])
            )
        ));
  }

  void logInToFb() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((result) async {
      isLoading = false;
      final ref = FirebaseDatabase.instance.reference();
      final snapshot = await ref.child('Users/${result.user!.uid}').get();
      if (snapshot.exists) {
        if(snapshot.value['role']=='pharmacist'){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => orders(snapshot.value['email'],snapshot.value['name'],int.parse(snapshot.value['phone'].toString()),snapshot.value['age'])),
          );
        }
        else{
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text("No such pharmacist exists"),
                  actions: [
                    ElevatedButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PSignInPage()),
                        );
                      },
                    )
                  ],
                );
              });
        }
      } else {
        print('No data available.');
      }
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PSignInPage()),
                    );
                  },
                )
              ],
            );
          });
    });
  }
}

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueGrey,
      minimumSize: Size.fromHeight(50),
    ),
    child: buildContent(),
    onPressed: onClicked,
  );

  Widget buildContent() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 28),
      SizedBox(width: 16),
      Text(
        text,
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    ],
  );
}

class PharmacyHome extends StatelessWidget{
  PharmacyHome({this.uid});
  final String? uid;

  Future _launchUrl(_url) async {
    if (!await launchUrl(Uri.parse(_url!),mode:LaunchMode.externalApplication)) {
      throw 'Could not launch $_url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IITB Pharmacy Interface'.tr),
        centerTitle: true,
        backgroundColor: Colors.black87,
        leading: IconButton(
            icon:const Icon(Icons.arrow_back),
            onPressed:() => Navigator.of(context).pop()
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img4.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Pharmacy Files').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No orders till now",style : TextStyle(fontSize: 20)),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(20),
                children: snapshot.data!.docs.map((document) {
                  String id=document.id;
                  print(document.id);
                  return Column(
                      children:<Widget>[
                        for(int i=0;i<document["Prescription links"].length;i++)(
                          Row(
                          children:<Widget>[
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  //minimumSize: Size.fromHeight(50),
                                ),
                                onPressed: () {
                                  _launchUrl(document["Prescription links"][i]['url']) ;
                                },
                                child: Text("View", style: TextStyle(
                                    fontSize: 22, color: Colors.white))),
                          SizedBox(width:4),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                //minimumSize: Size.fromHeight(50),
                              ),
                              onPressed: () async {

                                await UrlService(uid:id,url:document["Prescription links"][i]['url']).pendingData("Completed");
                                // Navigator.pushAndRemoveUntil(
                                //   context,
                                //   MaterialPageRoute(builder: (context) =>
                                //       PharmacyHome(uid: uid)),
                                //   // this mymainpage is your page to refresh
                                //       (Route<dynamic> route) => false,
                                // );
                              },
                              child: Text(document["Prescription links"][i]['status'], style: TextStyle(
                                  fontSize: 22, color: Colors.white))),
                            SizedBox(width:4),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  //minimumSize: Size.fromHeight(50),
                                ),
                                onPressed: () async {

                                  await UrlService(uid:id,url:document["Prescription links"][i]['url']).removeData();
                                  // Navigator.pushAndRemoveUntil(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) =>
                                  //       PharmacyHome(uid: uid)),
                                  //   // this mymainpage is your page to refresh
                                  //       (Route<dynamic> route) => false,
                                  // );
                                },
                                child: Text("Remove", style: TextStyle(
                                    fontSize: 22, color: Colors.white))),
                          ],
                          )
                        ),
                      ]
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}

class BillingHome extends StatelessWidget{
  BillingHome({this.uid});
  final String? uid;

  Future _launchUrl(_url) async {
    if (!await launchUrl(Uri.parse(_url!),mode:LaunchMode.externalApplication)) {
      throw 'Could not launch $_url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IITB Pharmacy Interface'.tr),
        centerTitle: true,
        backgroundColor: Colors.black87,
        leading: IconButton(
            icon:const Icon(Icons.arrow_back),
            onPressed:() => Navigator.of(context).pop()
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img4.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Billing Files').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No orders till now",style : TextStyle(fontSize: 20)),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(20),
                children: snapshot.data!.docs.map((document) {
                  String id=document.id;
                  print(document.id);
                  return Column(
                      children:<Widget>[
                        for(int i=0;i<document["Billing links"].length;i++)(
                            Row(
                              children:<Widget>[
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      //minimumSize: Size.fromHeight(50),
                                    ),
                                    onPressed: () {
                                      _launchUrl(document["Billing links"][i]['url']) ;
                                    },
                                    child: Text("View", style: TextStyle(
                                        fontSize: 22, color: Colors.white))),
                                SizedBox(width:4),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      //minimumSize: Size.fromHeight(50),
                                    ),
                                    onPressed: () async {

                                      await UrlService(uid:id,url:document["Billing links"][i]['url']).pendingData("Completed");
                                      // Navigator.pushAndRemoveUntil(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) =>
                                      //       PharmacyHome(uid: uid)),
                                      //   // this mymainpage is your page to refresh
                                      //       (Route<dynamic> route) => false,
                                      // );
                                    },
                                    child: Text(document["Billing links"][i]['status'], style: TextStyle(
                                        fontSize: 22, color: Colors.white))),
                                SizedBox(width:4),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      //minimumSize: Size.fromHeight(50),
                                    ),
                                    onPressed: () async {

                                      await UrlService(uid:id,url:document["Billing links"][i]['url']).removeData();
                                      // Navigator.pushAndRemoveUntil(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) =>
                                      //       PharmacyHome(uid: uid)),
                                      //   // this mymainpage is your page to refresh
                                      //       (Route<dynamic> route) => false,
                                      // );
                                    },
                                    child: Text("Remove", style: TextStyle(
                                        fontSize: 22, color: Colors.white))),
                              ],
                            )
                        ),
                      ]
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}

class PharmacyDrawer extends StatelessWidget{
  final Uri adminmail = Uri.parse('mailto:210050098@iitb.ac.in?subject=&body=');
  PharmacyDrawer({required this.uid,required this.name,required this.rollno,required this.age});
  final String uid;
  final String name;
  final int rollno;
  final String age;
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: Material(
        child: ListView(
          children: <Widget>[
            Container(
              // padding: padding,
              child: Column(
                children : [
                  //const SizedBox(height : 30),
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ), //BoxDecoration
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.green),
                      accountName: Text(name,style:TextStyle(fontSize: 18)),
                      accountEmail: Text(uid,style:TextStyle(fontSize: 18)),
                      currentAccountPictureSize: Size.square(50),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.black12,
                        child:  Icon(
                          Icons.person,
                          size: 40.0,
                        ),
                      ), //circleAvatar
                    ), //UserAccountDrawerHeader
                  ), //
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'.tr,style:TextStyle(fontSize: 18)),
                    hoverColor: Colors.grey,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AdminPage(uid,name,age,rollno.toString()),
                      ));
                    },
                  ),
                  // //const SizedBox(height : 30),
                  // ListTile(
                  //   leading: Icon(Icons.approval),
                  //   title: Text('FAQ'.tr),
                  //   hoverColor: Colors.grey,
                  //   onTap: () {
                  //
                  //   },
                  // ),
                  //const SizedBox(height : 30),
                  // ListTile(
                  //   leading: Icon(Icons.call),
                  //   title: Text('Contact us'.tr,style:TextStyle(fontSize: 18)),
                  //   hoverColor: Colors.grey,
                  //   onTap: () {
                  //     launchUrl(ambulancenumber);
                  //   },
                  // ),
                  //const SizedBox(height : 30),
                  ListTile(
                    leading: Icon(Icons.comment),
                    title: Text('Mail to Admin'.tr,style:TextStyle(fontSize: 18)),
                    hoverColor: Colors.grey,
                    onTap: () {
                      launchUrl(adminmail);
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Sign out'.tr,style:TextStyle(fontSize: 18)),
                    hoverColor: Colors.grey,
                    onTap: () {
                      try{
                        FirebaseAuth.instance.signOut();
                      }catch(error){
                        print(error.toString());
                      }
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

