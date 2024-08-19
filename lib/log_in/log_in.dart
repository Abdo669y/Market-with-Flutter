import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../iti_project/home_iti.dart';

class LogInScreen extends StatefulWidget {
  static String? username;
  @override
  State<LogInScreen> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<LogInScreen> {

  SharedPreferences? prefs;
  final auth = FirebaseAuth.instance;
  var isPassword = true;
  change() {
    setState(() {
      isPassword = !isPassword;
    });
  }

  TextEditingController password = TextEditingController();

  TextEditingController email = TextEditingController();


  var formKey = GlobalKey<FormState>();

  bool showSpiner = false;

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // checkLoginStatus();
  }

  // void checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  //   setState(() {
  //     this.isLoggedIn = isLoggedIn;
  //   });
  //   if (isLoggedIn) {
  //     Navigator.pushReplacementNamed(context, HomeScreen.homeRoute);
  //   }
  // }

  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    setState(() {
      this.isLoggedIn = true;
    });
    Navigator.of(context).push(MaterialPageRoute(builder:
        (c)=> Home_ITI()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:Center(
            child: Form(
                key: formKey,
                child: SingleChildScrollView(
                    child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              image: AssetImage(
                                'assets/images/7.jpg',
                              ),
                              width: MediaQuery.of(context).size.width * .3,
                              height: MediaQuery.of(context).size.height * .3,
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 170),
                          //   child: Text(
                          //     "ادخل بياناتك:",
                          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child:
                              TextFormField(
                                maxLength: 40,
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "@email",
                                    prefixIcon: Icon(Icons.alternate_email_outlined)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!isValidEmail(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          // Password
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextFormField(
                                maxLength: 8,
                                obscureText: isPassword,
                                controller: password,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color.fromARGB(194, 21, 21, 100),
                                  ),
                                  suffixIcon: isPassword
                                      ? IconButton(
                                      onPressed: () {
                                        change();
                                      },
                                      icon: Icon(Icons.visibility,
                                          color: Color.fromARGB(194, 21, 21, 100)))
                                      : IconButton(
                                      onPressed: () {
                                        change();
                                      },
                                      icon: Icon(Icons.visibility_off,
                                          color: Color.fromARGB(194, 21, 21, 100))),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'password must not be empty';
                                  }else if(value.length < 6){
                                    return "password can't be less than 6 letters";
                                  }
                                  return null;
                                }),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // Phone
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(194, 21, 21, 100),
                                  borderRadius: BorderRadius.circular(10)),
                              width: 250,
                              child: MaterialButton(
                                child: Text(
                                  "Log In",
                                  style: TextStyle(color: Colors.white, fontSize: 23),
                                ),
                                onPressed: () async {
                                  try {
                                    if (formKey.currentState!.validate()) {
                                      await auth.signInWithEmailAndPassword(
                                          email: email.text, password: password.text);
                                      setState(() {
                                        showSpiner = true;
                                      });
                                      login();
                                    }

                                  } catch (e) {
                                    print("----------Error is$e ------------");
                                  }
                                },
                              )),
                          SizedBox(
                            height: 60,
                          ),
                          TextButton(onPressed: () async {
                           await auth.sendPasswordResetEmail(email:email.text);
                          },
                              child: Text("forget password?")
                          )
                        ]
                    )
                )
            ))
    );
  }
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
