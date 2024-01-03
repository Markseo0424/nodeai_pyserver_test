# pyserver_test

using ```http: ^1.1.0```

server is from python flask, this is for receiving json and image data from python backend server.

```dart
//decoder of image data
Image imageFromByte64(String byte64String){
  Uint8List byteImage = const Base64Decoder().convert(byte64String);

  return Image.memory(byteImage);
}

//getting json data from server
void receiveImageData() async {
  var response = await get(Uri.parse('http://127.0.0.1:5000/img'));
  var jsonData = jsonDecode(response.body);

  setstate((){
    showImage = imageFromByte64(jsonData['img']);
  });
}
```
