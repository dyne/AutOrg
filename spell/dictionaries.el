;;; This file is part of the dictionaries-common package.
;; taken from Debian autogenerated dictionary list for emacs
;; /var/cache/dictionaries-common/emacsen-ispell-dicts.el

;; Adding aspell dicts

(require 'ispell)
(provide 'dictionaries)

(custom-set-variables
 '(ispell-dictionary-alist
   (quote
  (("nederlands8"
    "[A-Za-z\300\301\302\303\304\305\307\310\311\312\313\314\315\316\317\322\323\324\325\326\331\332\333\334\340\341\342\343\344\345\347\350\351\352\353\354\355\356\357\361\362\363\364\365\366\371\372\373\374]"
    "[^A-Za-z\300\301\302\303\304\305\307\310\311\312\313\314\315\316\317\322\323\324\325\326\331\332\333\334\340\341\342\343\344\345\347\350\351\352\353\354\355\356\357\361\362\363\364\365\366\371\372\373\374]"
    "[']"
    t
    ("-C" "-d" "dutch")
    nil
    iso-8859-1)
   ("italian"
    "[a-zA-Z]"
    "[^a-zA-Z]"
    "[']"
    nil
    ("-d" "it")
    nil
    iso-8859-1)
   ("francais-sml"
    "[A-Za-z��������������������������]"
    "[^A-Za-z��������������������������]"
    "[-']"
    t
    ("-d" "fr_FR-sml")
    "~list"
    iso-8859-1)
   ("francais-lrg"
    "[A-Za-z��������������������������]"
    "[^A-Za-z��������������������������]"
    "[-']"
    t
    ("-d" "fr_FR-lrg")
    "~list"
    iso-8859-1)
   ("francais-ch"
     "[A-Za-z��������������������������]"
     "[^A-Za-z��������������������������]"
     "[-']"
     t
     ("-d" "fr_CH-60")
     "~list"
     iso-8859-1)
   ("francais"
     "[A-Za-z��������������������������]"
     "[^A-Za-z��������������������������]"
     "[-']"
     t
     ("-d" "francais")
     "~list"
     iso-8859-1)
   ("english"
     "[a-zA-Z]"
     "[^a-zA-Z]"
     "[']"
     nil
     ("-d" "en")
     nil
     iso-8859-1)
   ("de_DE"
    "[A-Za-z�������]"
    "[^A-Za-z�������]"
    "[']"
    nil
    ("-d" "de_DE")
    nil
    iso-8859-1)
   ("de_CH"
     "[A-Za-z�������]"
     "[^A-Za-z�������]"
     "[']"
     nil
     ("-d" "de_CH")
     nil
     iso-8859-1)
   ("de_AT"
     "[A-Za-z�������]"
     "[^A-Za-z�������]"
     "[']"
     nil
     ("-d" "de_AT")
     nil
     iso-8859-1)
   ("de"
    "[A-Za-z�������]"
    "[^A-Za-z�������]"
    "[']"
    nil
    ("-d" "de")
    nil
    iso-8859-1)
   ("catala8"
     "[A-Z����������������a-z����������������]"
     "[^A-Z����������������a-z����������������]"
     "[---'.�]"
     t
     ("-B" "-d" "catala")
     "~list"
     iso-8859-1)
   ("castellano8"
    "[a-z\340\341\350\351\354\355\362\363\371\372\374\347\361A-Z\300\301\310\311\314\315\322\323\331\332\334\307\321]"
    "[^a-z\340\341\350\351\354\355\362\363\371\372\374\347\361A-Z\300\301\310\311\314\315\322\323\331\332\334\307\321]"
    "[']"
    nil
    ("-B" "-d" "castellano")
    "~latin1"
    iso-8859-1)
   ("canadian"
    "[a-zA-Z]"
    "[^a-zA-Z]"
    "[']"
    nil
    ("-d" "en_CA")
    nil
    iso-8859-1)
   '("british"
     "[a-zA-Z]"
     "[^a-zA-Z]"
     "[']"
     nil
     ("-d" "en_GB")
     nil
     iso-8859-1)
   ("american"
    "[a-zA-Z]"
    "[^a-zA-Z]"
    "[']"
    nil
    ("-d" "en_US")
    nil
    iso-8859-1)
   )))
)