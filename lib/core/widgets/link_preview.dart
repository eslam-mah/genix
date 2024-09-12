import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

class UrlWidgetPreview extends StatefulWidget {
  @override
  _UrlWidgetPreviewState createState() => _UrlWidgetPreviewState();
}

class _UrlWidgetPreviewState extends State<UrlWidgetPreview> {
  /// I picked these links & images from internet
  final String _errorImage =
      "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg";
  final String _url1 =
      "https://www.espn.in/football/soccer-transfers/story/4163866/transfer-talk-lionel-messi-tells-barcelona-hes-more-likely-to-leave-then-stay";
  final String _url2 =
      "https://speakerdeck.com/themsaid/the-power-of-laravel-queues";
  final String _url3 =
      "https://twitter.com/laravelphp/status/1222535498880692225";
  final String _url4 = "https://www.youtube.com/watch?v=W1pNjxmNHNQ";
  final String _url5 = "https://www.brainyquote.com/topics/motivational-quotes";

  @override
  void initState() {
    super.initState();
    _getMetadata(_url5);
  }

  void _getMetadata(String url) async {
    bool _isValid = _getUrlValid(url);
    if (_isValid) {
      Metadata? _metadata = await AnyLinkPreview.getMetadata(
        link: url,
        cache: Duration(days: 7),
        proxyUrl: "https://corsproxy.org/", // Needed for web app
      );
      debugPrint(_metadata?.title);
      debugPrint(_metadata?.desc);
    } else {
      debugPrint("URL is not valid");
    }
  }

  bool _getUrlValid(String url) {
    bool _isUrlValid = AnyLinkPreview.isValidLink(
      url,
      protocols: ['http', 'https'],
      hostWhitelist: ['https://youtube.com/'],
      hostBlacklist: ['https://facebook.com/'],
    );
    return _isUrlValid;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Any Link Preview')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnyLinkPreview(
                link: _url1,
                displayDirection: UIDirection.uiDirectionHorizontal,
                cache: Duration(hours: 1),
                backgroundColor: Colors.grey[300],
                errorWidget: Container(
                  color: Colors.grey[300],
                  child: Text('Oops!'),
                ),
                errorImage: _errorImage,
              ),
              SizedBox(height: 25),
              AnyLinkPreview(
                link: _url2,
                displayDirection: UIDirection.uiDirectionHorizontal,
                showMultimedia: false,
                bodyMaxLines: 5,
                bodyTextOverflow: TextOverflow.ellipsis,
                titleStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(height: 25),
              AnyLinkPreview(
                displayDirection: UIDirection.uiDirectionHorizontal,
                link: _url3,
                errorBody: 'Show my custom error body',
                errorTitle: 'Next one is youtube link, error title',
              ),
              SizedBox(height: 25),
              AnyLinkPreview(link: _url4),
            ],
          ),
        ),
      ),
    );
  }
}
