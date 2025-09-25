import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121C24),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Review',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildReservationCard(
              userName: 'Saima Akther',
              carModel: 'BMW i4',
              status: 'Confirmed',
              rating: 4,
              comment: 'Good Service',
              images: [
                'assets/image/station_one.jpg',
                'assets/image/station_two.jpg',
                'assets/image/station_three.jpg',
              ],
            ),
            const SizedBox(height: 16),
            _buildReservationCard(
              userName: 'Saima Akther',
              carModel: 'BMW i4',
              status: 'Confirmed',
              rating: 4,
              comment: 'Good Service',
              images: [
                'assets/image/station_one.jpg',
                'assets/image/station_two.jpg',
                'assets/image/station_three.jpg',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationCard({
    required String userName,
    required String carModel,
    required String status,
    int? rating,
    String? comment,
    List<String>? images,
  }) {
    Color statusColor = const Color(0xFF6AB04A);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: ShapeDecoration(
        color: const Color(0xFF182724),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 15,
            offset: Offset(0, 10),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 6,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF1B1B1B),
                backgroundImage: NetworkImage(
                  "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      carModel,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0x1901CC01),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: const Color(0xFF01CC01),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          if (rating != null) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                ...List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  );
                }),
              ],
            ),
          ],
          if (comment != null) ...[
            const SizedBox(height: 8),
            Text(comment, style: const TextStyle(color: Colors.white)),
          ],
          if (images != null && images.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: images.map((url) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    url,
                    width: 100,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
