;; Jaromil's Emacs
;; list of autoloads

(provide 'autoload)

;; local emacs extensions
(add-to-list 'load-path "~/.emacs.d")

;; generic key settings
(require 'keymap)

;; word count
(autoload 'word-count-mode "word-count"
          "Minor mode to count words." t nil)

; use antiword on doc files
(autoload 'no-word "no-word" "word to txt")
(add-to-list 'auto-mode-alist '("\\.doc\\'" . no-word))
; requires antiword and the no-doc.el extension
; http://www.emacswiki.org/emacs/AntiWord

;; make hypertexts in any document
(defun load-linkd () (interactive)
  "internal linking to browse any major mode"
  (require 'linkd)
  (linkd-mode)
  )

; grep directories
(defun grep-on-the-fly ()
  "grep the whole directory for something defaults to term at cursor position"
  (interactive)
  (setq default (thing-at-point 'symbol))
  (setq needle (or (read-string (concat "grep for <" default "> ")) default))
  (setq needle (if (equal needle "") default needle))
  (grep (concat "egrep -s -i -n " needle " * /dev/null")))
(global-set-key "\C-x." 'grep-on-the-fly)
(global-set-key [f8] 'next-error)

; fullscreen
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil
                                           'fullscreen) nil
                                           'fullboth)))
(global-set-key [(meta return)] 'toggle-fullscreen)

;;; E-Mail
(defun load-email () (interactive)
  "load some e-mail mode extensions when answering emails"
  (mail-mode)  )
(add-to-list 'auto-mode-alist '("mutt" . load-email) )
(autoload 'turn-on-tinyprocmail-mode  "tinyprocmail" "" t)
(autoload 'turn-off-tinyprocmail-mode "tinyprocmail" "" t)
(autoload 'tinyprocmail-mode          "tinyprocmail" "" t)
(add-hook 'tinyprocmail-:load-hook 'tinyprocmail-install)
;;  Procmail files usually end to suffix "*.rc", like file-name.rc
;;  Some older procmail files start with "rc.*", like rc.file-name
(autoload 'aput "assoc")
(aput 'auto-mode-alist
      "\\.\\(procmail\\)?rc$"
      'turn-on-tinyprocmail-mode)


;;; Encryption
; (require 'pgg)
; (require 'org-crypt)
; (org-crypt-use-before-save-magic)


;;; NXHTML
(require 'nxhtml-autostart)

;;; DOT mode
(defun load-graphviz () (interactive)
  "load Graphviz DOT language helpers for graph creation"
  (require 'graphviz-dot-mode)
  (graphviz-dot-mode) )

;;; MUSE
;; (require 'muse)
(defun load-muse ()  (interactive)
  "load MUSE extension for many online publishing functionalities"
  (require 'muse-jaromil)
  (setq debug-on-error t)
  (muse-mode)
  )
(add-to-list 'auto-mode-alist '("\\.muse\\'" . load-muse) )

;;; HTMLize sourcecode
(defun load-html ()  (interactive)
  "load htmlize to transform code into html for online web publishing"
;;  (require 'htmlize)
  (require 'css-mode)
  (require 'htmlfontify)
;  (add-to-list 'load-path "~/jrml/conf/emacs/elisp/nxhtml")
;  (add-to-list 'load-path "~/jrml/conf/emacs/elisp/nxhtml/etc/schema")
  (require 'nxhtml-autostart)
  )

;; LUA mode
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)


;; word count
(autoload 'word-count-mode "word-count"
          "Minor mode to count words." t nil)

;;; TPP mode
(autoload 'tpp-mode "tpp-mode" "TPP mode." t)
(add-to-list 'auto-mode-alist '("\\.tpp$" . tpp-mode) )


;;; weblogger mode
(defun load-webedit ()  (interactive)
  "load weblogger xmlrpc editing of websites: webloggers and mediawiki"
  (require 'weblogger)
  (require 'mediawiki)

  )

;; make hypertexts in any document
(defun load-linkd () (interactive)
  "internal linking to browse any major mode"
  (require 'linkd)
  (linkd-mode)
  )


;; Pastebin extension
(defun pastebin-region ()
  (interactive)
  "load pastebin extension and executes a pastebin for selected region"
  (require 'pastebin)
  (pastebin)
)

;; moinmoin
(require 'moinmoin)

;; folding minor mode
(require 'folding)

;;;; EOF
