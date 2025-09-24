import 'package:flutter/material.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/presentation/user/add_car/add_car_chargers.dart';

// class MunalAddCar extends StatelessWidget {
//   const MunalAddCar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF121C24),
//         leading: InkWell(
//           onTap: () => Navigator.pop(context),
//           child: Icon(Icons.arrow_back, color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Container(
//               decoration: ShapeDecoration(
//                 color: Colors.black.withValues(alpha: 0),
//                 shape: RoundedRectangleBorder(
//                   side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: TextField(
//                 controller: TextEditingController(),
//                 style: const TextStyle(color: Colors.white),
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   hintText: 'Search vehicle',
//                   hintStyle: TextStyle(
//                     color: const Color(0xFF787878),
//                     fontSize: 13,
//                     fontFamily: 'Inter',
//                     fontWeight: FontWeight.w400,
//                     height: 1.50,
//                   ),
//                   prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.all(16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class MunalAddCar extends StatefulWidget {
  const MunalAddCar({super.key});

  @override
  _MunalAddCarState createState() => _MunalAddCarState();
}

class _MunalAddCarState extends State<MunalAddCar> {
  String selectedVehicleType = 'Car';
  final List<String> carNames = ['Car Name 1', 'Car Name 2', 'Car Name 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121C24),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              vPad20,
              // Search Bar
              Container(
                decoration: ShapeDecoration(
                  color: const Color(0xFF293933),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF4B5563)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: TextField(
                  controller: TextEditingController(),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Search vehicle',
                    hintStyle: TextStyle(
                      color: const Color(0xFF787878),
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              vPad20,

              // Vehicle Type Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildVehicleTypeChip('Car', Icons.directions_car),
                  const SizedBox(width: 10.0),
                  _buildVehicleTypeChip('Bike', Icons.motorcycle),
                ],
              ),
              vPad20,

              // Vehicle Image Section
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF162521), Color(0xFF293933)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Glow effect
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff01CC01),
                              blurRadius: 100,
                              spreadRadius: 50,
                            ),
                          ],
                        ),
                      ),
                      // Vehicle Image
                      Image.asset(
                        'assets/image/manual_add_car.png', // Placeholder image asset
                        width: 280,
                      ),
                    ],
                  ),
                ),
              ),
              vPad20,

              // Horizontal Divider
              const Divider(color: Color(0xFF293933), thickness: 1.0),
              vPad20,

              // Car Names Section
              Column(
                children: carNames.map((name) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: _buildCarListTile(name),
                  );
                }).toList(),
              ),

              vPad20,

              // Down Arrow Button
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF8B9B95)),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF8B9B95),
                  ),
                ),
              ),
              vPad20,

              // Proceed Button
              PrimaryButton(
                text: "Proceed",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VehiclePlugSelectionScreen(),
                    ),
                  );
                },
              ),
              vPad20,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleTypeChip(String type, IconData icon) {
    bool isSelected = selectedVehicleType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedVehicleType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff01CC01) : const Color(0xFF293933),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFF8B9B95),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(type, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildCarListTile(String name) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.black.withValues(alpha: 0),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: TextField(
              controller: TextEditingController(),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: name,
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(
                  Icons.directions_car,
                  color: Color(0xFF388E3C),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddCarChargers {}
