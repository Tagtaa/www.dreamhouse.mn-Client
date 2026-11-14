import '../base_model.dart';

final class InitialConfigModel extends BaseModel {
  final String baseUrl;
  final String baseUrlChat;
  //final String smsParserApiKey;

  const InitialConfigModel._({
    required this.baseUrl,
    required this.baseUrlChat,
    //required this.smsParserApiKey,
  });

  factory InitialConfigModel.fromJson(Map<dynamic, dynamic> json) {
    return InitialConfigModel._(
      baseUrl: json['base_url'] as String,
      baseUrlChat: json['base_url_chat'] as String,
      //  smsParserApiKey: json['sms_parser_api_key'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[baseUrl, baseUrlChat];
}
