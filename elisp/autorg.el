;; Jaromil's emacs configuration
;; http://jaromil.dyne.org
;; GNU GPLv3 (FWIW)

(provide 'autorg)

; load generic keymaps
(require 'keymap)

; remember extension
(require 'remember)

; flyspell extension
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)

; aspell dictionary list
; (require 'dictionaries)

; grammar parser
(require 'grammar)

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
(add-to-list 'load-path (concat AutOrgRes "/org-mode/lisp"))
(add-to-list 'load-path (concat AutOrgRes "/org-mode/contrib/lisp"))
'(org-modules (quote (org-bbdb org-bibtex org-gnus org-info
org-jsinfo org-irc org-w3m org-mouse org-eval org-eval-light
org-exp-bibtex org-man org-mtags org-panel org-R
org-special-blocks org-exp-blocks org-mobile org-odt org2blog
org-crypt org-remember org-agenda)))
(require 'org)
(org-remember-insinuate)

;; export options
'(org-export-html-inline-images t)
'(org-export-html-use-infojs t)
'(org-export-html-with-timestamp t)
'(org-export-html-validation-link
  "<p class=\"xhtml-validation\"><a href=\"http://validator.w3.org/check?uri=referer\">Validate XHTML 1.0</a></p>")

;; extra export formats
(require 'org-export-generic)
'(org-export-blocks (quote ((comment org-export-blocks-format-comment t)
			    (ditaa org-export-blocks-format-ditaa t)
			    (dot org-export-blocks-format-dot t)
			    (r org-export-blocks-format-R nil)
			    (R org-export-blocks-format-R nil))))

;; org protocol helps setting communications outside of Emacs
(require 'org-protocol)

;; freemind export
(require 'freemind)

; Encryption
(require 'pgg)
(require 'org-crypt)
(org-crypt-use-before-save-magic)

; enables semantic mode for completion
(semantic-mode t)

; load HTML, PHP and related variou syntax support
(load (concat AutOrgRes "/nxhtml/autostart.el"))

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


;  ===========================
;; setup our keyboard mappings

;; cursor movement a la vim
(global-set-key (kbd "M-h") 'backward-char) ; was indent-new-comment-line
(global-set-key (kbd "M-l") 'forward-char)  ; was downcase-word
(global-set-key (kbd "M-k") 'previous-line) ; was tab-to-tab-stop
(global-set-key (kbd "M-j") 'next-line) ; was kill-sentence

(global-set-key (kbd "M-SPC") 'set-mark-command) ; was just-one-space

;; less painfull window switching
(global-set-key (kbd "C-o") 'other-window)
;; faster file open
(global-set-key (kbd "C-f") 'find-file)

(global-set-key [(meta g)] `goto-line)
(defun switch-to-other-buffer () (interactive) (switch-to-buffer (other-buffer)))
(global-set-key [(meta control ?l)] `switch-to-other-buffer)
					; (global-set-key [(control tab)] `other-window)
(global-set-key [(meta O) ?H] 'beginning-of-line)
(global-set-key [home] 'beginning-of-line)
(global-set-key [(meta O) ?F] 'end-of-line)
(global-set-key [end] 'end-of-line)
(setq next-line-add-newlines nil)
; C-c c to either comment out a region or uncomment it depending on context.
(global-set-key (kbd "C-c c") 'comment-dwim)
; Shift-arrows a la windows...



(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ispell-library-directory (concat AutOrgRes "/dict"))
 '(browse-url-firefox-program "open")
 '(column-number-mode t)
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
; M-g to go to specified line in buffer.
; Useful for emacs 21.x users where the keybinding is not yet standard.
(global-set-key (kbd "\M-g") 'goto-line)
; remap ctrl-z to undo (common behaviour)
(global-set-key (kbd "\C-z") 'undo)
; remap ctrl-x ctrl-m to ESC-x (alt-x)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-xm" 'execute-extended-command)
(global-set-key "\C-cm" 'execute-extended-command)
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

; appearance

; load color-themes extension
(require 'color-theme)
(color-theme-initialize)
(color-theme-classic)
; (color-theme-gray30)
; (color-theme-matrix)
; (color-theme-blippblopp)
; (color-theme-dark-laptop)

;; set our favourite: Anonymous!
(set-face-font
'default "-*-Anonymous-normal-normal-normal-*-13-*-*-*-*-*-*")

; transparency (thanks dreamer!)
(set-frame-parameter (selected-frame) 'alpha '(95 50))
(add-to-list 'default-frame-alist '(alpha 95 50))



; start listening to commandline invokations
(server-start)
