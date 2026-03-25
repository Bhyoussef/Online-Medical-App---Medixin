import 'package:flutter/material.dart';

import '../../domain/entities/appointment.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.isPast,
  });

  final Appointment appointment;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    final statusColor = isPast ? const Color(0xFF4ADE80) : const Color(0xFFFB7185);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              appointment.imageUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appointment.doctorName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                Text(appointment.specialty,
                    style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
                const SizedBox(height: 4),
                Text(appointment.time,
                    style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
              ],
            ),
          ),
          Text(appointment.status,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
