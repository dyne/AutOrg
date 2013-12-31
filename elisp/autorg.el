;; Jaromil's emacs configuration
;; http://jaromil.dyne.org
;; GNU GPLv3 (FWIW)

(provide 'autorg)

; load generic keymaps
(require 'keymap)

; remember extension
(require 'remember)

; markdown
(require 'markdown)

; flyspell extension
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)

; aspell dictionary list
; (require 'dictionaries)

; grammar parser
; (require 'grammar)

; frame zooming
(require 'zoom-frm)
(global-set-key (if (boundp 'mouse-wheel-down-event) ; Emacs 22+
		    (vector (list 'control mouse-wheel-down-event))
		  [C-mouse-wheel])    ; Emacs 20, 21
		'zoom-in)
(when (boundp 'mouse-wheel-up-event) ; Emacs 22+
  (global-set-key (vector (list 'control mouse-wheel-up-event))
		  'zoom-out))

; load org-mode first
'(org-modules (quote (org-bbdb org-bibtex org-gnus org-info
org-jsinfo org-irc org-w3m org-mouse org-eval org-eval-light
org-exp-bibtex org-man org-mtags org-panel org-R
org-special-blocks org-exp-blocks org-mobile org-odt org2blog
org-crypt org-remember org-agenda org-export org-beamer)))
(require 'org)
(org-remember-insinuate)

;; export options
'(org-export-html-inline-images t)
'(org-export-html-use-infojs t)
'(org-export-html-with-timestamp t)
'(org-export-html-validation-link
  "<p class=\"xhtml-validation\"><a href=\"http://validator.w3.org/check?uri=referer\">Validate XHTML 1.0</a></p>")

;; extra export formats
; (require 'org-export-generic)
'(org-export-blocks (quote ((comment org-export-blocks-format-comment t)
			    (ditaa org-export-blocks-format-ditaa t)
			    (dot org-export-blocks-format-dot t)
			    (r org-export-blocks-format-R nil)
			    (R org-export-blocks-format-R nil))))

;; use texi2dvi to process with bibtex and makeindex
(setq org-latex-to-pdf-process '("texi2dvi --pdf --clean --verbose --batch %f"))

;; org protocol helps setting communications outside of Emacs
; (require 'org-protocol)

;; Ebib bibliografy manager
(require 'ebib)
(org-add-link-type "ebib" 'ebib)
; (require 'natbib)

;; freemind export
(require 'freemind)

; Encryption
(require 'epa)
(require 'epa-file)
(epa-file-enable)
(setq epa-armor t) ; armor in ascii for mobile-org compat
(add-to-list 'auto-mode-alist '("\\(\\.gpg\\|\\.asc\\)\\(~\\|\\.~[0-9]+~\\)?\\'" nil epa-file))
;; (require 'pgg)
(require 'org-crypt)
(org-crypt-use-before-save-magic)

; password generation
(require 'pwgen)

; default tramp config
(require 'tramp)
(setq tramp-default-method "ssh2")
(setq tramp-auto-save-directory "~/.emacs-backups")

; word count mode
(require 'word-count)

; figlet ascii art
(require 'figlet)

; enables semantic mode
; (semantic-mode t)
;

; load HTML, PHP and related variou syntax support
; (load (concat AutOrgRes "/nxhtml/autostart.el"))

; LUA mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; deactivate all menubar scrollbar toolbar
; (tool-bar-mode)
; (menu-bar-mode)
; (scroll-bar-mode)

;; activate smart switching between buffers
(iswitchb-mode t)

; stop forcing me to spell out "yes"
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)


; stop leaving backup~ turds scattered everywhere
(setq make-backup-files nil)

; save on exit
(defadvice save-buffers-kill-emacs (around no-y-or-n activate)
  (flet ((yes-or-no-p (&rest args) t)
	 (y-or-n-p (&rest args) t))
    ad-do-it))


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(browse-url-firefox-program "open")
 '(column-number-mode t)
 '(epa-file-name-regexp "\\(\\.gpg\\|\\.asc\\)\\(~\\|\\.~[0-9]+~\\)?\\'")
 '(keyboard-coding-system (quote mule-utf-8))
 '(line-number-mode t)
 '(nil nil t)
; '(get-frame-for-buffer-default-instance-limit nil)

; '(pc-select-meta-moves-sexps t)
; '(pc-select-selection-keys-only t)
; '(pc-selection-mode t nil (pc-select))

 '(word-count-non-character-regexp "[
]")
 '(x-select-enable-clipboard t)

 ; creator tag in exported
 (custom-set-variables
  '(org-export-latex-hyperref-options-format "\\hypersetup{
  pdfkeywords={%s},
  pdfsubject={%s},
  pdfcreator={AutOrg (org-mode %s) <http://autorg.dyne.org>}}
"))
)

;; X selection manipulation
(define-key global-map [(delete)]    "\C-d")
(defun x-own-selection (s) (x-set-selection `PRIMARY s))
(global-set-key [(shift insert)]
		'(lambda () (interactive)
		   (insert (x-get-selection))))
(global-set-key [(control insert)]
		'(lambda () (interactive)
		   (x-own-selection (buffer-substring (point) (mark)))))


; enables deleting an highlighted block
(delete-selection-mode)


;; By default we starting in text mode.
(setq initial-major-mode
      (lambda ()
	(text-mode)
	(turn-on-auto-fill)
	(setq transient-mark-mode t)
	(global-font-lock-mode t)
	(setq font-lock-mode-maximum-decoration t)
	))

(setq revert-without-query (cons "TAGS" revert-without-query))

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


; internationalisation support
(require 'mule)
(prefer-coding-system 'mule-utf-8)
(setq locale-coding-system 'mule-utf-8)
(set-terminal-coding-system 'mule-utf-8)
(set-keyboard-coding-system 'mule-utf-8)
(set-selection-coding-system 'mule-utf-8)

; Some new Colors for Font-lock.
(require 'font-lock)
(setq font-lock-use-default-fonts nil)
(setq font-lock-use-default-colors nil)

;; More information with the info file (Control-h i)

; mouse wheel functionality
(require 'custom)
(require 'cl)
(require 'mwheel)
; Make the mouse jump away when you type over it.
(mouse-avoidance-mode 'cat-and-mouse)
;; scroll one line at a time (less "jumpy" than defaults)
    (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
;    (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
    (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
    (setq scroll-step 1) ;; keyboard scroll one line at a time

; IDO lets you  open files  and  switch buffers  with fuzzy  matching,
; really nice when you have lots of things open.
; http://www.emacsblog.org/2008/05/19/giving-ido-mode-a-second-chance/
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

; folding mode
(require 'folding)
; (folding-mode-add-find-file-hook)
(global-set-key [backtab] 'folding-toggle-show-hide)
(global-set-key [(hyper -)] 'folding-toggle-show-hide)
;; (put 'narrow-to-defun 'disabled nil)
;; (put 'narrow-to-page 'disabled nil)
;; (put 'narrow-to-region 'disabled nil)


;;;; appearance

; load color-themes extension
(require 'color-theme)
(color-theme-initialize)
(color-theme-classic)


(defun justify-toggle-block ()
  "Remove or add line ending chars on current paragraph.
This command is similar to a toggle of `fill-paragraph'.
When there is a text selection, act on the region."
  (interactive)

  ;; This command symbol has a property “'stateIsCompact-p”.
  (let (currentStateIsCompact (bigFillColumnVal 90002000) (deactivate-mark nil))
    ;; 90002000 is just random. you can use `most-positive-fixnum'

    (save-excursion
      ;; Determine whether the text is currently compact.
      (setq currentStateIsCompact
            (if (eq last-command this-command)
                (get this-command 'stateIsCompact-p)
              (if (> (- (line-end-position) (line-beginning-position)) fill-column) t nil) ) )

      (if (region-active-p)
          (if currentStateIsCompact
              (fill-region (region-beginning) (region-end))
            (let ((fill-column bigFillColumnVal))
              (fill-region (region-beginning) (region-end))) )
        (if currentStateIsCompact
            (fill-paragraph nil)
          (let ((fill-column bigFillColumnVal))
            (fill-paragraph nil)) ) )

      (put this-command 'stateIsCompact-p (if currentStateIsCompact nil t)) ) ) )


; transparency not working anymore
; (set-frame-parameter (selected-frame) 'alpha '(95 50))
; (add-to-list 'default-frame-alist '(alpha 95 50))

; start listening to commandline invokations
(server-start)
