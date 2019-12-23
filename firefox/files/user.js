// Mozilla User Preferences
user_pref("dom.webnotifications.enabled", false);
user_pref("services.sync.engine.passwords", false);
user_pref("security.ask_for_password", 0);
user_pref("privacy.donottrackheader.enable", true);
user_pref("privacy.resistFingerprintin", true);
user_pref("geo.enabled", false);
// Fix invisible text on dark themes
user_pref("widget.chrome.allow-gtk-dark-theme", true);
user_pref("widget.content.allow-gtk-dark-theme", true);
user_pref("widget.content.gtk-theme-override", "Adwaita"); // or any other light themes
// Fix HTML5 video tearing
user_pref("layers.acceleration.force-enabled", true);
// Enable Cloudflare DoH
user_pref("network.trr.mode", 2);
user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");
