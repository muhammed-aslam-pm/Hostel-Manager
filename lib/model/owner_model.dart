class OwnerModel {
  OwnerModel(
      {required this.id,
      required this.hostelName,
      required this.emailAddress,
      required this.mobileNumber,
      required this.ownwerName,
      required this.profilePictuer,
      required this.noOfRooms,
      required this.isAccountSetupCompleted});
  final String id;
  String ownwerName;
  String hostelName;
  final String emailAddress;
  final String mobileNumber;
  String profilePictuer;
  final int noOfRooms;
  final bool isAccountSetupCompleted;

  Map<String, dynamic> toJson() {
    return {
      'OwnerName': ownwerName,
      'HostelName': hostelName,
      'EmailAddress': emailAddress,
      'MobileNumber': mobileNumber,
      'ProfilePictuer': profilePictuer,
      'NoOfRooms': noOfRooms,
      'AccountSetupcompleted': isAccountSetupCompleted
    };
  }
}
