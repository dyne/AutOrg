;; autorg key mappping
(provide 'keymap)

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


;; sloppy goto line with both command and alt
(global-set-key [(meta g)] `goto-line)
(global-set-key (kbd "s-g") `goto-line)

;;;;;;;;;;;;;;;
; switch buffer
(global-set-key (kbd "s-=") 'ido-switch-buffer)
(global-set-key (kbd "s-`") 'next-multiframe-window)




;;;;;;;;;;;
; scrolling
(global-set-key (kbd "s-<up>") 'backward-paragraph)
(global-set-key (kbd "s-<down>") 'forward-paragraph)
(global-set-key (kbd "M-<up>") 'backward-page)
(global-set-key (kbd "M-<down>") 'forward-page)

;;;;;;;;;;;;;
; cut & paste
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-y") 'yank-pop)
; sloppy hyper - alt swap
(global-set-key (kbd "s-w") 'kill-ring-save)


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

;;;;;;;;;;;;
; completion

(global-set-key (kbd "M-/") 'complete-symbol)
(global-set-key (kbd "s-/") 'complete-symbol)
(global-set-key (kbd "M-\\") 'complete-symbol)
(global-set-key (kbd "s-\\") 'complete-symbol)


(defun switch-to-other-buffer () (interactive) (switch-to-buffer (other-buffer)))
(global-set-key [(meta control ?l)] `switch-to-other-buffer)
		; (global-set-key [(control tab)] `other-window)
(global-set-key [(meta O) ?H] 'beginning-of-line)
(global-set-key [home] 'beginning-of-line)
(global-set-key [(meta O) ?F] 'end-of-line)
(global-set-key [end] 'end-of-line)
(setq next-line-add-newlines nil)
; C-c c to either comment out a region or uncomment it depending on
; context.
(global-set-key (kbd "C-c c") 'comment-dwim)


; justify paragraph keys
(global-set-key (kbd "M-q") 'justify-toggle-block)
(global-set-key (kbd "C-j") 'justify-toggle-block)

