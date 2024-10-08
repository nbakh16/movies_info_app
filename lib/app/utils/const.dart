class App {
  final String _version = '0.6.0';
  String get version => _version;
}

String getGreetingMessage() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    List<String> msg = [
      'Good morning 👋, Great day ahead!',
      'Rise and shine 👋, Embrace the possibilities!',
      'Good morning 👋, Let’s make today unforgettable!',
      'Morning sunshine 👋, Today is a gift!',
    ];
    return (msg..shuffle()).first;
  } else if (hour >= 12 && hour < 18) {
    List<String> msg = [
      'Good Afternoon 🌞, Hope your day is going well!',
      'Happy Afternoon 🌞, A little break can boost your energy!',
      'Afternoon vibes 🌞, Keep pushing through the day!',
      'Good Afternoon 🌞, Almost time to unwind!',
    ];
    return (msg..shuffle()).first;
  } else if (hour >= 18 && hour < 23) {
    List<String> msg = [
      'Good Evening 👋, Time to relax and enjoy the moment!',
      'Good Evening 👋, Let’s savor the night ahead!',
      'Happy Evening 👋, Time to unwind and enjoy!',
      'Happy Evening 👋, Perfect time to reflect and recharge!',
    ];
    return (msg..shuffle()).first;
  } else {
    List<String> msg = [
      'Hello! Night Owl 🦉, Rest and recharge for tomorrow!',
      'Hello! Night Owl 🦉, Tomorrow is a new chance to shine!',
      'Hello! Night Owl 🦉, Time to relax and enjoy the moment!',
      'Hello! Night Owl 🦉, Drift off into sweet slumber!',
    ];
    return (msg..shuffle()).first;
  }
}

Map<String, String> languageMap = {
  'aa': 'Afar',
  'ab': 'Abkhazian',
  'af': 'Afrikaans',
  'ak': 'Akan',
  'sq': 'Albanian',
  'am': 'Amharic',
  'ar': 'Arabic',
  'an': 'Aragonese',
  'hy': 'Armenian',
  'as': 'Assamese',
  'av': 'Avaric',
  'ae': 'Avestan',
  'ay': 'Aymara',
  'az': 'Azerbaijani',
  'ba': 'Bashkir',
  'bm': 'Bambara',
  'eu': 'Basque',
  'be': 'Belarusian',
  'bn': 'Bengali',
  'bh': 'Bihari languages',
  'bi': 'Bislama',
  'bs': 'Bosnian',
  'br': 'Breton',
  'bg': 'Bulgarian',
  'my': 'Burmese',
  'ca': 'Catalan; Valencian',
  'ch': 'Chamorro',
  'ce': 'Chechen',
  'zh': 'Chinese',
  'cn': 'Chinese',
  'cu':
      'Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic',
  'cv': 'Chuvash',
  'kw': 'Cornish',
  'co': 'Corsican',
  'cr': 'Cree',
  'cs': 'Czech',
  'da': 'Danish',
  'dv': 'Divehi; Dhivehi; Maldivian',
  'nl': 'Dutch; Flemish',
  'dz': 'Dzongkha',
  'en': 'English',
  'eo': 'Esperanto',
  'et': 'Estonian',
  'ee': 'Ewe',
  'fo': 'Faroese',
  'fj': 'Fijian',
  'fi': 'Finnish',
  'fr': 'French',
  'fy': 'Western Frisian',
  'ff': 'Fulah',
  'ka': 'Georgian',
  'de': 'German',
  'gd': 'Gaelic; Scottish Gaelic',
  'ga': 'Irish',
  'gl': 'Galician',
  'gv': 'Manx',
  'el': 'Greek',
  'gn': 'Guarani',
  'gu': 'Gujarati',
  'ht': 'Haitian; Haitian Creole',
  'ha': 'Hausa',
  'he': 'Hebrew',
  'hz': 'Herero',
  'hi': 'Hindi',
  'ho': 'Hiri Motu',
  'hr': 'Croatian',
  'hu': 'Hungarian',
  'ig': 'Igbo',
  'is': 'Icelandic',
  'io': 'Ido',
  'ii': 'Sichuan Yi; Nuosu',
  'iu': 'Inuktitut',
  'ie': 'Interlingue; Occidental',
  'ia': 'Interlingua (International Auxiliary Language Association)',
  'id': 'Indonesian',
  'ik': 'Inupiaq',
  'it': 'Italian',
  'jv': 'Javanese',
  'ja': 'Japanese',
  'kl': 'Kalaallisut; Greenlandic',
  'kn': 'Kannada',
  'ks': 'Kashmiri',
  'kr': 'Kanuri',
  'kk': 'Kazakh',
  'km': 'Central Khmer',
  'ki': 'Kikuyu; Gikuyu',
  'rw': 'Kinyarwanda',
  'ky': 'Kirghiz; Kyrgyz',
  'kv': 'Komi',
  'kg': 'Kongo',
  'ko': 'Korean',
  'kj': 'Kuanyama; Kwanyama',
  'ku': 'Kurdish',
  'lo': 'Lao',
  'la': 'Latin',
  'lv': 'Latvian',
  'li': 'Limburgan; Limburger; Limburgish',
  'ln': 'Lingala',
  'lt': 'Lithuanian',
  'lb': 'Luxembourgish; Letzeburgesch',
  'lu': 'Luba-Katanga',
  'lg': 'Ganda',
  'mk': 'Macedonian',
  'mh': 'Marshallese',
  'ml': 'Malayalam',
  'mi': 'Maori',
  'mr': 'Marathi',
  'ms': 'Malay',
  'mg': 'Malagasy',
  'mt': 'Maltese',
  'mo': 'Moldavian; Moldovan',
  'mn': 'Mongolian',
  'na': 'Nauru',
  'nv': 'Navajo; Navaho',
  'nr': 'Ndebele, South; South Ndebele',
  'nd': 'Ndebele, North; North Ndebele',
  'ng': 'Ndonga',
  'ne': 'Nepali',
  'nn': 'Norwegian Nynorsk; Nynorsk, Norwegian',
  'nb': 'Bokmål, Norwegian; Norwegian Bokmål',
  'no': 'Norwegian',
  'ny': 'Chichewa; Chewa; Nyanja',
  'oc': 'Occitan (post 1500)',
  'oj': 'Ojibwa',
  'or': 'Oriya',
  'om': 'Oromo',
  'os': 'Ossetian; Ossetic',
  'pa': 'Panjabi; Punjabi',
  'fa': 'Persian',
  'pi': 'Pali',
  'pl': 'Polish',
  'pt': 'Portuguese',
  'ps': 'Pushto; Pashto',
  'qu': 'Quechua',
  'rm': 'Romansh',
  'ro': 'Romanian',
  'rn': 'Rundi',
  'ru': 'Russian',
  'sg': 'Sango',
  'sa': 'Sanskrit',
  'si': 'Sinhala; Sinhalese',
  'sk': 'Slovak',
  'sl': 'Slovenian',
  'se': 'Northern Sami',
  'sm': 'Samoan',
  'sn': 'Shona',
  'sd': 'Sindhi',
  'so': 'Somali',
  'st': 'Sotho, Southern',
  'es': 'Spanish; Castilian',
  'sc': 'Sardinian',
  'sr': 'Serbian',
  'ss': 'Swati',
  'su': 'Sundanese',
  'sw': 'Swahili',
  'sv': 'Swedish',
  'ty': 'Tahitian',
  'ta': 'Tamil',
  'tt': 'Tatar',
  'te': 'Telugu',
  'tg': 'Tajik',
  'tl': 'Tagalog',
  'th': 'Thai',
  'bo': 'Tibetan',
  'ti': 'Tigrinya',
  'to': 'Tonga (Tonga Islands)',
  'tn': 'Tswana',
  'ts': 'Tsonga',
  'tk': 'Turkmen',
  'tr': 'Turkish',
  'tw': 'Twi',
  'ug': 'Uighur; Uyghur',
  'uk': 'Ukrainian',
  'ur': 'Urdu',
  'uz': 'Uzbek',
  've': 'Venda',
  'vi': 'Vietnamese',
  'vo': 'Volapük',
  'cy': 'Welsh',
  'wa': 'Walloon',
  'wo': 'Wolof',
  'xh': 'Xhosa',
  'yi': 'Yiddish',
  'yo': 'Yoruba',
  'za': 'Zhuang; Chuang',
  'zu': 'Zulu',
};
