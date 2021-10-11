import 'package:flutter/material.dart';
import 'package:login_app/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_app/screens/home_page.dart';
import 'package:login_app/utils/auth_service.dart';
import 'package:login_app/utils/validator.dart';
import 'package:login_app/screens/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Row(
                          children: <Widget>[
                            Text(
                              'Hello',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Divider(
                                thickness: 4,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 40),
                          ],
                        ),
                        Text(
                          'Welcome back',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 36,
                              letterSpacing: 5),
                        ),
                        SizedBox(height: 40),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Email',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                controller: _emailController,
                                validator: (value) => Validator.validateEmail(
                                  email: value,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Password',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                controller: _passController,
                                validator: (value) =>
                                    Validator.validatePassword(
                                  pass: value,
                                ),
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                ),
                              ),
                              SizedBox(height: 20),
                              _isProcessing
                                  ? CircularProgressIndicator()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.black,
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  _isProcessing = true;
                                                });

                                                User? user = await AuthService
                                                    .signInUsingEmailPassword(
                                                  email: _emailController.text,
                                                  pass: _passController.text,
                                                );

                                                setState(() {
                                                  _isProcessing = false;
                                                });

                                                if (user != null) {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(user: user),
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                            child: Text(
                                              'Sign In',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              SizedBox(height: 20),
                              Container(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPassword()));
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        color: Colors.blue,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Don’t have account ?',
                                style: TextStyle(color: Colors.white),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                                },
                                child: Text(
                                  'Register here',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
