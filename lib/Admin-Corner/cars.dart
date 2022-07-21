import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class Cars {
  Cars({
    required this.otherPhotos,
    required this.seats,
    required this.coverPhoto,
    required this.carId,
    required this.dop,
    required this.carModel,
    required this.distance,
  });

  Cars.fromJson(Map<String, Object?> json)
      : this(
          otherPhotos: (json['otherPhotos']! as List).cast<String>(),
          seats: json['seats']! as int,
          coverPhoto: json['coverPhoto']! as String,
          carId: json['carId']! as String,
          dop: json['dop']! as String,
          carModel: json['carModel']! as String,
          distance: json['distance']! as int,
        );

  final String coverPhoto;
  final int seats;
  final String carModel;
  final int distance;
  final String dop;
  final String carId;
  final List<String> otherPhotos;

  Map<String, Object?> toJson() {
    return {
      'otherPhotos': otherPhotos,
      'seats': seats,
      'coverPhoto': coverPhoto,
      'carId': carId,
      'dop': dop,
      'carModel': carModel,
      'distance': distance,
    };
  }
}

final carRef = FirebaseFirestore.instance
    .collection('admins')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .collection('cars')
    .withConverter<Cars>(
      fromFirestore: (snapshots, _) => Cars.fromJson(snapshots.data()!),
      toFirestore: (cars, _) => cars.toJson(),
    );

// class _Car extends StatelessWidget {
//   const _Car(this.vroom, this.reference);

//   final Cars vroom;
//   final DocumentReference<Cars> reference;

//   /// Returns the movie coverPhoto.
//   Widget get coverPhoto {
//     return SizedBox(
//       width: 100,
//       child: Image.network(vroom.coverPhoto),
//     );
//   }

//   /// Returns movie details.
//   Widget get details {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8, right: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           carModel,
//         ],
//       ),
//     );
//   }

//   /// Return the movie carModel.
//   Widget get carModel {
//     return Text(
//       '${vroom.carModel} (${vroom.distance})',
//       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//     );
//   }

//   /// Returns a list of otherPhotos movie tags.
//   List<Widget> get otherPhotosItems {
//     return [
//       for (final otherPhotos in vroom.otherPhotos) Image.network(otherPhotos),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4, top: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           coverPhoto,
//           Flexible(child: details),
//         ],
//       ),
//     );
//   }
// }
