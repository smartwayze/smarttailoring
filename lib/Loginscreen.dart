import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Measurment.dart';
import 'Orderscreen.dart'; // Ensure this file exists for the OrderScreen widget.
import 'Signupscreen.dart'; // Ensure this file exists for the signup screen.
import 'package:firebase_core/firebase_core.dart'; // Firebase core to initialize Firebase

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool _isLoading = false; // To show the loading indicator while logging in
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(); // Initialize Firebase
  }

  // Firebase login function
  login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showDialogBox("Enter required fields");
    } else {
      setState(() {
        _isLoading = true; // Start loading
      });

      try {
        // Attempt to sign in with the provided email and password
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Navigate to the OrderScreen after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MeasurementForm()),
        );
      } on FirebaseAuthException catch (ex) {
        // Handling different Firebase error codes
        print("Error Code: ${ex.code}"); // Detailed logging
        print("Error Message: ${ex.message}");

        if (ex.code == 'user-not-found') {
          showDialogBox("Wrong Email", "The email you entered is not registered.");
        } else if (ex.code == 'wrong-password') {
          showDialogBox("Wrong Password", "The password you entered is incorrect.");
        } else if (ex.code == 'invalid-email') {
          showDialogBox("Invalid Email", "The email format is invalid.");
        } else if (ex.code == 'expired-action-code') {
          showDialogBox("Expired Code", "The action code has expired.");
        } else {
          showDialogBox( "Invalid credentials");
        }
      } catch (e) {
        // Catch any other errors
        showDialogBox("Unexpected Error", e.toString());
      } finally {
        setState(() {
          _isLoading = false; // Stop loading after the process is complete
        });
      }
    }
  }

  // Utility to show error dialogs
  void showDialogBox(String title, [String? message]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: message != null ? Text(message) : null,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Utility to check if the email is in valid format
  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE3E3),
              Color(0xFFFFC1C1),
              Color(0xFFFFA1A1),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/pic2.png", height: 330),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  shadowColor: Colors.black26,
                  color: Colors.white.withOpacity(0.95),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Welcome Back!",
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.email, color: Colors.pinkAccent),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: passwordcontroller,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock, color: Colors.pinkAccent),
                            suffixIcon: IconButton(
                              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                              onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              String email = emailcontroller.text.trim();
                              String password = passwordcontroller.text.trim();

                              if (!_isValidEmail(email)) {
                                showDialogBox("Invalid Email", "Please enter a valid email address.");
                                return;
                              }
                              if (password.isEmpty) {
                                showDialogBox("Invalid Password", "Password cannot be empty.");
                                return;
                              }

                              login(email, password); // Call login function
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              elevation: 5,
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text("Login", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupScreen()),
                              );
                            },
                            child: const Text(
                              "Don't have an account? Sign Up",
                              style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
