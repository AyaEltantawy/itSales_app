import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:itsale/core/components/default_app_bar.dart';

class PhotoViewApp extends StatefulWidget {
  final String url;

  PhotoViewApp(this.url, {super.key});

  @override
  State<PhotoViewApp> createState() => _PhotoViewAppState();
}

class _PhotoViewAppState extends State<PhotoViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    String correctedUrl = widget.url.trim();

    // تأكد من أن الرابط يبدأ بـ https://
    if (!correctedUrl.toLowerCase().startsWith('http')) {
      correctedUrl = 'https://$correctedUrl';
    } else if (correctedUrl.toLowerCase().startsWith('http://')) {
      correctedUrl = 'https://${correctedUrl.substring(7)}';
    }

    // ✅ تحميل صفحة HTML تحتوي على الصورة مع تحجيم مناسب
    final htmlContent = '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body {
            margin: 0;
            padding: 0;
            background-color: #000;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
          }
          img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
          }
        </style>
      </head>
      <body>
        <img src="$correctedUrl" alt="Image" />
      </body>
      </html>
    ''';

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString(htmlContent);

    print('📷 Displaying image from: $correctedUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(back: true, title: 'الصورة'),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
