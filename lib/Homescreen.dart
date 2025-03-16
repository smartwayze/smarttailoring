import 'package:flutter/material.dart';
import 'package:smarttailoring/LadiesStyleScreen.dart'; // Import the LadiesStyleScreen
import 'package:smarttailoring/LoginScreen.dart'; // Import the LoginScreen
import 'package:smarttailoring/SignupScreen.dart'; // Import the SignupScreen

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Theme Color
      body: Column(
        children: [
          // Custom AppBar with Bottom Radius
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            child: Container(
              color: Colors.white, // Background color
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 5,
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: Colors.black),
                    onSelected: (value) {
                      if (value == "Profile") {
                        // Navigate to profile screen
                      } else if (value == "Login") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      } else if (value == "Signup") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupScreen()),
                        );
                      } else if (value == "Logout") {
                        // Handle logout
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        value: "Profile",
                        child: ListTile(
                          leading: Icon(Icons.person, color: Colors.yellow),
                          title: Text("User Profile"),
                        ),
                      ),
                      PopupMenuItem(
                        value: "Login",
                        child: ListTile(
                          leading: Icon(Icons.login, color: Colors.orange),
                          title: Text("Login"),
                        ),
                      ),
                      PopupMenuItem(
                        value: "Signup",
                        child: ListTile(
                          leading: Icon(Icons.app_registration, color: Colors.green),
                          title: Text("Signup"),
                        ),
                      ),
                      PopupMenuItem(
                        value: "Logout",
                        child: ListTile(
                          leading: Icon(Icons.exit_to_app, color: Colors.red),
                          title: Text("Logout"),
                        ),
                      ),
                    ],
                  ),
                ],
                centerTitle: false,
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image with text overlay & Black Button
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Image.asset(
                              'assets/clothes.jpg',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '#Fashion with Smart Tailors',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      backgroundColor: Colors.black45,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'A name of fashion.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      backgroundColor: Colors.black45,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                    ),
                                    child: Text(
                                      "Let’s Go",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Categories Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      childAspectRatio: 1.1,
                      children: [
                        _buildCategory('Ladies', 'assets/Ladies.jpg', Colors.pinkAccent, context),
                        _buildCategory('Gents', 'assets/gents.jpg', Colors.blueAccent, context),
                        _buildCategory('Children', 'assets/children.jpg', Colors.orangeAccent, context),
                        _buildCategory('Measurement', 'assets/measurement.jpg', Colors.greenAccent, context),
                      ],
                    ),
                  ),


                  // Ongoing Order Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFD1DC),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ongoing Order',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.local_shipping, color: Colors.purple),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pickup in 32 mins',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    Text('Status: Pickup in process',
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Rating Section
                  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Container(
    decoration: BoxDecoration(
    color: Color(0xFFFFD1DC),
    borderRadius: BorderRadius.circular(15),
    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
    ),
    child: Padding(
    padding: EdgeInsets.all(16),
    child: Row(
    children: [
    Icon(Icons.star, color: Colors.green, size: 30),
    SizedBox(width: 10),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    '4.8 (2.1k+)',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
    Text(
    'Smart Tailoring Services',
    style: TextStyle(color: Colors.grey, fontSize: 14),
    ),
    ],
    ),
    ],
    ),
    ),
    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  // Updated _buildCategory method with navigation to LadiesStyleScreen
  Widget _buildCategory(String title, String imagePath, Color bgColor, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == "Ladies") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LadiesStyleScreen()),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: title == "Measurement" ? BoxFit.fitHeight : BoxFit.cover,
            ),
          ),
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
