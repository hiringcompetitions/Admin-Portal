import 'package:cloud_firestore/cloud_firestore.dart';

class PieChartServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> branches = [
    'CSE', 'ECE', 'AIML', 'AIDS', 'EEE', 'CSBS', 'MECH', 'CIVIL',
  ];

  Future<Map<String, int>> fetchBranchCounts(String opportunityId) async {
    final applicantsRef = _firestore
        .collection('Opportunities')
        .doc(opportunityId)
        .collection('Applicants');

    final allDocsSnapshot = await applicantsRef.limit(1).get();

    if (allDocsSnapshot.docs.isEmpty) {
      return {};
    }

    Map<String, int> counts = {};

    for (var branch in branches) {
      final snapshot = await applicantsRef
          .where('branch', isEqualTo: branch)
          .get();
      counts[branch] = snapshot.docs.length;
    }

    return counts;
  }
}
