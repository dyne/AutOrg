;;; figlet definitions for Emacs.  (C) Martin Giese
;;;
;;; Use this to separate sections in TeX files, Program source, etc.
;;;
;;; customize the figlet-font-dir variable below to point to your
;;; figlet font directory.
;;;
;;; M-x figlet      to get a figlet comment in standard font.
;;; C-u M-x figlet  to be asked for the font first.
;;; M-x banner      for an old-fashioned banner font.
;;;
;;; These functions use comment-region to wrap the figlet output 
;;; in comments.
;;;

;;;  _____ ___ ____ _      _     ____  _          __  __ 
;;; |  ___|_ _/ ___| | ___| |_  / ___|| |_ _   _ / _|/ _|
;;; | |_   | | |  _| |/ _ \ __| \___ \| __| | | | |_| |_ 
;;; |  _|  | | |_| | |  __/ |_   ___) | |_| |_| |  _|  _|
;;; |_|   |___\____|_|\___|\__| |____/ \__|\__,_|_| |_|  
                                                     

(defconst figlet-font-dir "/usr/share/figlet")
(defconst figlet-font-file-regexp "\\.flf$")
(defconst figlet-match-font-name-regexp "^\\([^.]*\\)\\.flf$")

(defun figlet-font-name-for-file (filename)
  (string-match figlet-match-font-name-regexp filename)
  (match-string 1 filename))

(defun figlet-font-names ()
  (mapcar 'figlet-font-name-for-file
	  (directory-files figlet-font-dir nil figlet-font-file-regexp)))

(defun read-figlet-font (prompt)
  (let* ((figlet-fonts (figlet-font-names))
	 (font-alist (mapcar (lambda (x) (list x)) figlet-fonts)))
    (completing-read prompt font-alist)))

(defun call-figlet (font string)
  (push-mark)
  (call-process "figlet" nil (current-buffer) nil
		"-f" (if (null font) "standard" font)
		string
		)
  (exchange-point-and-mark))

(defun figlet-block-comment-region ()
  (comment-region (region-beginning) (region-end)
		  (if (member major-mode 
			      '(emacs-lisp-mode
				lisp-mode
				scheme-mode))
		      3			; 3 semicolons for lisp
		    nil)
		  ))

(defun figlet (s &optional font)
  (interactive 
   (if current-prefix-arg
       (let 
	   ((font (read-figlet-font "Font: "))
	    (text (read-string "FIGlet Text: ")))
	 (list text font))
     (list (read-string "FIGlet Text: ") nil)))
  (save-excursion
    (call-figlet font s)
    (figlet-block-comment-region)
    ))

(defun banner (s) 
  (interactive "sBanner Text: ")
  (figlet s "banner"))
