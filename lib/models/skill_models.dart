enum ExchangeType { time, points, cash }

class SkillUser {
  const SkillUser({
    required this.id,
    required this.name,
    required this.avatar,
    required this.country,
    required this.countryFlag,
    required this.trustScore,
    required this.rating,
    required this.skillsOffering,
    required this.skillsWanting,
    required this.sessionsCompleted,
    required this.pointsBalance,
    required this.isVerified,
    required this.bio,
    this.matchScore,
    this.rank,
    this.weeklyPoints,
  });

  final String id;
  final String name;
  final String avatar;
  final String country;
  final String countryFlag;
  final int trustScore;
  final double rating;
  final List<String> skillsOffering;
  final List<String> skillsWanting;
  final int sessionsCompleted;
  final int pointsBalance;
  final bool isVerified;
  final String bio;
  final int? matchScore;
  final int? rank;
  final int? weeklyPoints;
}

class SkillCard {
  const SkillCard({
    required this.id,
    required this.user,
    required this.skillTitle,
    required this.tags,
    required this.exchangeType,
    required this.description,
    required this.category,
  });

  final String id;
  final SkillUser user;
  final String skillTitle;
  final List<String> tags;
  final ExchangeType exchangeType;
  final String description;
  final String category;
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isOwn,
  });

  final String id;
  final String senderId;
  final String text;
  final String timestamp;
  final bool isOwn;
}

enum AppNotificationType { match, session, review, system }

class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.time,
    required this.read,
    this.avatar,
  });

  final String id;
  final AppNotificationType type;
  final String title;
  final String message;
  final String time;
  final bool read;
  final String? avatar;
}
