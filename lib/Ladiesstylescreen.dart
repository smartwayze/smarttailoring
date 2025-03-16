import 'package:flutter/material.dart';

class LadiesStyleScreen extends StatelessWidget {
  const LadiesStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> styles = [
      {
        "name": "Casual Wear",
        "images": [
          "assets/c1.jpg",
          "assets/c2.jpg",
          "assets/c3.jpg",
          "assets/c4.jpg",
          "assets/c5.jpg",
          "assets/c6.jpg"
        ]
      },
      {
        "name": "Party Wear",
        "images": [
          "assets/p1.jpg",
          "assets/p2.jpg",
          "assets/p3.jpg",
          "assets/p4.jpg",
          "assets/p5.jpg",
          "assets/p6.jpg"
        ]
      },
      {
        "name": "Bridal Wear",
        "images": [
          "assets/b1.jpg",
          "assets/b2.jpg",
          "assets/b3.jpg",
          "assets/b4.jpg",
          "assets/b5.jpg",
          "assets/b6.jpg"
        ]
      },
      {
        "name": "Formal Wear",
        "images": [
          "assets/f1.jpg",
          "assets/f2.jpg",
          "assets/f3.jpg",
          "assets/f4.jpg",
          "assets/f5.jpg",
          "assets/f6.jpg"
        ]
      },
      {
        "name": "Ethnic Wear",
        "images": [
          "assets/e1.jpg",
          "assets/e2.jpg",
          "assets/e3.jpg",
          "assets/e4.jpg",
          "assets/e5.jpg",
          "assets/e6.jpg"
        ]
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.pinkAccent,

            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: AppBar(
            title: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ladies Style",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,

                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.builder(
          itemCount: styles.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      styles[index]["name"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: styles[index]["images"].length,
                          itemBuilder: (context, imgIndex) {
                            if (imgIndex == 1) {
                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    _showFullImage(context, styles[index]["images"][imgIndex]);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      styles[index]["images"][imgIndex],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                _showFullImage(context, styles[index]["images"][imgIndex]);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  styles[index]["images"][imgIndex],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showFullImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: const EdgeInsets.all(20),
              minScale: 0.5,
              maxScale: 6.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
