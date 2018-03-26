(setq whitespace-style '(tabs trailing lines tab-mark))
(setq whitespace-line-column 80)
(setq-default show-trailing-whitespace t)
(set-face-attribute 'trailing-whitespace nil :background "red1" :weight 'bold)
(global-whitespace-mode 1)

(defun highlight-tabs ()
  "Highlight tab characters."
  (font-lock-add-keywords
   nil '(("\\(\t+\\)" 1 '(:background "#333333") t))))
(add-hook 'erlang-mode-hook 'highlight-tabs)

(column-number-mode 1)
(global-linum-mode 1)
(setq linum-format "%d ")
(fset 'yes-or-no-p 'y-or-n-p)
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :underline nil)
(delete-selection-mode 1)
(global-auto-revert-mode 1)

(global-set-key [?\M-p] 'scroll-down-line)
(global-set-key [?\M-n] 'scroll-up-line)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(recentf-mode 1)
(show-paren-mode 1)

(setq backup-directory-alist `(("." . "~/.emacs_saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
