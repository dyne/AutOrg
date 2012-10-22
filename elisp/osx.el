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

; justify paragraph keys
(global-set-key (kbd "A-q") 'fill-paragraph)
(global-set-key (kbd "C-j") 'fill-paragraph)

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



(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper v)] 'yank)
(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper x)] 'kill-region)
(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper l)] 'goto-line)
(global-set-key [(hyper o)] 'ns-open-file-using-panel)
(global-set-key [(hyper f)] 'isearch-forward)
(global-set-key [(hyper g)] 'isearch-repeat-forward)
(global-set-key [(hyper w)]
                (lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key [(hyper .)] 'keyboard-quit)
;; I disabled this since I want to avoid hitting Cmd-q accidentally.
(global-set-key [(hyper q)] 'save-buffers-kill-emacs)
;; I disabled this since I want to avoid hitting Cmd-q accidentally.
(global-set-key [(hyper q)] 'save-buffers-kill-emacs)
; (require 'redo)
(global-set-key [(hyper z)] 'undo)
(global-set-key [(hyper shift z)] 'redo)

; compat with old-school emacs behaviour and swap of hyper - alt
(global-set-key [(hyper w)] 'kill-ring-save)
(global-set-key (kbd "C-w") 'kill-region)
; if you are an hardcore osx user you might want to comment out the
; following:
(global-set-key [(hyper y)] 'yank)
(global-set-key [(hyper /)] 'complete-symbol)

(defun maximize-frame () 
  (interactive)
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 1000 1000))
(global-set-key [(hyper return)] 'maximize-frame)
(global-set-key [(hyper f)] 'maximize-frame)

; save as with cocoa dialog
; (defun ns-save-file-using-panel ()
;    (interactive)
;    (let ((file (do-applescript "try
;  POSIX path of (choose file name with prompt \"Save As...\")
;  end try")))
;      (if (> (length file) 3)
;          (setq file
; 	       (substring file 1 (- (length file) 1))
; 	       ))
;      (if (not (equal file ""))
;          (write-file file)
;        (beep))
;      ))
;; appeltje + S
; (global-set-key [(hyper s)] 'ns-save-file-using-panel)
