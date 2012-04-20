; Apple/OSX friendly setup
; courtesy of Ovidiu Predescu
; http://www.webweavertech.com/ovidiu/emacs.html

(provide 'osx)


(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'hyper)

(global-set-key (kbd "A-q") 'fill-paragraph)

(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper v)] 'yank)
(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper x)] 'kill-region)
(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper l)] 'goto-line)
(global-set-key [(hyper o)] 'find-file)
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
