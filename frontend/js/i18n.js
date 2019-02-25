(function(w) {
    'use strict';
    var deeplegal = w.deeplegal;

    deeplegal.i18n = {

        supportedLanguages: ['en', 'es'],

        //plugins: ['_anchor', '_uploader'].concat(neo.opts.plugins),

        //modules: neo.utils.toArray(neo.opts.modules),

        init: function() {
            if(deeplegal.opts.translationEnabled) {
                $.holdReady(true);

                // Shortcut global translate method
                w._ = w.i18next.t.bind(w.i18next);

                this.initI18next();
            }
        },

        initI18next: function() {
            w.i18next
                .use(w.i18nextXHRBackend)
                //.use(w.i18nextBrowserLanguageDetector) # disable multilanguage support
                .init(this.getConfig(), function(err, t) {
                    $.holdReady(false);
                    deeplegal.trigger('i18nInitialized');
                })
                //.on('initialized', this.onInitialized.bind(this));
        },

        onInitialized: function() {
            $.holdReady(false);
            deeplegal.trigger('i18nInitialized');
        },

        getConfig: function() {
            return {
                // i18next uses the array for internal stuff, so we pass a copy
                whitelist: this.supportedLanguages.slice(0),
                ns: deeplegal.opts.modules,
                //ns: ['menus'],
                load: 'languageOnly',
                defaultNS: 'i18n',
                // submit missing translations
                // 'saveMissing': neo.opts.autoTranslationEnabled,
                // 'saveMissingTo': 'current',
                // allows to use dots in the keys.
                keySeparator: '###',
                lng: 'es',
                backend: this.getBackendConfig()
            }
        },

        getBackendConfig: function() {
            return {
                loadPath: deeplegal.opts.path + 'locales/{{lng}}/{{ns}}.json',
                crossDomain: true 
            }
        },

        toggleLanguage: function() {
            w.i18next.use(w.i18nextBrowserLanguageDetector);
            this.nextLanguage();
        },

        nextLanguage: function() {
            window.riot.update();
            var idx = this.supportedLanguages.indexOf(w.i18next.language.substr(0, 2));
            this.setLanguage(
                this.supportedLanguages[idx + 1] || this.supportedLanguages[0]
            );
        },

        setLanguage: function(lng) {
            w.i18next.changeLanguage(lng, function() {
                w.riot.update();
            });
        },

        // updateOpts: function() {
        //     w.i18next.options.saveMissing = neo.opts.autoTranslationEnabled;
        // },

        // i18nextConfig: function() {
        //     return {
        //         // i18next uses the array for internal stuff, so we pass a copy
        //         'whitelist': neo.i18n.supportedLanguages.slice(0),
        //         'ns': this.modules.concat(this.plugins),
        //         'load': 'languageOnly',
        //         'defaultNS': 'i18n',
        //         // submit missing translations
        //         'saveMissing': neo.opts.autoTranslationEnabled,
        //         'saveMissingTo': 'current',
        //         // allows to use dots in the keys.
        //         'keySeparator': '###',
        //         'lng': 'en',
        //         'backend': this.backendConfig()
        //     };
        // },

        // backendConfig: function() {
        //     return {
        //         allowMultiLoading: true,
        //         loadPath: neo.opts.builderPath + '/locales/{{lng}}/bundle.json',
        //         // We only check if check if English is missing and auto-translate to Spanish
        //         addPath: 'https://localhost:8098/i18n/add/{{ns}}',
        //         crossDomain: true
        //     };
        // },

        
        tWithColon: function(ns, text) {
            return i18next.t(ns + '|' + text, { nsSeparator: '|' });
        }
    };

    //deeplegal.i18n.init();

})(window);