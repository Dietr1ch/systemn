{
  config,
  pkgs,
  lib,
  ...
}:

let
  systemLocales = with config.i18n; [ defaultLocale ] ++ extraLocales;

  localeDictionaryMap = with pkgs.hunspellDicts; {
    "C" = en_US-large;

    "cs_CZ" = cs_CZ;
    "cy_GB" = cy_GB;
    "da_DK" = da_DK;
    "de_AT" = de_AT;
    "de_CH" = de_CH;
    "de_DE" = de_DE;
    "el_GR" = el_GR;
    "en_AU" = en_AU-large;
    "en_CA" = en_CA-large;
    "en_GB" = en_GB-large;
    "en_US" = en_US-large;
    "es_ANY" = es_ANY;
    "es_AR" = es_AR;
    "es_BO" = es_BO;
    "es_CL" = es_CL;
    "es_CO" = es_CO;
    "es_CR" = es_CR;
    "es_CU" = es_CU;
    "es_DO" = es_DO;
    "es_EC" = es_EC;
    "es_ES" = es_ES;
    "es_GT" = es_GT;
    "es_HN" = es_HN;
    "es_MX" = es_MX;
    "es_NI" = es_NI;
    "es_PA" = es_PA;
    "es_PE" = es_PE;
    "es_PR" = es_PR;
    "es_PY" = es_PY;
    "es_SV" = es_SV;
    "es_UY" = es_UY;
    "es_VE" = es_VE;
    "et_EE" = et_EE;
    "eu_ES" = eu_ES;
    "fa_IR" = fa_IR;
    "fr_FR" = fr-moderne; # fr-classique | fr-reforme1990 | fr-any
    "he_IL" = he_IL;
    "hr_HR" = hr_HR;
    "hu_HU" = hu_HU;
    "id_ID" = id_ID;
    "id_id" = id_id;
    "it_IT" = it_IT;
    "ko_KR" = ko_KR;
    "nb_NO" = nb_NO;
    "nl_NL" = nl_NL;
    "nl_nl" = nl_nl;
    "nn_NO" = nn_NO;
    "pl_PL" = pl_PL;
    "pt_BR" = pt_BR;
    "pt_PT" = pt_PT;
    "ro_RO" = ro_RO;
    "ru_RU" = ru_RU; # ru_RU-mozilla;
    "sk_SK" = sk_SK;
    "sv_FI" = sv_FI;
    "sv_SE" = sv_SE;
    "th_TH" = th_TH;
    "tr_TR" = tr_TR;
    "uk_UA" = uk_UA;
    "uz_UZ" = uz_UZ;
  };

  dictionaries = lib.unique (
    lib.concatMap (
      locale:
      let
        language = builtins.head (lib.splitString "." locale);
      in
      lib.optional (builtins.hasAttr language localeDictionaryMap) localeDictionaryMap.${language}
    ) systemLocales
  );
in
{
  # Mirrors ~/Projects/nixland/desktop/spelling.nix
  environment = {
    sessionVariables = {
      DICPATH = lib.mkDefault "${pkgs.hunspell}/bin/hunspell";
    };

    systemPackages =
      with pkgs;
      [
        ispell

        hunspell

        harper
      ]
      ++ dictionaries;
  }; # ..environment
}
