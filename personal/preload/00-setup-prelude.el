;;; -*- coding: utf-8; mode: emacs-lisp; lexical-binding: t -*-

(setq prelude-minimalistic-ui t)
(setq prelude-smartparens nil)
(setq prelude-theme 'catppuccin)

;; https://github.com/clojure-emacs/cider
(use-package cider
  :after cider
  :ensure nil
  :init
  (setq cider-auto-select-error-buffer nil)
  (setq cider-auto-select-test-report-buffer nil)
  (setq cider-connection-message-fn nil)
  ;; (setq cider-redirect-server-output-to-repl nil)
  (setq cider-repl-display-help-banner nil)
  (setq cider-repl-pop-to-buffer-on-connect 'display-only)
  (setq cider-reuse-dead-repls 'auto)
  (setq cider-show-error-buffer nil)
  (setq cider-test-fail-fast nil)
  (setq cider-test-show-report-on-success t)
  (setq nrepl-hide-special-buffers t)
  :config
  (cider-enable-cider-completion-style t))

;; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :after exec-path-from-shell
  :ensure nil
  :config
  (dolist (var '("GPG_AGENT_INFO" "LANG" "LC_COLLATE" "LC_TIME" "SSH_AGENT_PID" "SSH_AUTH_SOCK"))
    (add-to-list 'exec-path-from-shell-variables var)))

(use-package ibuffer
  :after ibuffer
  :ensure nil
  :init
  (setq ibuffer-expert t))

(defun tvaughan/magit-process-environment (env)
  "Add GIT_DIR and GIT_WORK_TREE to ENV when in a special directory.
https://github.com/magit/magit/issues/460 (@cpitclaudel)."
  (let ((default (file-name-as-directory (expand-file-name default-directory)))
        (work-tree (expand-file-name "~/")))
    (when (string= default work-tree)
      (let ((git-dir (expand-file-name "~/.local/share/dotfiles/")))
        (push (format "GIT_WORK_TREE=%s" work-tree) env)
        (push (format "GIT_DIR=%s" git-dir) env))))
  env)

;; https://github.com/magit/magit
(use-package magit
  :after magit
  :ensure nil
  :init
  (setq magit-diff-visit-prefer-worktree t)
  (setq magit-repository-directories '(("~/Projects" . 3)))
  :config
  (advice-add 'magit-process-environment
              :filter-return #'tvaughan/magit-process-environment))

;; https://github.com/oantolin/orderless
(use-package orderless
  :after orderless
  :ensure nil
  :custom
  (completion-styles '(orderless basic flex))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t))

;; https://github.com/minad/vertico/blob/main/extensions/vertico-directory.el
(use-package vertico-directory
  :after vertico
  :ensure nil
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word)))
