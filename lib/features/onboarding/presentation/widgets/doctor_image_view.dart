import 'package:flutter/material.dart';

class DoctorImageView extends StatelessWidget {
  const DoctorImageView({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          loadingBuilder: (context, child, progress) {
            if (progress == null) {
              return child;
            }
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE9EEF9),
              alignment: Alignment.center,
              child: const Icon(Icons.person, size: 88),
            );
          },
        ),
      ),
    );
  }
}
