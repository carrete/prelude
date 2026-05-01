;;; -*- coding: utf-8; mode: emacs-lisp; lexical-binding: t -*-

(defun tvaughan/untabify ()
  "Preserve initial tab when `makefile-mode'."
  (interactive)
  (save-excursion
    (if (derived-mode-p 'makefile-mode)
        (progn
          (goto-char (point-min))
          (while (not (eobp))
            (skip-chars-forward "\t")
            (untabify (point) (line-end-position))
            (forward-line 1)))
      (untabify (point-min) (point-max)))))

(add-hook 'before-save-hook #'tvaughan/untabify)

;; https://github.com/catppuccin/emacs
(use-package catppuccin-theme
  :ensure t
  :init
  (setq catppuccin-flavor 'macchiato))

;; https://github.com/kickingvegas/casual
(use-package casual
  :ensure t)

(use-package casual-ibuffer
  :after casual
  :ensure nil
  :bind ((:map ibuffer-mode-map
               ("C-o" . #'casual-ibuffer-tmenu)
               ("F" . #'casual-ibuffer-filter-tmenu)
               ("s" . #'casual-ibuffer-sortby-tmenu))))

(use-package casual-dired
  :after casual
  :ensure nil
  :bind ((:map dired-mode-map
               ("C-o" . #'casual-dired-tmenu)
               ("s" . #'casual-dired-sort-by-tmenu)
               ("/" . #'casual-dired-search-replace-tmenu))))

(use-package casual-make
  :after casual
  :ensure nil
  :bind ((:map makefile-mode-map
               ("M-m" . #'casual-make-tmenu))))

;; https://github.com/abo-abo/define-word
(use-package define-word
  :ensure t
  :bind (("C-c d" . define-word-at-point)
         ("C-c D" . define-word)))

;; https://github.com/wbolster/emacs-direnv
(use-package direnv
  :ensure t
  :config
  (direnv-mode +1))

;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :ensure t
  :bind (("C-=" . er/expand-region)))

;; https://github.com/dakra/ghostel
(use-package ghostel
  :ensure t
  :bind (("C-x m" . ghostel)))

;; https://github.com/konrad1977/flyover
(use-package flyover
  :ensure t
  :init
  (setq flyover-display-mode 'show-only-on-same-line)
  (setq flyover-levels '(error warning))
  (setq flyover-use-theme-colors t)
  :config
  (add-hook 'flycheck-mode-hook #'flyover-mode))

;; https://github.com/karthink/popper
(use-package popper
  :ensure t
  :bind (("C-," . popper-toggle)
         ("C-." . popper-cycle)
         ("C-M-," . popper-toggle-type))
  :init
  (setq popper-display-control nil)
  (setq popper-display-function #'display-buffer-in-direction)
  (setq popper-reference-buffers
        '("Output\\*$"
          "^\\*Async Shell Command"
          "^\\*Choices"
          "^\\*HTTP Response"
          "^\\*Messages"
          "^\\*cider-repl"
          "^\\*eldoc.*\\*"
          "^\\*rg"
          help-mode
          compilation-mode))
  :config
  (popper-mode +1)
  (popper-echo-mode +1))

;; https://github.com/AmaiKinono/puni/issues/20
(defun tvaughan/disable-puni-mode ()
  "Disable `puni-mode' unless when eval-expression."
  (unless (eq this-command 'eval-expression)
    (puni-disable-puni-mode)))

;; https://github.com/AmaiKinono/puni
(use-package puni
  :ensure t
  :bind (;; TODO: ("C-]" . puni-barf-forward)
         ;; TODO: ("C-[" . puni-barf-backward)
         ("C-)" . puni-slurp-forward)
         ("C-(" . puni-slurp-backward))
  :hook (minibuffer-setup . tvaughan/disable-puni-mode)
  :config
  (puni-global-mode +1))

;; https://github.com/protesilaos/spacious-padding
(use-package spacious-padding
  :ensure t
  :init
  (setq spacious-padding-subtle-frame-lines
        '(:mode-line-active default :mode-line-inactive "#434C5E"))
  :config
  (spacious-padding-mode +1))
