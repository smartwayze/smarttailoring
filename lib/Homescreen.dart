import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarttailoring/user%20profile.dart';
import 'LadiesStyleScreen.dart';
import 'LoginScreen.dart';
import 'Measurment.dart';
import 'SignupScreen.dart';
import 'childstylescreen.dart';
import 'gentsstyle page.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: Text("Home Screen")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: Container(
                color: Colors.white,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserProfile()),
                          );
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
                        ), PopupMenuItem(
                          value: "History",
                          child: ListTile(
                            leading: Icon(Icons.history, color: Colors.blue),
                            title: Text("History"),
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
                        'assets/images/clothes.jpg',
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
                  _buildCategory('Ladies', 'assets/images/Ladies.jpg', Colors.pinkAccent, context),
                  _buildCategory('Gents', 'assets/images/gents.jpg', Colors.blueAccent, context),
                  _buildCategory('Children', 'assets/images/children.jpg', Colors.orangeAccent, context),
                  _buildCategory('Measurement', 'assets/images/measurement.jpg', Colors.greenAccent, context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: FeedbackSection(),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26, // Shadow color
                      blurRadius: 10, // Softness of the shadow
                      spreadRadius: 2, // How much the shadow spreads
                      offset: Offset(0, 4), // Shadow position
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15), // Matching border radius
                    onTap: () {
                      print("Container tapped!"); // Add your desired action here
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10), // Add padding for better UI
                      child: FeedbackList(),
                    ),
                  ),
                ),
              ),
            ),

            // Ongoing Order Section

            // Rating Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFD1DC),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                ),

              ),
            ),
          ],
        ),
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
}
class FeedbackContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Rate & Give Feedback", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            FeedbackSection(),
            SizedBox(height: 20),
            Text("Recent Feedback", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            FeedbackList(),
          ],
        ),
      ),
    );
  }
}

class FeedbackSection extends StatefulWidget {
  @override
  _FeedbackSectionState createState() => _FeedbackSectionState();
}

class _FeedbackSectionState extends State<FeedbackSection> {
  double _rating = 0.0;
  TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback() async {
    if (_rating <= 0 || _feedbackController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please provide both rating and feedback")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('feedback').add({
        'rating': _rating,
        'feedback': _feedbackController.text.trim(),
        'timestamp': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thank you for your feedback!")),
      );

      _feedbackController.clear();
      setState(() {
        _rating = 0.0;
      });
    } catch (e) {
      print("Error submitting feedback: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error submitting feedback. Try again!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _rating ? Icons.star : Icons.star_border,
                color: Colors.yellow,
              ),
              onPressed: () {
                setState(() {
                  _rating = (index + 1).toDouble();
                });
              },
            );
          }),
        ),
        TextField(
          controller: _feedbackController,
          decoration: InputDecoration(
            labelText: "Your Feedback",
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _submitFeedback,
          child: Text("Submit"),
        ),
      ],
    );
  }
}

class FeedbackList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('feedback').orderBy('timestamp', descending: true).limit(3).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var feedbacks = snapshot.data!.docs;

        return Column(
          children: feedbacks.map((feedback) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: Icon(Icons.star, color: Colors.yellow),
                title: Text(feedback['feedback']),
                subtitle: Text("Rating: ${feedback['rating']} ⭐"),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
Widget _buildCategory(String title, String imagePath, Color bgColor, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (title == "Ladies") {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LadiesStyleScreen()));
      } else if (title == "Gents") {
        Navigator.push(context, MaterialPageRoute(builder: (context) => gentsStyleScreen()));
      } else if (title == "Children") {
        Navigator.push(context, MaterialPageRoute(builder: (context) => childstylescreen()));
      } else if (title == "Measurement") {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MeasurementForm()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please log in to access measurement form."))
          );
        }
      }
    },
    child: Padding(
      padding: EdgeInsets.all(6),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
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
