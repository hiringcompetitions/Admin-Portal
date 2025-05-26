class OfferModel {
  final String title;
  final String category;
  final String organization;
  final String eligibility;
  final String duration;
  final String lastdate;
  final String payout;
  final String location;
  final String about;
  final List<String> otherInfo;
  final bool isTopPick;
  final String url;
  final DateTime timestamp;
  final String uid;

  OfferModel({
    required this.title,
    required this.category,
    required this.organization,
    required this.eligibility,
    required this.duration,
    required this.lastdate,
    required this.payout,
    required this.location,
    required this.about,
    required this.otherInfo,
    required this.isTopPick,
    required this.url,
    required this.timestamp,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'organization': organization,
      'eligibility': eligibility,
      'duration': duration,
      'lastdate': lastdate,
      'payout': payout,
      'location': location,
      'about': about,
      'otherInfo': otherInfo,
      'isTopPick': isTopPick,
      'url':url,
      'timestamp': timestamp,
      'uid':uid
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      organization: map['organization'] ?? '',
      eligibility: map['eligibility'] ?? '',
      duration: map['duration'] ?? '',
      lastdate: map['lastdate'] ?? '',
      payout: map['payout'] ?? '',
      location: map['location'] ?? '',
      about: map['about'] ?? '',
      otherInfo: map['otherInfo'] ?? '',
      isTopPick: map['isTopPick'] ?? false,
      url: map['url']??'',
      timestamp: map['timestamp'].toDate(),
      uid: map['uid']??'',
    );
  }
}
