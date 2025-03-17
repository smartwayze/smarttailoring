import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Orderscreen.dart'; // Make sure to create this file with the OrderScreen widget.
import 'Signupscreen.dart'; // Ensure this file exists for the signup screen.

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _obscurePassword = true; // Toggle password visibility

  login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showDialogBox("Enter required fields");
    } else {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OrderScreen()));
      } on FirebaseAuthException catch (ex) {
        showDialogBox(ex.message ?? "An error occurred");
      }
    }
  }

  void showDialogBox(String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  // Email validation regex
  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email);
  }

  // Handle login
  void _handleLogin() {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();

    if (!_isValidEmail(email)) {
      _showDialog("Invalid Email", "Please enter a valid email address.");
      return;
    }

    if (password.isEmpty) {
      _showDialog("Invalid Password", "Password cannot be empty.");
      return;
    }

    setState(() => _isLoading = true);

    // Simulate backend authentication (replace with real logic)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);

      // Example hardcoded check (replace with your actual backend authentication logic)
      if (email == "test@example.com" && password == "password123") {
        // Navigate to the OrderScreen on successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrderScreen()),
        );
      } else {
        _showDialog("Login Failed", "Invalid email or password.");
      }
    });
  }

  // Show an error dialog
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK", style: TextStyle(color: Colors.pinkAccent)),
            ),
          ],
        );
      },
    );
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
                Image.asset("assets/pic2.png", height: 330),
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
                              // Trigger login function when pressed
                              login(emailcontroller.text, passwordcontroller.text);
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
                              // Navigate to the sign-up screen
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
