class ApplicantsData {
  String title;
  String companyName;
  String category;
  List<dynamic> eligibility;
  String lastDate;
  String status;
  String uid;
  Stream stream;
  Stream selectedStream;

  ApplicantsData({
    required this.title,
    required this.companyName,
    required this.category,
    required this.eligibility,
    required this.lastDate,
    required this.status,
    required this.uid,
    required this.stream,
    required this.selectedStream,
  });
}