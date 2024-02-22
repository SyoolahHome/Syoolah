class TtsVoice {
  final String voiceId;
  final String name;
  final dynamic samples;
  final String? category;
  final dynamic description;
  final String? previewUrl;

  TtsVoice({
    required this.voiceId,
    required this.name,
    required this.samples,
    required this.category,
    required this.description,
    required this.previewUrl,
  });

  factory TtsVoice.fromMap(Map<String, dynamic> json) {
    return TtsVoice(
      voiceId: json["voice_id"],
      name: json["name"],
      samples: json["samples"],
      category: json["category"],
      description: json["description"],
      previewUrl: json["preview_url"],
    );
  }
}

class FineTuning {
  final bool isAllowedToFineTune;
  final String finetuningState;
  final List<dynamic> verificationFailures;
  final int verificationAttemptsCount;
  final bool manualVerificationRequested;
  final String language;
  final dynamic finetuningProgress;
  final dynamic message;
  final dynamic datasetDurationSeconds;
  final dynamic verificationAttempts;
  final dynamic sliceIds;
  final dynamic manualVerification;

  FineTuning({
    required this.isAllowedToFineTune,
    required this.finetuningState,
    required this.verificationFailures,
    required this.verificationAttemptsCount,
    required this.manualVerificationRequested,
    required this.language,
    required this.finetuningProgress,
    required this.message,
    required this.datasetDurationSeconds,
    required this.verificationAttempts,
    required this.sliceIds,
    required this.manualVerification,
  });

  factory FineTuning.fromMap(Map<String, dynamic> json) => FineTuning(
        isAllowedToFineTune: json["is_allowed_to_fine_tune"],
        finetuningState: json["finetuning_state"],
        verificationFailures:
            List<dynamic>.from(json["verification_failures"].map((x) => x)),
        verificationAttemptsCount: json["verification_attempts_count"],
        manualVerificationRequested: json["manual_verification_requested"],
        language: json["language"],
        finetuningProgress: json["finetuning_progress"],
        message: json["message"],
        datasetDurationSeconds: json["dataset_duration_seconds"],
        verificationAttempts: json["verification_attempts"],
        sliceIds: json["slice_ids"],
        manualVerification: json["manual_verification"],
      );
}

class Labels {
  final String accent;
  final String description;
  final String age;
  final String gender;
  final String useCase;
  final String labelsDescription;
  final String featured;
  final String usecase;

  Labels({
    required this.accent,
    required this.description,
    required this.age,
    required this.gender,
    required this.useCase,
    required this.labelsDescription,
    required this.featured,
    required this.usecase,
  });

  factory Labels.fromMap(Map<String, dynamic> json) => Labels(
        accent: json["accent"],
        description: json["description"],
        age: json["age"],
        gender: json["gender"],
        useCase: json["use case"],
        labelsDescription: json["description "],
        featured: json["featured"],
        usecase: json["usecase"],
      );
}

class VoiceVerification {
  final bool requiresVerification;
  final bool isVerified;
  final List<dynamic> verificationFailures;
  final int verificationAttemptsCount;
  final dynamic language;
  final dynamic verificationAttempts;

  VoiceVerification({
    required this.requiresVerification,
    required this.isVerified,
    required this.verificationFailures,
    required this.verificationAttemptsCount,
    required this.language,
    required this.verificationAttempts,
  });

  factory VoiceVerification.fromMap(Map<String, dynamic> json) =>
      VoiceVerification(
        requiresVerification: json["requires_verification"],
        isVerified: json["is_verified"],
        verificationFailures:
            List<dynamic>.from(json["verification_failures"].map((x) => x)),
        verificationAttemptsCount: json["verification_attempts_count"],
        language: json["language"],
        verificationAttempts: json["verification_attempts"],
      );
}
