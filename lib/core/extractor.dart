import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:medium/settings.dart';

import 'package:puppeteer/puppeteer.dart';

class Extractor {
  Future<Uint8List?> getArticle({required String link}) async {
    final browser = await puppeteer.launch(headless: true, args: [
      '--no-sandbox',
      '--disable-setuid-sandbox',
      '--disable-dev-shm-usage',
      '--disable-accelerated-2d-canvas',
      '--disable-gpu',
      '--window-size=1920x1080'
    ], ignoreDefaultArgs: [
      '--disable-extensions'
    ]);
    final page = await browser.newPage();

    await page.setExtraHTTPHeaders({
      'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
      'accept-language': 'en-US,en;q=0.9',
      'cache-control': 'max-age=0',
      'priority': 'u=0, i',
      'sec-ch-ua': '"Not/A)Brand";v="8", "Chromium";v="126", "Google Chrome";v="126"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'document',
      'sec-fetch-mode': 'navigate',
      'sec-fetch-site': 'none',
      'sec-fetch-user': '?1',
      'upgrade-insecure-requests': '1',
      'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36',
    });
    await page.setCookies(cookies);
    await page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36');
    await page.setViewport(const DeviceViewport(width: 1920, height: 1080));

    await page.goto(link);
    final bytes = await page.pdf();
    await page.close();
    await browser.close();
    await Future.delayed(const Duration(seconds: 10));

    return bytes;
  }
}
