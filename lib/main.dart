import './pharmacysignin.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './dsignin.dart';
import './psignin.dart';
import './admin.dart';
import './ambulance.dart';
import './language.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: const Locale('en','US'),
      theme: ThemeData(
          primaryColor: Colors.white,
          brightness: Brightness.light,
          backgroundColor: const Color(0xFFE5E5E5),
          dividerColor: Colors.white54
      ),
      darkTheme: ThemeData(
          primaryColor: Colors.black,
          brightness: Brightness.dark,
          backgroundColor: const Color(0xFF212121),
          dividerColor: Colors.black12
      ), // standard dark theme
      themeMode: _themeMode,
      title: 'IITB Hospital'.tr,
      home: DocOrPat(),
      routes: {
        '/home': (BuildContext ctx) => DocOrPat(),
        '/dsignin': (BuildContext ctx) => const DSignInPage(),
        '/psignin': (BuildContext ctx) =>  SignInPage(),
        //'/phome' : (BuildContext ctx) =>  PtientsHome(),
        //'/dhome' : (BuildContext ctx) =>  DoctorsHome(),
        '/pharmacy':(BuildContext ctx) => const PSignInPage(),
        '/admin': (BuildContext ctx) => const ASignInPage(),
        '/ambulance':(BuildContext ctx) => const AmbulancePage(),
      },
    );
  }
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}

class DocOrPat extends StatelessWidget {
  DocOrPat({super.key});
  final List locale =[
    {'name':'ENGLISH','locale': const Locale('en','US')},
    {'name':'ಕನ್ನಡ','locale': const Locale('kn','IN')},
    {'name':'हिंदी','locale': const Locale('hi','IN')},
    {'name':'తెలుగు','locale': const Locale('te','IN')},
  ];
  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }
  buildLanguageDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return AlertDialog(
            title: const Text('Choose Your Language'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                        updateLanguage(locale[index]['locale']);
                      },),
                    );
                  },
                  separatorBuilder: (context,index){
                    return Divider(
                      color: Colors.blue,
                    );
                  }, itemCount: locale.length
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    final Uri ambulancenumber = Uri.parse('tel:8985482504');
    final Uri adminmail = Uri.parse('mailto:210050098@iitb.ac.in?subject=&body=');
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: Text(''),
              onTap: (){},
            ),
            ListTile(
              leading: const Icon(Icons.local_hospital,size: 30),
              // title:Padding(
              //   padding: const EdgeInsets.only(bottom: 5.0),
              //   child:  Text('Call for Ambulance',style: TextStyle(fontSize: 20),),
              // ),
              //
              // subtitle: Text('Emergency Ambulance number to contact IITB Hospital',style: TextStyle(fontSize: 16),),
              title:  Text('Call for Ambulance',style: TextStyle(fontSize: 20),),
              onTap: (){
                launchUrl(ambulancenumber);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode,size: 30),
              title: const Text('Dark Mode',style: TextStyle(fontSize: 18),),
              onTap: (){
                MyApp.of(context).changeTheme(ThemeMode.dark);
              },
            ),
            ListTile(
              leading: const Icon(Icons.light_mode,size: 30),
              title: const Text('Light Mode',style: TextStyle(fontSize: 18),),
              onTap: (){
                MyApp.of(context).changeTheme(ThemeMode.light);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language,size: 30),
              title: const Text('Language',style: TextStyle(fontSize: 18),),
              onTap: (){
                buildLanguageDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.mail,size: 30),
              title: const Text('Contact us',style: TextStyle(fontSize: 18),),
              onTap: (){
                launchUrl(adminmail);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("IITB Hospital".tr),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img1.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Homepage(),
      ),
    );
  }
}

class Homepage extends StatelessWidget{
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text('Signin as'.tr,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500
                ),
              )
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.black87
            ),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/psignin');
            },
            child: Text('      Patient      '.tr, style :TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.black87
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/dsignin');
            },
            child:Text('     Doctors     '.tr, style :TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.black87
            ),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/pharmacy');
            },
            child: Text('  Pharmacy  '.tr,style :TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}