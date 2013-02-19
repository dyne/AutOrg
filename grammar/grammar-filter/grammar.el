;;; grammar.el --- Grammar checker for Emacs
;;
;; Copyright (C) 2010 Baoqiu Cui
;;
;; Filename: grammar.el
;; Author: Baoqiu Cui <cbaoqiu AT yahoo DOT com>
;; Maintainer: Baoqiu Cui <cbaoqiu AT yahoo DOT com>
;; Keywords: grammar spell
;; Description: Perform grammar checking in Emacs buffers
;;
;; $Id: grammar.el,v 1.12 2010/06/14 06:00:06 bcui Exp $
;;
;; This file is NOT part of GNU Emacs.
;;
;; grammar.el is free software: you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;; 
;; This file is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; A copy of the GNU General Public License can be made from
;; <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Grammar is a minor Emacs mode that performs semi-on-the-fly grammar
;; checking using Link Grammar (http://www.link.cs.cmu.edu/link/).  A
;; separate Link Grammar client, grammar.cc (included in this package),
;; is required in order to make this mode work.
;;
;; To enable Grammar minor mode, type M-x grammar-mode.  This applies
;; only to the current buffer.  Command grammar-mode toggles Grammar
;; mode in the current buffer.
;;

(defgroup grammar nil
  "Grammar checking on the fly."
  :tag "Grammar"
  :group 'processes)
  
(defcustom grammar-mode-line-string " Grammar"
  "String displayed on the modeline when grammar is active.
Set this to nil if you don't want a modeline indicator."
  :group 'grammar
  :type '(choice string (const :tag "None" nil)))

(defcustom grammar-program-name "grammar"
  "Program invoked by Grammar mode.
Make sure this program can be located in your environment."
  :type 'string
  :group 'grammar)

(defcustom grammar-delay 3
  "The number of seconds to wait before checking, after a \"delayed\" command."
  :type 'number
  :group 'grammar)

(defcustom grammar-default-delayed-commands
  '(self-insert-command
    delete-backward-char
    backward-or-forward-delete-char
    delete-char
    scrollbar-vertical-drag
    backward-delete-char-untabify)
  "The standard list of delayed commands for Grammar.
See `grammar-delayed-commands'."
  :type '(repeat (symbol))
  :group 'grammar)

(defcustom grammar-delayed-commands nil
  "List of commands that are \"delayed\" for Grammar mode.
After these commands, grammar checking is delayed for a short time,
whose length is specified by `grammar-delay'."
  :type '(repeat (symbol))
  :group 'grammar)

(defface grammar-error-face
  '((((class color)) :underline "darkgreen")
    (t :underline t))
  "Face for highlighting grammar errors."
  :group 'grammar)

(defvar grammar-process nil
  "The process object for Grammar.")

(defvar grammar-filter nil
  "Output filter from piped calls to Grammar.")

(defvar grammar-filter-continue nil
  "Control variable for Ispell filter function.")

(defun grammar-start-process ()
  "Start the grammar process."
  (apply 'start-process
	 "grammar" nil grammar-program-name nil))

(defun grammar-accept-output (&optional timeout-secs timeout-msecs)
  "Wait for output from grammar process, or TIMEOUT-SECS and TIMEOUT-MSECS."
  (accept-process-output grammar-process timeout-secs timeout-msecs))

;;; "grammar-filter" is a list of output lines from the generating
;;; function.  Each full line (ending with \n) is a separate item on the
;;; list.  "output" can contain multiple lines, part of a line, or both.
;;; "start" and "end" are used to keep bounds on lines when "output"
;;; contains multiple lines.  "ispell-filter-continue" is true when we
;;; have received only part of a line as output from a generating
;;; function ("output" did not end with \n).
;;;
;;; THIS FUNCTION WILL FAIL IF THE PROCESS OUTPUT DOESN'T END WITH \n!
;;; This is the case when a process dies or fails. The default behavior
;;; in this case treats the next input received as fresh input.

(defun grammar-filter (process output)
  "Output filter function for grammar."
  (let ((start 0)
	(continue t)
	end)
    (while continue
      ;; (message ">>> output = %s###" output)
      (setq end (string-match "\n" output start)) ; get text up to the newline.
      ;; If we get out of sync and ispell-filter-continue is asserted when we
      ;; are not continuing, treat the next item as a separate list.  When
      ;; ispell-filter-continue is asserted, ispell-filter *should* always be a
      ;; list!

      ;; Continue with same line (item)?
      (if (and grammar-filter-continue
	       grammar-filter
	       (listp grammar-filter))
	  ;; Yes.  Add it to the prev item
	  (setcar grammar-filter
		  (concat (car grammar-filter) (substring output start end)))
	;; No. This is a new line and item.
	(setq grammar-filter
	      (cons (substring output start end) grammar-filter)))
      (if (null end)
	  ;; We've completed reading the output, but didn't finish the line.
	  (setq grammar-filter-continue t
		continue nil)
	;; skip over newline, this line complete.
	(setq grammar-filter-continue nil
	      end (1+ end))
	(if (= end (length output))
	    ;; No more lines in output, so we can exit the filter.
	    (setq continue nil)	
	  (setq start end))))))

(defun grammar-kill-grammar (&optional no-error)
  "Kill current grammar process."
  (interactive)
  (if (not (and grammar-process
		(eq (process-status grammar-process) 'run)))
      (or no-error
	  (error "There is no grammar process running!"))
    (delete-process grammar-process)
    (setq grammar-process nil)
    (message "Grammar process killed")
    nil))	   

(defun grammar-init-process ()
  "Initialize the grammar process.
This function will (re)start the grammar process if necessary."
  (if (and grammar-process
	   (eq (process-status grammar-process) 'run))
      (setq grammar-filter nil))
  (grammar-kill-grammar t)
  (message "Starting new grammar process...")
  (sit-for 0)
  (setq grammar-process (grammar-start-process)
	grammar-filter nil
	grammar-filter-continue nil)
  (set-process-filter grammar-process 'grammar-filter)
  (grammar-accept-output 3)
  (if (null grammar-filter)
      ;; Get more output if filter is empty
      (grammar-accept-output 3))
  (cond ((null grammar-filter)
	 (error "%s did not output version line" grammar-program-name))
	(t
	 (message (car grammar-filter)))
	)
  (setq grammar-filter nil)
  (set-process-query-on-exit-flag grammar-process nil)
  )

(defun grammar-send-string (string)
  "Send string STRING to the Grammar process.
STRING should not contain any newline.  It will be appended with
a newline before being sent to the Grammar process."
  (process-send-string grammar-process (concat string "\n")))

(defun grammar-process-line (string)
  "Check the grammar of string STRING.
STRING is pre-processed before it is sent to the grammar process:
the newlines, and prefixes for ordered lists or itemized lists,
etc., are replaced with spaces.  As long as we keep the relative
positions of all really words intact, it is fine.

When finished, `grammar-process-line' always returns a list of
strings.  If there is no grammar errors in STRING, '(\"ok\") is
returned.  If grammar checker timeout happens, '(\"timeout\") is
returned.  Otherwise, a sequence of problematic words and their
positions in STRING is returned.

For example, if STRING is \"This person have two name.\", list
'(\"this\" \"0\" \"person\" \"5\" \"name\" \"21\") is returned."
  (let (word-pos-list word pos (start 0))
    ;;
    ;; Do some cleanups on the string.
    ;;
    ;; - Replace potential prefixes like "\n 5. " or "\n - " with
    ;;   spaces.  This prefix may exist if the current sentence is an
    ;;   item of an ordered list.
    ;;
    ;; - Replace newlines with spaces.
    ;;
    (if (string-match "\n *\\([0-9]+\.\\|-\\) " string)
	(setq string (replace-match
		      (make-string (length (match-string 0 string)) ? )
		      t t string)))
    (while (setq start (string-match "\n" string start))
      (setq string (replace-match " " t t string)))
    (grammar-send-string string)
    (with-local-quit
      (while (progn
	       (accept-process-output grammar-process)
	       ;; (if (not (string= "" (car grammar-filter)))
	       ;; 	   (message ">>>> Read again"))
	       (not (string= "" (car grammar-filter))))))
    (setq word-pos-list (split-string (cadr grammar-filter)))
    word-pos-list))

(defun grammar-make-overlay (from to face)
  "Highlight region from FROM to TO with face FACE."
  (let ((overlay (make-overlay from to)))
    (overlay-put overlay 'grammar-overlay t)
    (overlay-put overlay 'face face)))

(defun grammar-check ()
  "Check grammar of the sentence before or at the current point."
  (interactive)
  (let (start end sentence word-pos-list word pos)
    (save-excursion
      (backward-sentence)
      (setq start (point))
      (forward-sentence)
      (setq end (point)))
    (when (> end (+ start 10))
      (setq word-pos-list (grammar-process-line
			   (buffer-substring start end)))
      ;; Clear all overlays that may have grammar-error-face.
      (dolist (overlay (overlays-in start end))
	(when (eq (overlay-get overlay 'face) 'grammar-error-face)
	  (delete-overlay overlay)))    
      ;; If something is wrong with the grammar, word-pos-list should
      ;; contains N pairs of (word position).
      (if (= (length word-pos-list) 1)
	  (message "Grammar %s" (car word-pos-list))
	(message "Grammar error")
	(while word-pos-list
	  (setq word (car word-pos-list)
		pos (string-to-number (cadr word-pos-list))
		word-pos-list (cddr word-pos-list))
	  (grammar-make-overlay (+ start pos)
				(+ start pos (length word))
				'grammar-error-face)
	  )))))

(defun grammar-delay-commands ()
  "Install the standard set of Grammar delayed commands."
  (mapc 'grammar-delay-command grammar-default-delayed-commands)
  (mapcar 'grammar-delay-command grammar-delayed-commands))

(defun grammar-delay-command (command)
  "Set COMMAND to be delayed, for Grammar.
When grammar `post-command-hook' is invoked because a delayed command
as been used the current sentence is not immediately checked.
It will be checked only after `grammar-delay' seconds."
  (interactive "SDelay Grammar after Command: ")
  (put command 'grammar-delayed t))

(defvar grammar-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-\M-g" 'grammar-check)
    map)
  "Minor mode keymap for grammar mode--for the whole buffer.")

;;;###autoload
(define-minor-mode grammar-mode
  "Minor mode performing on-the-fly grammar checking."
  :lighter grammar-mode-line-string
  :keymap grammar-mode-map
  :group grammar
  (if grammar-mode
      (condition-case ()
	  (grammar-mode-on)
	(error (message "Enabling Grammar mode gave an error")
	       (grammar-mode -1)))
    (grammar-mode-off)))

;;;###autoload
(defun turn-on-grammar ()
  "Unconditionally turn on Grammar mode."
  (grammar-mode 1))

;;;###autoload
(defun turn-off-grammar ()
  "Unconditionally turn off Grammar mode."
  (grammar-mode -1))

(defun grammar-mode-on ()
  "Turn Grammar mode on.  Do not use this; use `grammar-mode' instead."
  (if (or (null grammar-process)
	  (not (eq (process-status grammar-process) 'run)))
      (grammar-init-process))
  ;; we put the `grammar-delayed' property on some commands
  (grammar-delay-commands)
  ;; we put the `grammar-deplacement' property on some commands
  ;(grammar-deplacement-commands)
  ;; we bound grammar action to post-command hook
  (add-hook 'post-command-hook (function grammar-post-command-hook) t t)
  ;; we bound grammar action to pre-command hook
  ;; (add-hook 'pre-command-hook (function grammar-pre-command-hook) t t)

  ;; the welcome message
  (message "Welcome to grammar."))

(defun grammar-delete-all-overlays ()
  "Delete all the overlays used by grammar."
  (remove-overlays (point-min) (point-max) 'grammar-overlay))

;;;###autoload
(defun grammar-mode-off ()
  "Turn Grammar mode off."
  ;; Remove the hooks
  (remove-hook 'post-command-hook (function grammar-post-command-hook) t)
  ;; (remove-hook 'pre-command-hook (function grammar-pre-command-hook) t)

  ;; Remove all the Grammar highlightings
  (grammar-delete-all-overlays)
  ;; Mark the mode as killed
  (setq grammar-mode nil))

(defun grammar-check-pre-sentence-p ()
  "Return non-nil if we should check the sentence before point."
  (let ((sentence-end (sentence-end)))
    (cond
     ;; After a space key: at least we should see two spaces before the
     ;; current point.
     ((and (or (eq this-command 'self-insert-command)
	       (eq this-command 'org-self-insert-command)
	       (eq this-command 'orgtbl-self-insert-command))
	   (eq (char-before (point)) ? )
	   (eq (char-before (1- (point))) ? )
	   (save-excursion
	     (re-search-backward sentence-end (- (point) 3) t)))
      t)
     ;; After a newline key
     ((and (or (eq this-command 'newline)
	       (eq this-command 'org-return)
	       (eq this-command 'orgtbl-hijacker-command-100))
	   (eq (char-before (point)) 10)
	   (not (eq (char-before (1- (point))) 10))
	   (save-excursion
	     (re-search-backward sentence-end (- (point) 3) t)))
      t)
     ;; After a tab key.
     ((and (or (eq this-command 'indent-for-tab-command)
	       (eq this-command 'orgtbl-hijacker-command-102))
	   (eq (char-syntax (char-before (point))) ? )
	   (save-excursion
	     (re-search-backward sentence-end (- (point) 3) t)))
      t)
     ((and (symbolp this-command)
	   (not executing-kbd-macro)
	   (or (get this-command 'grammar-delayed)))
      nil)
     ;; By default, do not check the sentence before point.
     (t
      nil)
     )))

(defun grammar-post-command-hook ()
  "The `post-command-hook' used by Grammar to check a sentence in-the-fly."
  (interactive)
  (when grammar-mode
    (let ((command this-command))
      (if (grammar-check-pre-sentence-p)
	  (grammar-check))
      )))

(provide 'grammar)
