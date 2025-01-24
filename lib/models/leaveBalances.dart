class LeaveBalance {
  String userId;
  int annualEntitlement;
  int annualUsed;
  int sickEntitlement;
  int sickUsed;

  LeaveBalance({
    required this.userId,
    required this.annualEntitlement,
    required this.annualUsed,
    required this.sickEntitlement,
    required this.sickUsed,
  });

  factory LeaveBalance.fromMap(Map<String, dynamic> map) {
    return LeaveBalance(
      userId: map['user_id'],
      annualEntitlement: map['annual_entitlement'],
      annualUsed: map['annual_used'],
      sickEntitlement: map['sick_entitlement'],
      sickUsed: map['sick_used'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'annual_entitlement': annualEntitlement,
      'annual_used': annualUsed,
      'sick_entitlement': sickEntitlement,
      'sick_used': sickUsed,
    };
  }
}
