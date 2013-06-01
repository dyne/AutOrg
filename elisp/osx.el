; Apple/OSX friendly setup
; from http://autorg.dyne.org

(provide 'osx)

(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'hyper)

(setq initial-scratch-message 
";; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to open a file or create a new one, use cmd-o or the File menu.
;; If you are new to AutOrg and Emacs, press cmd-h to get some help.
")

(global-set-key [(hyper h)] 'help)

; remove toolbar
(ns-toggle-toolbar)

; scrolling
(global-set-key [(hyper up)] 'backward-paragraph)
(global-set-key [(hyper down)] 'forward-paragraph)
(global-set-key [(meta  up)] 'backward-page)
(global-set-key [(meta  down)] 'forward-page)
(defun sfp-page-down ()
  (interactive)
  (next-line
   (- (window-text-height)
      next-screen-context-lines)))
(defun sfp-page-up ()
  (interactive)
  (previous-line
   (- (window-text-height)
      next-screen-context-lines)))
(global-set-key [next] 'sfp-page-down)
(global-set-key [prior] 'sfp-page-up)

; switching windows
(global-set-key [(hyper \`)] 'other-window)
(global-set-key [(hyper \])] 'other-window)
(global-set-key [(hyper \[)] 'other-window)

; switch buffer
(global-set-key [(hyper backspace)] 'ido-switch-buffer)
(global-set-key [(hyper =)] 'ido-switch-buffer)


(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper v)] 'yank)

(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper x)] 'kill-region)
(global-set-key [(hyper k)] 'kill-buffer)

(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper l)] 'goto-line)
(global-set-key [(hyper o)] 'ns-open-file-using-panel)
(global-set-key [(hyper f)] 'isearch-forward)
(global-set-key [(hyper g)] 'isearch-repeat-forward)
(global-set-key [(hyper w)]
                (lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key [(hyper .)] 'keyboard-quit)
;; I disabled this since I want to avoid hitting Cmd-q accidentally.
; (global-set-key [(hyper q)] 'save-buffers-kill-emacs)
; (require 'redo)
(global-set-key [(hyper z)] 'undo)
(global-set-key [(hyper shift z)] 'redo)

; compat with old-school emacs behaviour and swap of hyper - alt
(global-set-key [(hyper w)] 'kill-ring-save)
(global-set-key (kbd "C-w") 'kill-region)

(global-set-key [(hyper y)] 'yank)
(global-set-key [(hyper /)] 'complete-symbol)
(global-set-key [(hyper \\)] 'complete-symbol)

(require 'maxframe)
(defvar my-fullscreen-p t "Check if fullscreen is on or off")

(defun my-toggle-fullscreen ()
  (interactive)
  (setq my-fullscreen-p (not my-fullscreen-p))
  (if my-fullscreen-p
	  (restore-frame)
	(maximize-frame)))

(global-set-key [(hyper return)] 'my-toggle-fullscreen)
(global-set-key [(hyper m)] 'my-toggle-fullscreen)

; save as with cocoa dialog
(global-set-key [(hyper shift s)] 'ns-write-file-using-panel)

; print
(global-set-key [(hyper p)] 'ns-print-buffer)

