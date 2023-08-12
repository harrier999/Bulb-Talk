class WebsocketEvent {
  final String type;
  final dynamic payload;
  WebsocketEvent(this.type, this.payload);

  WebsocketEvent.FromJson(Map<String, dynamic> json)
      : type = json['type'],
        payload = json['payload'];
  
  
}
