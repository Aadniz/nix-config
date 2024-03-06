;;; faces.el blah -*- lexical-binding: t; -*-

(load-file "~/.config/doom/system-vars.el")

(defun set-theme-colors (theme)
  (let ((background-color (cdr (assoc 'background theme)))
        (foreground-color (cdr (assoc 'foreground theme)))
        (secondary-color (cdr (assoc 'secondary theme))))
    (custom-set-faces
     ;; custom-set-faces was added by Custom.
     ;; If you edit it by hand, you could mess it up, so be careful.
     ;; Your init file should contain only one such instance.
     ;; If there is more than one, they won't work right.
     `(default ((t(
                   :background ,background-color
                   :foreground ,foreground-color
                   )))))
    (set-face-attribute 'font-lock-preprocessor-face nil :foreground secondary-color)))

(set-theme-colors user-theme)

