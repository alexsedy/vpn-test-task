class ServerModel {
  final String id;
  final String name;
  final String flagAsset;
  final bool isPremium;
  final String? ipAddress;
  final String? countryCode;

  ServerModel({
    required this.id,
    required this.name,
    required this.flagAsset,
    this.isPremium = false,
    this.ipAddress,
    this.countryCode,
  });
}