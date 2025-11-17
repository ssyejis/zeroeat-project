import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DynamicLinkService {
  static Future<void> shareProduct(String productId) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://zeroeat.page.link',
      link: Uri.parse('https://zeroeat.com/product?id=$productId'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.zeroeat',
        minimumVersion: 1,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.zeroeat',
        minimumVersion: '1.0.0',
      ),
    );
    final ShortDynamicLink shortLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri dynamicUrl = shortLink.shortUrl;

    Share.share(dynamicUrl.toString());
  }

  static Future<void> shareViaSms(String productId, {String? phone}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://zeroeat.page.link',
      link: Uri.parse('https://zeroeat.com/product?id=$productId'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.zeroeat',
        minimumVersion: 1,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.zeroeat',
        minimumVersion: '1.0.0',
      ),
    );
    final ShortDynamicLink shortLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final String url = shortLink.shortUrl.toString();

    final String body = Uri.encodeComponent('이 제품 확인해보세요: $url');

    final Uri smsUri = phone != null
        ? Uri.parse('sms:$phone?body=$body')
        : Uri.parse('sms:?body=$body');

    try {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
        return;
      }
    } catch (_) {
    }
    Share.share('이 제품 확인해보세요: $url');
  }
}