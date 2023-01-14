import 'package:chat_dodo/data/message_res_model.dart';
import 'package:dio/dio.dart';

class MessageService {
  Future<MessageResModel?> getMessage(String token) async {
    try {
      final _headers = <String, dynamic>{'Authorization': 'Bearer $token'};
      final _result = await Dio().fetch<Map<String, dynamic>>(_setStreamType<
          MessageResModel>(Options(
        method: 'GET',
        headers: _headers,
      )
          .compose(
            Dio().options,
            'messages',
          )
          .copyWith(
              baseUrl:
                  "https://conversation.chatdodo.xyz/api/v1/conversations/CN9556bcc9a7154218a5d97ac572a35671/")));
      var value = MessageResModel.fromJson(_result.data!);
      return value;
    } catch (e) {
      return null;
    }
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
