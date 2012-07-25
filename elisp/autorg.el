;; Jaromil's emacs configuration
;; http://jaromil.dyne.org
;; GNU GPLv3 (FWIW)

(provide 'autorg)

;; local emacs extensions
(add-to-list 'load-path "~/.emacs.d")


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

; load color-themes extension
(require 'color-theme)
(color-theme-initialize)
(color-theme-gray30)
; (color-theme-matrix)
; (color-theme-blippblopp)
; (color-theme-dark-laptop)

; transparency (thanks dreamer!)
(set-frame-parameter (selected-frame) 'alpha '(90 50))
(add-to-list 'default-frame-alist '(alpha 90 50))

; start listening to commandline invokations
(server-start)

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
 '(browse-url-firefox-program "open")
 '(column-number-mode t)
 '(keyboard-coding-system (quote mule-utf-8))
 '(line-number-mode t)
 '(nil nil t)
; '(get-frame-for-buffer-default-instance-limit nil)

 '(pc-select-meta-moves-sexps t)
 '(pc-select-selection-keys-only t)
 '(pc-selection-mode t nil (pc-select))

 '(word-count-non-character-regexp "[
]")
 '(x-select-enable-clipboard t))
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


; IDO lets you  open files  and  switch buffers  with fuzzy  matching,
; really nice when you have lots of things open.
; http://www.emacsblog.org/2008/05/19/giving-ido-mode-a-second-chance/
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; set our favourite: Anonymous!
(set-face-font
'default "-*-Inconsolata-normal-normal-normal-*-16-*-*-*-*-*-*")

; folding mode
(require 'folding)

