import 'package:cloud_firestore/cloud_firestore.dart';

class OpportunityModel {
  final String title;
  final String category;
  final String organization;
  final String eligibility;
  final String duration;
  final DateTime lastdate;
  final String payout;
  final String location;
  final DateTime? eventDate;
  final String about;
  final String otherInfo;
  final bool isTopPick;
  final String url;
  final DateTime timestamp;
  final String uid;

  OpportunityModel({
    required this.title,
    required this.category,
    required this.organization,
    required this.eligibility,
    required this.duration,
    required this.lastdate,
    required this.payout,
    required this.location,
    required this.eventDate,
    required this.about,
    required this.otherInfo,
    required this.isTopPick,
    required this.url,
    required this.timestamp,
    required this.uid,
  });

  OpportunityModel update(key, value) {
    final map = toMap();
    map[key] = value;
    return OpportunityModel.fromMap(map);
  }

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
      'eventDate': eventDate,
      'about': about,
      'otherInfo': otherInfo,
      'isTopPick': isTopPick,
      'url':url,
      'timestamp': timestamp,
      'uid':uid
    };
  }

  factory OpportunityModel.fromMap(Map<String, dynamic> map) {

    DateTime parseDate(dynamic value) {
      if (value == null) return DateTime.now(); // fallback
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      throw Exception('Invalid date format: $value');
    }

    return OpportunityModel(
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      organization: map['organization'] ?? '',
      eligibility: map['eligibility'] ?? '',
      duration: map['duration'] ?? '',
      lastdate: map['lastdate'],
      payout: map['payout'] ?? '',
      location: map['location'] ?? '',
      eventDate: map['eventDate'] != null ? parseDate(map['eventDate']) : null,
      about: map['about'] ?? '',
      otherInfo: map['otherInfo'] ?? '',
      isTopPick: map['isTopPick'] ?? false,
      url: map['url']??'',  
      timestamp: map['timestamp'],
      uid: map['uid']??'',
    );
  }
}
