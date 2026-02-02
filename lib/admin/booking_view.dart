// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class AllBookingsPage extends StatelessWidget {
//   const AllBookingsPage({super.key});

//   Stream<QuerySnapshot> _bookingsStream() {
//     return FirebaseFirestore.instance
//         .collection("table_bookings")
//         .orderBy("timestamp", descending: true)
//         .snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double maxWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("All Table Bookings"),
//         backgroundColor: Colors.orange,
//       ),

//       body: Center(
//         child: Container(
//           width: maxWidth > 900 ? 700 : maxWidth * 0.95,
//           padding: const EdgeInsets.all(16),

//           child: StreamBuilder<QuerySnapshot>(
//             stream: _bookingsStream(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     "No bookings found.",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 );
//               }

//               final docs = snapshot.data!.docs;

//               return ListView.builder(
//                 itemCount: docs.length,
//                 itemBuilder: (context, index) {
//                   final doc = docs[index];
//                   return _bookingCard(doc);
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   // ------------------------------------------------------
//   // 🔶 CARD WIDGET FOR SINGLE BOOKING
//   // ------------------------------------------------------
//   Widget _bookingCard(QueryDocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;

//     String party = "${data["partySize"] ?? "-"} People";
//     String date = data["date"] ?? "-";
//     String time = data["time"] ?? "-";
//     String name = data["name"] ?? "-";
//     String mobile = data["mobile"] ?? "-";
//     String email = data["email"] ?? "-";
//     String addons = data["specialAddOns"]?.toString().isEmpty ?? true
//         ? "None"
//         : data["specialAddOns"];

//     Timestamp? ts = data["timestamp"];
//     String formattedTime = ts != null
//         ? ts.toDate().toString().substring(0, 16)
//         : "Unknown";

//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

//       child: Padding(
//         padding: const EdgeInsets.all(16),

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _row("Name", name),
//             _row("Party Size", party),
//             _row("Date", date),
//             _row("Time", time),
//             _row("Mobile", mobile),
//             _row("Email", email),
//             _row("Special Add-ons", addons),
//             _row("Booked At", formattedTime),
//           ],
//         ),
//       ),
//     );
//   }

//   // ------------------------------------------------------
//   // 🔶 ROW BUILDER
//   // ------------------------------------------------------
//   Widget _row(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               "$title:",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 14),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllBookingsPage extends StatelessWidget {
  const AllBookingsPage({super.key});

  Stream<QuerySnapshot> _bookingsStream() {
    return FirebaseFirestore.instance
        .collection("table_bookings")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<void> _deleteBooking(BuildContext context, String docId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete booking?"),
        content: const Text("This will permanently delete the booking."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await FirebaseFirestore.instance
          .collection("table_bookings")
          .doc(docId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Booking deleted.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Delete failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Table Bookings"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Container(
          width: maxWidth > 900 ? 700 : maxWidth * 0.95,
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<QuerySnapshot>(
            stream: _bookingsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "No bookings found.",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              final docs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  return _bookingCard(context, doc); // ✅ pass context
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------
  // 🔶 CARD WIDGET FOR SINGLE BOOKING (now includes delete)
  // ------------------------------------------------------
  Widget _bookingCard(BuildContext context, QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    String party = "${data["partySize"] ?? "-"} People";
    String date = data["date"] ?? "-";
    String time = data["time"] ?? "-";
    String name = data["name"] ?? "-";
    String mobile = data["mobile"] ?? "-";
    String email = data["email"] ?? "-";
    String addons = data["specialAddOns"]?.toString().isEmpty ?? true
        ? "None"
        : data["specialAddOns"];

    Timestamp? ts = data["timestamp"];
    String formattedTime =
        ts != null ? ts.toDate().toString().substring(0, 16) : "Unknown";

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Delete button row (keeps everything else same)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                tooltip: "Delete booking",
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteBooking(context, doc.id),
              ),
            ),

            _row("Name", name),
            _row("Party Size", party),
            _row("Date", date),
            _row("Time", time),
            _row("Mobile", mobile),
            _row("Email", email),
            _row("Special Add-ons", addons),
            _row("Booked At", formattedTime),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------
  // 🔶 ROW BUILDER
  // ------------------------------------------------------
  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$title:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
