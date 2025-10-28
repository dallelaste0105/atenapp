import 'package:flutter/material.dart';

class UserProfileModel {
  final String uid;
  final String fullName;
  final String roleStatus;
  final String email;

  final String? profilePictureUrl;
  final String? coverImageUrl;

  final int currentLevel;
  final int studyStreakDays;
  final String leagueRanking;
  final String currentSubjectProgress;

  final List<String> featuredAchievements;

  UserProfileModel({
    required this.uid,
    required this.fullName,
    required this.roleStatus,
    required this.email,
    this.profilePictureUrl,
    this.coverImageUrl,
    required this.currentLevel,
    required this.studyStreakDays,
    required this.leagueRanking,
    required this.currentSubjectProgress,
    required this.featuredAchievements,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      uid: json['uid'] as String,
      fullName: json['full_name'] as String,
      roleStatus: json['role_status'] as String,
      email: json['email'] as String,
      profilePictureUrl: json['profile_picture_url'] as String?,
      coverImageUrl: json['cover_image_url'] as String?,
      currentLevel: json['current_level'] as int,
      studyStreakDays: json['study_streak_days'] as int,
      leagueRanking: json['league_ranking'] as String,
      currentSubjectProgress: json['current_subject_progress'] as String,

      featuredAchievements: List<String>.from(
        json['featured_achievements'] as List? ?? [],
      ),
    );
  }

  static UserProfileModel fromMap(Map<String, dynamic> map) {
    return UserProfileModel.fromJson(map);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'full_name': fullName,
      'role_status': roleStatus,
      'email': email,
      'profile_picture_url': profilePictureUrl,
      'cover_image_url': coverImageUrl,
      'current_level': currentLevel,
      'study_streak_days': studyStreakDays,
      'league_ranking': leagueRanking,
      'current_subject_progress': currentSubjectProgress,
      'featured_achievements': featuredAchievements,
    };
  }
}
