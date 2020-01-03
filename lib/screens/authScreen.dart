import 'package:flutter/material.dart';
import 'package:global_dhikr_final/models/data.dart';
import 'package:provider/provider.dart';
import 'package:global_dhikr_final/models/email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:global_dhikr_final/screens/settingsScreen.dart';
import 'package:global_dhikr_final/models/onWillPop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthThreePage extends StatefulWidget {
  static String id = 'auth_screen';

  @override
  _AuthThreePageState createState() => _AuthThreePageState();
}

class _AuthThreePageState extends State<AuthThreePage> {
  bool formVisible;
  int _formsIndex;

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onWillPop(context);
      },
      child: Scaffold(
        body: Builder(
          builder: (context) => Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ChangeNotifierProvider<EmailPass>(
                create: (context) => EmailPass(),
                child: Scaffold(
                    body: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/masjidBackground.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            color: Colors.black54,
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: kToolbarHeight + 40),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Welcome",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 30.0,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        "Authentication is required to provide personalized information",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 18.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: <Widget>[
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: RaisedButton(
                                        color: Colors.red,
                                        textColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: Text("Login"),
                                        onPressed: () {
                                          setState(() {
                                            formVisible = true;
                                            _formsIndex = 1;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: RaisedButton(
                                        color: Colors.grey.shade700,
                                        textColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: Text("Signup"),
                                        onPressed: () {
                                          setState(() {
                                            formVisible = true;
                                            _formsIndex = 2;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                  ],
                                ),
                                const SizedBox(height: 40.0),
//                              OutlineButton.icon(
//                                borderSide: BorderSide(color: Colors.red),
//                                color: Colors.red,
//                                textColor: Colors.white,
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(20.0),
//                                ),
//                                icon: Icon(FontAwesomeIcons.google),
//                                label: Text("Continue with Google"),
//                                onPressed: () async {
//                                  try {
//                                    GoogleSignIn googleSignIn = GoogleSignIn();
//                                    GoogleSignInAccount account =
//                                    await googleSignIn.signIn();
//                                    if (account != null) {
//                                      _auth.signInWithCredential(
//                                          GoogleAuthProvider.getCredential(
//                                            idToken: (await account.authentication).idToken,
//                                            accessToken:
//                                            (await account.authentication).accessToken,
//                                          ));
//                                      Navigator.pushReplacementNamed(context, PersonalPage.id);
//                                    }
//                                    else Scaffold.of(context).showSnackBar(SnackBar(
//                                      content: Text('An Error Occured'),
//                                    ));
//                                  } catch (e) {
//                                    print(e);
//                                    Scaffold.of(context).showSnackBar(SnackBar(
//                                      content: Text('An Error Occured'),
//                                    ));
//                                  }
//                                },
//                              ),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 200),
                            child: (!formVisible)
                                ? null
                                : Container(
                              color: Colors.black54,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      RaisedButton(
                                        textColor: _formsIndex == 1
                                            ? Colors.white
                                            : Colors.black,
                                        color: _formsIndex == 1
                                            ? Colors.red
                                            : Colors.white,
                                        child: Text("Login"),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0)),
                                        onPressed: () {
                                          setState(() {
                                            _formsIndex = 1;
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 10.0),
                                      RaisedButton(
                                        textColor: _formsIndex == 2
                                            ? Colors.white
                                            : Colors.black,
                                        color: _formsIndex == 2
                                            ? Colors.red
                                            : Colors.white,
                                        child: Text("Signup"),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0)),
                                        onPressed: () {
                                          setState(() {
                                            _formsIndex = 2;
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 10.0),
                                      IconButton(
                                        color: Colors.white,
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          setState(() {
                                            formVisible = false;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Container(
                                    child: AnimatedSwitcher(
                                      duration: Duration(milliseconds: 300),
                                      child:
                                      _formsIndex == 1 ? LoginForm() : SignupForm(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final passController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email, password;
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Enter email",
              border: OutlineInputBorder(),
            ),
            onChanged: (emailString) {
              email = emailString;
            },
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: passController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
            onChanged: (passString) {
              password = passString;
            },
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Login"),
            onPressed: () async {
              try {
                Provider.of<EmailPass>(context)
                    .updateEmailPassword(email: email, password: password);
                final newUser = await _auth.signInWithEmailAndPassword(
                    email: Provider.of<EmailPass>(context).displayEmail,
                    password: Provider.of<EmailPass>(context).displayPass);
                if (newUser != null) {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('loggedIn', true);
                  userLoggedIn = true;
                  Navigator.pushReplacementNamed(context, Settings.id);
                }
              } catch (e) {
                print(e);
                final snackBar = SnackBar(
                  content: Text('An Error Occured'),
                );
                Scaffold.of(context).showSnackBar(snackBar);
                passController.clear();
                emailController.clear();

              }
            },
          ),
        ],
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final passController = TextEditingController();
  final cpassController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email, password, cpassword;
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (emailString) {
              email = emailString;
            },
            decoration: InputDecoration(
              hintText: "Enter email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: passController,
            obscureText: true,
            onChanged: (passString) {
              password = passString;
            },
            decoration: InputDecoration(
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: cpassController,
            obscureText: true,
            onChanged: (cpassString) {
              cpassword = cpassString;
            },
            decoration: InputDecoration(
              hintText: "Confirm password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Signup"),
            onPressed: () async {
              if (cpassword == password && password.length >= 6) {
                try {
                  Provider.of<EmailPass>(context)
                      .updateEmailPassword(email: email, password: password);
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: Provider.of<EmailPass>(context).displayEmail,
                      password: Provider.of<EmailPass>(context).displayPass);
                  if (newUser != null) {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('loggedIn', true);
                    userLoggedIn = true;
                    Navigator.pushReplacementNamed(context, Settings.id);
                  }
                } catch (e) {
                  print(e);
                  final snackBar = SnackBar(
                    content: Text('An Error Occured'),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                }
              }
              else if (password.length < 6) {
                final snackBar = SnackBar(
                  content: Text('Password must have atleast 6 characters'),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              else {
                final snackBar = SnackBar(
                  content: Text('Passwords do not match'),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              passController.clear();
              emailController.clear();
              cpassController.clear();
            },
          ),
        ],
      ),
    );
  }
}
