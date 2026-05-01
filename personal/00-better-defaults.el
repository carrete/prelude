;;; -*- coding: utf-8; mode: emacs-lisp; lexical-binding: t -*-

(set-face-attribute 'default nil :height 130 :family "Fira Code")

(setq-default tab-width 2)

(setq dired-listing-switches "-ADhl --group-directories-first --time-style=long-iso")
(setq package-install-upgrade-built-in t)
(setq mode-line-position-column-line-format '("%l:%C"))

(defun tvaughan/kill-this-buffer ()
  "Kill this buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k") #'tvaughan/kill-this-buffer)
(global-set-key (kbd "C-x w") #'delete-frame)

(define-minor-mode tvaughan/pinned-buffer-mode
  "Pin the current buffer to the selected window."
  :init-value nil
  :lighter (" PB")
  (let ((window (selected-window)))
    (set-window-dedicated-p window #'tvaughan/pinned-buffer-mode)
    (set-window-parameter window 'no-delete-other-windows #'tvaughan/pinned-buffer-mode)))

(global-set-key (kbd "C-c p") #'tvaughan/pinned-buffer-mode)

(defun tvaughan/previous-window ()
  "Corollary to `other-window'."
  (interactive)
  (other-window nil))

(global-set-key (kbd "C-x p") #'tvaughan/previous-window)
(global-set-key (kbd "C-x n") #'other-window)
