; Very small wrapper to pwgen for rapid password generation
; by Jaromil @ dyne.org

(provide 'pwgen)

(defun* pwgen ()
  "Generate a random password using pwgen and saves it into clipboard"
  (interactive)
  (kill-new (shell-command-to-string "pwgen 16 -1s"))
  (message "New random password saved in killring, ready to paste")
  )


