import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarttailoring/Clothmeasurement.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MeasurementForm(),
    );
  }
}

class MeasurementForm extends StatefulWidget {
  const MeasurementForm({super.key});

  @override
  _MeasurementFormState createState() => _MeasurementFormState();
}

class _MeasurementFormState extends State<MeasurementForm> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String selectedGender = "Male";

  // Default units
  String heightUnit = "cm";
  String weightUnit = "kg";

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Measurements',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your measurements',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Discover the ideal size for your needs by considering individuals with similar characteristics to yours.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              buildTextFieldWithToggle(
                  "Height", "Enter height", heightController, heightUnit, ["cm", "inch"], (unit) {
                setState(() {
                  heightUnit = unit;
                });
              }),

              const SizedBox(height: 15),

              buildTextFieldWithToggle(
                  "Weight", "Enter weight", weightController, weightUnit, ["kg", "lbs"], (unit) {
                setState(() {
                  weightUnit = unit;
                });
              }),

              const SizedBox(height: 15),

              buildAgeTextField("Age", "Enter age", ageController),

              const SizedBox(height: 15),

              const Text("Gender",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  genderButton("Male"),
                  const SizedBox(width: 10),
                  genderButton("Female"),
                ],
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MeasurementScreen()),
                      );
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldWithToggle(String label, String hint,
      TextEditingController controller, String selectedUnit, List<String> units, Function(String) onUnitChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: units.map((unit) {
                  return GestureDetector(
                    onTap: () => onUnitChange(unit),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: selectedUnit == unit ? Colors.pinkAccent : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.pinkAccent),
                      ),
                      child: Text(
                        unit,
                        style: TextStyle(
                          color: selectedUnit == unit ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildAgeTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text("Years", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget genderButton(String gender) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGender = gender;
          });
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: selectedGender == gender ? Colors.pinkAccent : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.pinkAccent),
          ),
          child: Center(
            child: Text(
              gender,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: selectedGender == gender ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
