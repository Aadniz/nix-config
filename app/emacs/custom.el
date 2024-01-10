;; Automatically sync org files when saving
(defun sync-to-unison ()
  "Sync org file with unison."
  (when (and (eq major-mode 'org-mode)
             (string-prefix-p (expand-file-name "~/Documents/org") buffer-file-name))
    (message "Syncing org files with unison...")
    (let ((output (with-output-to-string
                    (with-current-buffer standard-output
                      (unless (= 0 (call-process-shell-command "unison org-files"))
                        (error "Error: SYNCING FAILED! please run \"unison org-files\" manually"))))))
      (message "Org files synced successfully"))))
(add-hook 'after-save-hook #'sync-to-unison)
(add-hook 'find-file-hook #'sync-to-unison)

;; Something openAI wanted
(defun org-extend-today-until (hour)
  "Extend the current date until the given hour of the day."
  (let* ((hour (string-to-number (car (split-string hour ":"))))
         (now (decode-time))
         (date (list (nth 4 now) (nth 3 now) (nth 5 now)))
         (time (encode-time 0 0 hour (nth 2 now) (nth 1 now) (nth 0 now))))
    (when (time-less-p (current-time) time)
      (setq date (time-add date (* 24 60 60))))
    (setq time (encode-time 0 0 hour (nth 2 now) (nth 1 now) (nth 0 now)))
    (org-time-stamp time t)))

;; Custom latex pdf exporter for org-mode
(with-eval-after-load 'ox-latex
(add-to-list 'org-latex-classes
             '("org-plain-latex"
               "\\documentclass{article}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

;; If #+EXPORT: <mode> is defined within the document, it will recognize that as a way to compile the org file.
;; Example:
;;   #+EXPORT: org-latex-export-to-pdf
(defun get-export-function ()
  (when (derived-mode-p 'org-mode)
    (save-excursion
      (goto-char (point-min))
      (when (re-search-forward "^#\\+EXPORT_DISPATCH: \\(.*\\)" nil t)
        (let ((export-function (intern (match-string 1))))
          (when (fboundp export-function)
            export-function))))))

(defun auto-refresh-export ()
  (let ((export-function (get-export-function)))
    (if export-function
        (local-set-key (kbd "<f5>") export-function)
      (local-unset-key (kbd "<f5>")))))

(defun save-and-export ()
  (interactive)
  (let ((export-function (get-export-function)))
    (when export-function
      (funcall export-function))))

;; Hook save and F5 to export dispatch
(add-hook 'buffer-list-update-hook 'auto-refresh-export)
(add-hook 'before-save-hook 'save-and-export)

;; Auto update PDF files
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(add-hook 'pdf-view-mode-hook 'auto-revert-mode) ;; <- This does not work for some reason?

;; Move around split windowses
;; (windmove-default-keybindings)

;; Change window using CTRL + Shift + S
(global-set-key (kbd "C-S-s") 'other-window)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(nyan-mode crdt helm-pydoc quelpa-use-package org-modern org-jira)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
