import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TextEditingController _nameController;
  String _username = "Guest357";
  String _email = "";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _loadUserProfile();
  }

  // Load user data from Firestore
  Future<void> _loadUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _username = userData['username'] ?? "User";
          _email = user.email ?? "No Email";
        });
      }
    }
  }

  // Save updated username to Firestore
  Future<void> _saveUsername() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String newUsername = _nameController.text.trim();

      if (newUsername.isNotEmpty) {
        await _firestore.collection('users').doc(user.uid).set({
          'username': newUsername,
        }, SetOptions(merge: true));

        setState(() {
          _username = newUsername;
        });

        Navigator.pop(context); // Close dialog after saving
      }
    }
  }

  // Edit username dialog
  void _editUsername() {
    _nameController.text = _username;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white, // White Dialog Box
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Edit Username",
          style: TextStyle(color: Colors.pink[200], fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: "Enter new username",
            labelStyle: TextStyle(color: Colors.pink[200]),
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          style: TextStyle(color: Colors.pink[200]),
          cursorColor: Colors.pink[200],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: Colors.pink[200])),
          ),
          ElevatedButton(
            onPressed: _saveUsername,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[200],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Soft Background
      appBar: AppBar(
        title: Text("User Profile"),
        backgroundColor: Colors.pink[200],
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.pink[200],
                      child: Text(
                        _username.isNotEmpty ? _username[0].toUpperCase() : "U",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      _username,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[200],
                      ),
                    ),
                    Text(
                      _email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton.icon(
                      onPressed: _editUsername,
                      icon: Icon(Icons.edit, color: Colors.white),
                      label: Text("Edit Name"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
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
    );
  }
}
