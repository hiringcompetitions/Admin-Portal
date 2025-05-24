class OfferModel {
  final String title;
  final String category;
  final String company;
  final String eligibility;
  final String duration;
  final String deadline;
  final String reward;
  final String location;
  final String about;
  final List<String> otherInfo;
  final bool isTopPick;
  final DateTime timestamp;

  OfferModel({
    required this.title,
    required this.category,
    required this.company,
    required this.eligibility,
    required this.duration,
    required this.deadline,
    required this.reward,
    required this.location,
    required this.about,
    required this.otherInfo,
    required this.isTopPick,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'company': company,
      'eligibility': eligibility,
      'duration': duration,
      'deadline': deadline,
      'reward': reward,
      'location': location,
      'about': about,
      'otherInfo': otherInfo,
      'isTopPick': isTopPick,
      'timestamp': timestamp,
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      company: map['company'] ?? '',
      eligibility: map['eligibility'] ?? '',
      duration: map['duration'] ?? '',
      deadline: map['deadline'] ?? '',
      reward: map['reward'] ?? '',
      location: map['location'] ?? '',
      about: map['about'] ?? '',
      otherInfo: map['otherInfo'] ?? '',
      isTopPick: map['isTopPick'] ?? false,
      timestamp: map['timestamp'].toDate(),
    );
  }
}
