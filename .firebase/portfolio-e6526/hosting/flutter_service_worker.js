'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "009c9e65172e010890f7f65fde438006",
"index.html": "59133ee02e47ca89428dbc575e8a054e",
"/": "59133ee02e47ca89428dbc575e8a054e",
"main.dart.js": "c540ae6a1e3fb91774e20f2cb4fa7fca",
"flutter.js": "1cfe996e845b3a8a33f57607e8b09ee4",
"favicon.png": "6387ff045cf21e37710e80a2e4cc5985",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "6e0d8d8c80fc8dc2e09937f2b2d0841d",
"assets/AssetManifest.json": "b2fa727e2b2eecbd9bb1862d70b3557e",
"assets/NOTICES": "c0beec5bd15deec8bea1f0419ea4b00f",
"assets/FontManifest.json": "57a845617447b70b003764c16214526d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/model_viewer_plus/assets/model-viewer.min.js": "fb3df9ef8e49b5e08b6afcb95521a52c",
"assets/packages/model_viewer_plus/assets/template.html": "8de94ff19fee64be3edffddb412ab63c",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/cjtrust_logo.webp": "f380efcb48d62ea50354ae33121f1edf",
"assets/assets/images/ralaliconnect.png": "a0bb59852ff525904dca5faa7c30abd3",
"assets/assets/images/ralaliagent.png": "6404792432957aa0be443c6f060e7724",
"assets/assets/images/fuas.jpeg": "44c2f1bc038d95e1f85b5b3e3b8e812e",
"assets/assets/images/flutter_logo_white.png": "f9648a2bc3c6e2b9a99a6191aa933595",
"assets/assets/images/react_logo_white.png": "6d5abf80df96e975700fc1b41d62e5bc",
"assets/assets/images/download_playstore.png": "22539b40b08f0b8599b7f4c4cace25a9",
"assets/assets/images/contact_bg.jpeg": "819af4f293a053a15168634fac228bf9",
"assets/assets/images/header_logo.png": "5e3af2d776626f117bef994fa2ce42ae",
"assets/assets/images/main_visual.png": "e10e2160c531abd84ad23e434866e740",
"assets/assets/images/iphone_mockup.png": "b1c03050be2ac3bcea1cae8698a05421",
"assets/assets/images/header_logo_inverted.png": "9d0d9124aca1053f1960180c807a2015",
"assets/assets/images/avatar.png": "a79f1ca607a1357231f56dcb39427555",
"assets/assets/images/ralaliagent_logo.webp": "b5c1f67e9629487173d96152b23670be",
"assets/assets/images/cjtrust.jpeg": "a0cd229fae543a974361b1ed1d9067c3",
"assets/assets/images/education_bg.jpeg": "0cd34fd66bb733f34d1b174e9d3edc75",
"assets/assets/images/logo_no_text.png": "af508152091172f8990143759b0fe617",
"assets/assets/images/ralaliconnect_logo.webp": "4456f3fa3845ba4f75f758a6be276222",
"assets/assets/images/download_appstore.png": "31991acdb6cfb76c623d104f48a4ac38",
"assets/assets/models/skybox.jpg": "93fcf48f850dbe8bd94105d32705b0dc",
"assets/assets/models/environment.hdr": "4f6d4d5cfde05fcb9e9a42c6ffac5ff4",
"assets/assets/models/logo_3d.glb": "c643f2073e2633249e78c565bb3dacec",
"assets/assets/fonts/Lato/Lato-Italic.ttf": "5d22f337a040ae2857e36e7c5800369b",
"assets/assets/fonts/Lato/Lato-LightItalic.ttf": "2404a6da847c878edbc8280745365cba",
"assets/assets/fonts/Lato/Lato-Thin.ttf": "7ab0bc06eecc1b75f8708aba3d3b044a",
"assets/assets/fonts/Lato/Lato-Bold.ttf": "24b516c266d7341c954cb2918f1c8f38",
"assets/assets/fonts/Lato/Lato-Black.ttf": "d83ab24f5cf2be8b7a9873dd64f6060a",
"assets/assets/fonts/Lato/Lato-Regular.ttf": "122dd68d69fe9587e062d20d9ff5de2a",
"assets/assets/fonts/Lato/Lato-BlackItalic.ttf": "047217f671c9e0849c97d43e26543046",
"assets/assets/fonts/Lato/Lato-BoldItalic.ttf": "acc03ac1e9162f0388c005177d55d762",
"assets/assets/fonts/Lato/Lato-Light.ttf": "2bcc211c05fc425a57b2767a4cdcf174",
"assets/assets/fonts/Lato/Lato-ThinItalic.ttf": "2b26bc77c3f9432c9d4ca4911520294d",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
