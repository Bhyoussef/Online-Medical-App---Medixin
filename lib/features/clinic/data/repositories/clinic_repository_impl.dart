import '../../domain/entities/appointment.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/repositories/clinic_repository.dart';
import '../models/appointment_model.dart';
import '../models/doctor_model.dart';

class ClinicRepositoryImpl implements ClinicRepository {
  @override
  Future<List<Doctor>> getDoctors() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    const doctors = [
      {
        'id': 'd1',
        'name': 'Dr. Tamim Ikraim',
        'specialty': 'MBBS, Dermatologist specialist',
        'imageUrl': 'https://images.unsplash.com/photo-1612349316228-5942a9b489c2?auto=format&fit=crop&w=200&q=80',
        'rating': 4.8,
        'location': 'London',
      },
      {
        'id': 'd2',
        'name': 'Dr. Tasnim Mridha',
        'specialty': 'MBBS, Dermatologist specialist',
        'imageUrl': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=200&q=80',
        'rating': 4.7,
        'location': 'Brighton',
      },
      {
        'id': 'd3',
        'name': 'Dr. Zubaear Rahim',
        'specialty': 'MBBS, Dental specialist',
        'imageUrl': 'https://images.unsplash.com/photo-1594824475317-9d1f6be6a1d2?auto=format&fit=crop&w=200&q=80',
        'rating': 4.9,
        'location': 'Bristol',
      },
      {
        'id': 'd4',
        'name': 'Dr. Zara Haq Tasim',
        'specialty': 'MBBS, Dermatologist specialist',
        'imageUrl': 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=200&q=80',
        'rating': 4.6,
        'location': 'Northwich',
      },
    ];
    return doctors.map(DoctorModel.fromMap).toList();
  }

  @override
  Future<List<Appointment>> getPastAppointments() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    const past = [
      {
        'id': 'p1',
        'doctorName': 'Dr. Tamim Ikraim',
        'specialty': 'MBBS, Dermatologist specialist',
        'imageUrl': 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=200&q=80',
        'time': '12 September, 2021',
        'status': 'RESCHEDULE',
      },
      {
        'id': 'p2',
        'doctorName': 'Dr. Ralph Edwards',
        'specialty': 'MBBS, Orthodontist specialist',
        'imageUrl': 'https://images.unsplash.com/photo-1612277795421-9bc7706a4a41?auto=format&fit=crop&w=200&q=80',
        'time': '12 September, 2021',
        'status': 'RESCHEDULE',
      },
    ];
    return past.map(AppointmentModel.fromMap).toList();
  }

  @override
  Future<List<Appointment>> getUpcomingAppointments() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    const up = [
      {
        'id': 'u1',
        'doctorName': 'Dr. Tamim Ikraim',
        'specialty': 'MBBS, Dermatologist specialist',
        'imageUrl': 'https://images.unsplash.com/photo-1612349316228-5942a9b489c2?auto=format&fit=crop&w=200&q=80',
        'time': '8:00-8:30 am 17 Oct, 2022',
        'status': 'CANCEL',
      },
      {
        'id': 'u2',
        'doctorName': 'Dr. Tasnim Mridha',
        'specialty': 'MBBS, Dermatologist specialist',
        'imageUrl': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=200&q=80',
        'time': '7:00-7:30 pm 17 Oct, 2022',
        'status': 'CANCEL',
      },
    ];
    return up.map(AppointmentModel.fromMap).toList();
  }
}
