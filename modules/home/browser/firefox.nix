{pkgs, ...}: {
  stylix.targets.firefox.profileNames = ["main"];
  programs.firefox = {
    enable = true;
    profiles = {
      main = {
        id = 0;
        name = "main";
        search = {
          force = true;
          default = "ddg";
          engines = {
            "GitHub" = {
              urls = [{template = "https://github.com/search?q={searchTerms}&type=code";}];
              definedAliases = ["@gh"];
            };
            "Nix Packages" = {
              urls = [{template = "https://search.nixos.org/packages?channel=unstable&type=packages&query={searchTerms}";}];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };
            "Nix Options" = {
              urls = [{template = "https://search.nixos.org/options?channel=unstable&type=packages&query={searchTerms}";}];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };
            "Home Manager Options" = {
              urls = [{template = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}";}];
              definedAliases = ["@hm"];
            };
          };
        };
        bookmarks = {
          force = true;
          settings = [
            {
              name = "GitHub";
              keyword = "gh";
              url = "https://github.com";
            }
            {
              name = "ProtonMail";
              keyword = "ma";
              url = "https://mail.proton.me/";
            }
          ];
        };
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
        ];
        settings = {
          # General settings
          "general.smoothScroll" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.download.folderList" = 2;
          "browser.download.dir" = "$HOME/tmp"; # TODO: not certain firefox recognizes $HOME
          "browser.download.lastDir" = "$HOME/tmp";
          "browser.download.useDownloadDir" = true;
          "browser.in-content.dark-mode" = true;
          "browser.theme.content-theme" = 2;
          "ui.systemUsesDarkTheme" = 1;
          # Startup settings
          "browser.aboutConfig.showWarning" = false;
          "browser.startup.page" = 0;
          "browser.startup.homepage" = "about:blank";
          "browser.newtabpage.enabled" = false;
          "browser.newtab.url" = "about:blank";
          "browser.newtab.preload" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.default.sites" = "";
          # Geolocation settings.
          "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILA_API_KEY%";
          "geo.provider.use_gpsd" = false;
          "geo.provider.use_geoclue" = false;
          "browser.region.network.url" = "";
          "browser.region.update.enabled" = false;
          # Language settings
          "intl.accept_languages" = "en-US, en";
          "javascript.use_us_english_locale" = true;
          # Disable auto-updates and recommendations
          "app.update.background.scheduling.enabled" = true;
          "app.update.auto" = true;
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          # Telemetry settings
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemtry.unified" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "toolkit.ping-centre.telemetry" = false;
          "beacon.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;
          # Search settings
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.suggest.searches" = false;
          "browser.fixup.alternate.enabled" = false;
          "browser.urlbar.trimURLs" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.formfill.enable" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.available" = "off";
          "extensions.formautofill.creditCards.available" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.formautofill.heuristics.enabled" = false;
          "browser.urlbar.quicksuggest.scenario" = "history";
          "browser.urlbar.quicksuggest.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          # Password settings
          "signon.rememberSignons" = false;
          "signon.autofillForms" = false;
          "signon.formlessCapture.enabled" = false;
          # TLS-related settings
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_send_http_background_request" = false;
          # UI features
          "extensions.pocket.enabled" = false;
          # Firefox amnesia
          "browser.history_expire_days" = 30;
          "browser.history_expire_days_min" = 30;
          "browser.history_expire_sites" = 30;
          # Performance optimization
          "content.notify.interval" = 100000;
          "browser.cache.jsbc_compression_level" = 3;
          "media.memory_cache_max_size" = 65536;
          "media.cache_readahead_limit" = 7200;
          "media.cache_resume_threshold" = 3600;
          "image.mem.decode_bytes_at_a_time" = 32768;
          "network.buffer.cache.size" = 262144;
          "network.buffer.cache.count" = 128;
          "network.http.max-connections" = 1800;
          "network.http.max-persistent-connections-per-server" = 10;
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.predictor.enabled" = false;
        };
      };
    };
  };
}
