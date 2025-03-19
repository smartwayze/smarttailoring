import 'package:flutter/material.dart';

class gentsStyleScreen extends StatelessWidget {
  const gentsStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> styles = [

      {
        "name": "Casual Wear",
        "images": [
          "assets/mimages/mc1.jpeg",
          "assets/mimages/mc2.jpeg",
          "assets/mimages/mc3.jpeg",
          "assets/mimages/mc4.jpeg",
          "assets/mimages/mc5.jpeg",
          "assets/mimages/mc6.jpeg"
        ]
      },
      {
        "name": "Party Wear",
        "images": [
          "assets/mimages/mp1.jpeg",
          "assets/mimages/mp2.jpeg",
          "assets/mimages/mp3.jpeg",
          "assets/mimages/mp4.jpeg",
          "assets/mimages/mp5.jpeg",
          "assets/mimages/mp6.jpeg"
        ]
      },
      {
        "name": "Shalwar Qameez",
        "images": [
          "assets/mimages/msq1.jpeg",
          "assets/mimages/msq2.jpeg",
          "assets/mimages/msq3.jpeg",
          "assets/mimages/msq4.jpeg",
          "assets/mimages/msq5.jpeg",
          "assets/mimages/msq6.jpeg"
        ]
      },
      {
        "name": "Formal Wear",
        "images": [
          "assets/mimages/mfw1.jpeg",
          "assets/mimages/mfw2.jpeg",
          "assets/mimages/mfw3.jpeg",
          "assets/mimages/mfw4.jpeg",
          "assets/mimages/mfw5.jpeg",
          "assets/mimages/mfw6.jpeg"
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
                "Gents Style",
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