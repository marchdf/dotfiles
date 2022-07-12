;;; package -- Summary
;;;
;;; Commentary:
;;;
;;; Written by Marc Henry de Frahan
;;;
;;; Required externals:
;;; - aspell or hunspell
;;; - emms-print-metadata
;;; - global
;;; - clang/llvm
;;; - ccls
;;; - mp3info
;;; - mpv
;;; - pianobar
;;; - shellcheck
;;; - vlc
;;; - vorbis-tools
;;;
;;; Code:

;;================================================================================
;;
;; Set up
;;
;;================================================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("03e3e79fb2b344e41a7df897818b7969ca51a15a67dc0c30ebbdeb9ea2cd4492" "0b6645497e51d80eda1d337d6cabe31814d6c381e69491931a688836c16137ed" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "5e3fc08bcadce4c6785fc49be686a4a82a356db569f55d411258984e952f194a" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "196cc00960232cfc7e74f4e95a94a5977cb16fd28ba7282195338f68c84058ec" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "12b4427ae6e0eef8b870b450e59e75122d5080016a9061c9696959e50d578057" "ad950f1b1bf65682e390f3547d479fd35d8c66cafa2b8aa28179d78122faa947" "3f78849e36a0a457ad71c1bda01001e3e197fe1837cb6eaa829eb37f0a4bdad5" "4f5bb895d88b6fe6a983e63429f154b8d939b4a8c581956493783b2515e22d6d" "bc40f613df8e0d8f31c5eb3380b61f587e1b5bc439212e03d4ea44b26b4f408a" "b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" "9ff70d8009ce8da6fa204e803022f8160c700503b6029a8d8880a7a78c5ff2e5" "cd03a600a5f470994ba01dd3d1ff52d5809b59b4a37357fa94ca50a6f7f07473" "94ba29363bfb7e06105f68d72b268f85981f7fba2ddef89331660033101eb5e5" "524c8884ab3635936c11344662e2c1b647203721855366facdf726010aed5cb1" "11636897679ca534f0dec6f5e3cb12f28bf217a527755f6b9e744bd240ed47e1" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default))
 '(inhibit-startup-screen t)
 '(kill-ring-max 70)
 '(org-agenda-files
   '("~/org/hpacf/followup.org" "~/org/work.org" "~/org/hpacf/hpacf.org" "~/org/hpacf/2c00-admin.org"))
 '(package-selected-packages
   '(consult-company consult-flycheck consult-flyspell consult-lsp consult-projectile embark embark-consult consult marginalia selectrum-prescient selectrum doom-modeline god-mode pyvenv pianobar yasnippet wgrep wgrep-helm dap-mode gnu-elpa-keyring-update modern-cpp-font-lock ccls lsp-ui company-lsp elfeed company-shell flyspell-correct flyspell-correct-helm intero haskell-mode json-mode hydra cmake-mode emms magit smartparens rainbow-delimiters yaml-mode wc-mode elpy reverse-theme python-environment popup polymode markdown-mode julia-mode jedi-core jedi ess epc deferred ctable concurrent auto-complete auctex matlab-mode clang-format avy helm-make helm-git-grep helm-projectile projectile diminish use-package bind-key))
 '(user-full-name "Marc Henry de Frahan"))
(set-face-attribute 'default nil :height 110)

;; never tabs
(setq-default indent-tabs-mode nil)

;; syntax color
(global-font-lock-mode t)

;; For accents. To toggle: C-\
(setq default-input-method "latin-1-prefix")

;;Turn alarm completely off
(setq ring-bell-function 'ignore )

;; Never follow symlinks (don't prompt to ask). This allows me to keep
;; the syntax coloring when editing a symlinked file (useful for the
;; dotfiles thing)
(setq vc-follow-symlinks nil)

;; Backup. A lot.
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; Change "yes or no" to "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;; warn when opening files bigger than 200MB
(setq large-file-warning-threshold 200000000)

;; silence warnings from native-comp
(setq native-comp-async-report-warnings-errors 'silent)

;;================================================================================
;;
;; Package management
;;
;;================================================================================

;; Enable the MELPA package repo (http://melpa.org/#/getting-started)
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;;================================================================================
;;
;; Diminish
;;
;;================================================================================
(use-package diminish
    :ensure t)


;;================================================================================
;;
;; recentf
;;
;;================================================================================
(use-package recentf
  :config
  (recentf-mode 1))


;;================================================================================
;;
;; Code completion
;;
;;================================================================================
(use-package yasnippet
  :ensure t
  :hook ((prog-mode . yas-minor-mode))
  :diminish yas-minor-mode)


(use-package company
  :ensure t
  :defer t
  :after (lsp-mode)
  :bind
  ;;("M-[" . company-complete-common)
  :config
  (use-package company-shell
    :ensure t
    :defer t)

  (setq company-show-numbers t
        company-backends     '((company-shell company-shell-env company-capf)))
  (global-company-mode))


;;================================================================================
;;
;; LSP
;;
;;================================================================================
(use-package lsp-mode
  :ensure t
  :defer t
  :commands lsp
  :hook ((c-mode c++-mode objc-mode python-mode) . lsp)
  :bind
  ("C-c i" . lsp-format-region)
  ("C-c u" . lsp-format-buffer)
  ("C-c f d" . lsp-find-definition)
  ("C-c f r" . lsp-find-references)
  ("C-c f p" . xref-pop-marker-stack)
  :config
  (setq lsp-pyls-plugins-autopep8-enabled nil)
  (setq lsp-pyls-plugins-yapf-enabled nil)
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\plt\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\chk\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\PeleCGoldFiles\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\Submodules\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\submods\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\tmp_build_dir\\'")

  ;; Increase garbage collection threshold
  ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
  ;; https://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/
  (setq gc-cons-threshold 100000000)
  (defun my-minibuffer-setup-hook ()
    (setq gc-cons-threshold most-positive-fixnum))

  (defun my-minibuffer-exit-hook ()
    (setq gc-cons-threshold 100000000))

  (add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
  (add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

  ;; Increase the amount of data which Emacs reads from the process
  (setq read-process-output-max (* 1024 1024)) ;; 1mb

  (use-package lsp-ui
    :ensure t
    :after (lsp-mode)
    :hook (lsp-mode . lsp-ui-mode)
    :bind
    ("C-c f u" . lsp-ui-imenu)
    ("C-c f D" . lsp-ui-peek-find-definitions)
    ("C-c f R" . lsp-ui-peek-find-references)
    :config
    (setq lsp-ui-flycheck-enable t))

  ;; Servers
  ;; ccls is in homebrew, to compile from source do:
  ;;  $ git clone --depth=1 --recursive https://github.com/MaskRay/ccls
  ;;  $ cd ccls
  ;;  $ cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/usr/local/opt/llvm -DCMAKE_CXX_COMPILER=/usr/local/opt/llvm/bin/clang++
  ;;  $ VERBOSE=1 cmake --build Release
  (use-package ccls
    :ensure t
    :after (lsp-mode)
    :bind
    ("C-c f m" . ccls-member-hierarchy)
    ("C-c f i" .  ccls-inheritance-hierarchy)
    :hook ((c-mode c++-mode objc-mode) .
           (lambda () (require 'ccls) (lsp))))

  (setq lsp-prefer-flymake nil)
  (setq lsp-file-watch-threshold 20000))

(use-package dap-mode
  :ensure t
  :after lsp-mode
  :functions dap-hydra/nil
  :config
  (dap-register-debug-template
   "LLDB::PeleG"
   (list :type "lldb"
         :cwd "/Users/mhenryde/combustion/Pele/PeleG/MyBuild"
         :request "launch"
         :program "pelec"
         :args ["input-3d"]
         :name "LLDB::PeleG"))
  :hook ((after-init . dap-mode)
         (dap-mode . dap-ui-mode)
         (dap-mode . dap-tooltip-mode)
         (dap-session-created . (lambda (_args) (dap-hydra)))
         (dap-stopped . (lambda (_args) (dap-hydra)))
         (dap-terminated . (lambda (&_rest) (dap-hydra/nil)))
         ((c-mode c++-mode objc-mode) . (lambda () (require 'dap-lldb)))))


;;================================================================================
;;
;; Syntax checking
;;
;;================================================================================
(use-package flycheck
  :ensure t
  :defer t
  :hook ((c-mode c++-mode objc-mode) . flycheck-mode)
  :config
  (global-flycheck-mode)

  (setq flycheck-python-flake8-executable "flake8"))


;;================================================================================
;;
;; Projectile
;;
;;================================================================================
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :bind
  ("C-c p a" . projectile-find-other-file)
  ("C-c p p" . projectile-switch-project)
  ("C-c p f" . projectile-find-file)
  ("C-c p d" . projectile-find-dir)
  ("C-c p b" . projectile-switch-to-buffer)
  ("C-c p e" . projectile-recentf)
  :config
  (setq projectile-globally-ignored-files
        (append projectile-globally-ignored-files
                '(".DS_Store" ".dir-locals.el" ".pyc"))
        projectile-globally-ignored-directories
        (append projectile-globally-ignored-directories
                '("build" "__pycache__" "Build"))
        projectile-enable-caching t
        projectile-completion-system 'default)

  (projectile-mode))

;;================================================================================
;;
;; Selectrum
;;
;;================================================================================
(use-package selectrum
  :ensure t
  :init
  (selectrum-mode +1)
  :custom
  (selectrum-cycle-movement t))


(use-package selectrum-prescient
  :ensure t
  :after selectrum
  :init
  (selectrum-prescient-mode +1))

;;================================================================================
;;
;; Prescient
;;
;;================================================================================
(use-package prescient
  :ensure t
  :after selectrum
  :config
  (prescient-persist-mode +1))

;;================================================================================
;;
;; Consult
;;
;;================================================================================
(use-package consult
  :bind
  (("C-c h" . consult-history)
   ("C-x b" . consult-buffer)
   ("M-g g" . consult-goto-line)
   ("M-g M-g" . consult-goto-line)
   ("C-c g" . consult-git-grep)
   ("C-c s" . consult-git-grep-symbol-at-point)
   ("C-s" . consult-line-symbol-at-point)
   ("C-r" . consult-line-symbol-at-point))
  :config
  (defun consult-line-symbol-at-point ()
    "Use symbol at point for consult-line."
    (interactive)
    (consult-line (thing-at-point 'symbol)))
  (defun consult-git-grep-symbol-at-point ()
    "Use symbol at point for consult-git-grep."
    (interactive)
    (require 'project)
    (consult-git-grep (project-root (project-current)) (thing-at-point 'symbol))))

(use-package consult-company
  :ensure t
  :after (consult company)
  :config
  (define-key company-mode-map [remap completion-at-point] #'consult-company))

(use-package consult-lsp
  :ensure t
  :after (consult lsp))

(use-package consult-projectile
  :ensure t
  :after (consult projectile)
  :bind
  ("C-c p h" . consult-projectile)
  ([remap projectile-switch-project] . consult-projectile-switch-project)
  ([remap projectile-find-file] . consult-projectile-find-file)
  ([remap projectile-find-dir] . consult-projectile-find-dir)
  ([remap projectile-switch-to-buffer] . consult-projectile-switch-to-buffer)
  ([remap projectile-recentf] . consult-projectile-recentf))


;;================================================================================
;;
;; Embark
;;
;;================================================================================
(use-package embark
  :ensure t
  :after consult
  :bind
  (("M-." . embark-act)
   ("M-," . embark-dwim)
   :map embark-general-map
   ("C-s" . consult-line)
   ("C-c g" . embark-consult-git-grep))
  :custom
  (embark-help-key "?")
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (defun embark-consult-git-grep (target)
    "Use consult-git-grep on target."
    (consult-git-grep nil target))
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t
  :after (embark consult)
  :demand t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;;================================================================================
;;
;; Enable richer annotations using the Marginalia package
;;
;;================================================================================
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))


;;================================================================================
;;
;; Moving around with avy
;;
;;================================================================================
(use-package avy
  :ensure t
  :bind
  ("M-;" . avy-goto-char-timer)
  ("M-j" . hydra-avy/body)
  :config
  (defhydra hydra-avy (:exit t :hint nil)
    "
 Line^^       Region^^        Goto
----------------------------------------------------------
 [_y_] yank   [_Y_] yank      [_c_] timed char
 [_m_] move   [_M_] move      [_w_] word
 [_k_] kill   [_K_] kill      [_l_] line        [_L_] end of line"
    ("c" avy-goto-char-timer)
    ("w" avy-goto-word-1)
    ("l" avy-goto-line)
    ("L" avy-goto-end-of-line)
    ("m" avy-move-line)
    ("M" avy-move-region)
    ("k" avy-kill-whole-line)
    ("K" avy-kill-region)
    ("y" avy-copy-line)
    ("Y" avy-copy-region)))


;;================================================================================
;;
;; Navigating windows with ace-window
;;
;;================================================================================
(use-package ace-window
  :ensure t
  :bind ("M-o" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))


;;================================================================================
;;
;; Wgrep
;;
;;================================================================================
(use-package wgrep
  :ensure t)


;;================================================================================
;;
;; Compile commands inspired from http://www.emacswiki.org/emacs/CompileCommand
;;
;;================================================================================
(setq compilation-last-buffer nil)
(setq compilation-scroll-output 'first-error)

;; kill the compilation without prompt if recompile taken from
;; http://user42.tuxfamily.org/compilation-always-kill/index.html I
;; think this might exist in next versions of emacs already. though it
;; doesn't seem to exist for v23
(autoload 'compilation-always-kill-mode "~/.emacs.d/personal/compilation-always-kill" nil t)
(eval-after-load "compile" '(compilation-always-kill-mode 1))

;; Compile using the last compile command. Blurb: "M-x recompile just
;; executes the last compile command in the directory of the current
;; buffer which can be different from the directory of the compile
;; buffer. So you would have to manually switch to the compile buffer
;; and do compile there. This is what the above command does."
(defun compile-again (pfx)
  """Run the same compile as the last time: if there was no last time, or there is a prefix argument PFX, this acts like M-x compile."""
  (interactive "p")
  (if (buffer-modified-p)
      (if (y-or-n-p (format "Buffer %s modified; Do you want to save? " (buffer-name)))
          (save-buffer)))
  (if (and (eq pfx 1)
           compilation-last-buffer)
      (progn
        (set-buffer compilation-last-buffer)
        (revert-buffer t t))
    (call-interactively 'compile)))

;; Set the shortcut command
(global-set-key (kbd "M-p") 'compile-again)

;; Notifications that compile finished and close the compile buffer if
;; successful.
(defvar success-message "\n Compilation Successful :-) \n ")
(defvar fail-message "\n Compilation Fail :-( \n ")
(defun notify-compilation-result(buffer msg)
  "Notify that the compilation is finished, close the *compilation* BUFFER if the compilation is successful, and set the focus back to Emacs frame (show MSG)."
  (if (string-match "^finished" msg)
      (progn
        (delete-windows-on buffer)
        (message success-message)
        (when (display-graphic-p)
          (tooltip-show success-message))
        )
    (message fail-message)
    (when (display-graphic-p)
      (tooltip-show fail-message))
    (setq compilation-last-buffer nil) ;; resets compile buffer so as not to interfere with 'compile-again
    )
  (defvar current-frame (car (car (cdr (current-frame-configuration)))))
  (select-frame-set-input-focus current-frame))

(add-to-list 'compilation-finish-functions
             'notify-compilation-result)


;;================================================================================
;;
;; Kill current buffer, but ask to save, but only if it has been modified
;;
;;================================================================================
;; Based on
;; http://ergoemacs.org/emacs/elisp_close_buffer_open_last_closed.html
;; and
;; http://stackoverflow.com/questions/2357881/emacs-cant-get-buffer-offer-save-working
(defun kill-this-buffer-volatile ()
    "Kill current buffer, even if it has been modified.  But ask to save first."
    (interactive)
    (if (buffer-modified-p)
    (if (y-or-n-p (format "Buffer %s modified; Do you want to save? " (buffer-name)))
              (save-buffer)))
    (kill-this-buffer))

;; set the hotkey
(global-set-key (kbd "C-x C-k") 'kill-this-buffer-volatile)


;;================================================================================
;;
;; C/C++
;;
;;================================================================================
(use-package cc-mode
  :mode
  ("\\.geo" . c++-mode)  ;; Gmsh files
  ("\\.cu$" . c++-mode)  ;; CUDA files
  ("\\.C$" . c++-mode)
  ("\\.H$" . c++-mode)
  :bind
  ("C-M-l" . forloop)
  ("C-M-p" . printf-binding)
  :config
  (use-package modern-cpp-font-lock
    :ensure t
    :diminish modern-c++-font-lock-mode
    :hook (c++-mode . modern-c++-font-lock-mode))

  (c-add-style "my-cpp-style"
               '("stroustrup"
                 (c-offsets-alist
                  (innamespace . 0)
                  (inline-open . 0)
                  (arglist-close . 0))))

  (defun my-cpp-mode-hook ()
    (add-to-list 'projectile-other-file-alist
                 '("C" "H" "hpp" "hxx"))
    (add-to-list 'projectile-other-file-alist
                 '("H" "cpp"))
    (c-set-style "my-cpp-style")
    (setq c-basic-offset 2))

  (add-hook 'c++-mode-hook 'my-cpp-mode-hook)

  (defun printf-binding (out vars)
    "Binding for printf to make things easier.  OUT is the output string and VARS is the variables to printf."
    (interactive "MOutput:\nMVariables:")
    (let ((beg (point)))
      (insert "printf(\"" out "\\n\"," vars ");")
      (indent-region beg (point))))

  (defun forloop (i imax)
    "Build a C/C++ for loop given I and IMAX."
    (interactive "Miterator:\nMmax:")
    (let ((beg (point)))
      (insert "for(int " i "=0; " i "<" imax "; " i "++){\n\n}")
      (indent-region beg (point))
      (forward-line -1)
      (c-indent-command))))


;;================================================================================
;;
;; Clang formatting
;;
;;================================================================================
(use-package clang-format
  :ensure t)


;;================================================================================
;;
;; Fortran
;;
;;================================================================================
(use-package fortran
  :init
  ;; Make Fortran indent at the level of the code. Not a fixed width.
  (add-hook 'f90-mode-hook
            (lambda ()
              (setq fortran-comment-indent-style 'relative))))


;;================================================================================
;;
;; Matlab
;;
;;================================================================================
(use-package matlab
  :ensure matlab-mode)


;;================================================================================
;;
;; Latex
;;
;;================================================================================
(use-package latex
  :ensure auctex
  :mode
  ("\\.tex\\'" . latex-mode)
  :commands (latex-mode LaTeX-mode plain-tex-mode)
  :bind
  ("C-c %" . replace-newlines-with-percent-in-region)
  ("M-F" . insert-figure-reference)
  ("M-E" . insert-equation-reference)
  ("M-T" . insert-table-reference)
  ("M-H" . insert-chapter-reference)
  ("M-G" . insert-appendix-reference)
  ("M-L (" . insert-left-right-paren)
  ("M-L {" . insert-left-right-brace)
  ("M-L [" . insert-left-right-bracket)
  :config
  (add-to-list 'TeX-command-list
               '("Make" "make" TeX-run-compile nil t
                 :help "Compile with Makefile"))

  ;; function to replace all \n with %\n in a region. Useful for latex
  ;; when you are in the minipage environment.
  (defun replace-newlines-with-percent-in-region ()
    "Replace newlines with %\n in region."
    (interactive)
    (save-restriction
      (narrow-to-region (point) (mark))
      (goto-char (point-min))
      (while (search-forward "\n" nil t) (replace-match "%\n" nil t))))

  (defun insert-figure-reference ()
    "Insert a figure reference for LaTex."
    (interactive)
    (insert "Figure\\,\\ref{fig:}") (backward-char 1))

  (defun insert-equation-reference ()
    "Insert an equation reference for LaTex."
    (interactive)
    (insert "Equation\\,(\\ref{eq:})") (backward-char 2))

  (defun insert-table-reference ()
    "Insert a table reference for LaTex."
    (interactive)
    (insert "Table\\,\\ref{tab:}") (backward-char 1))

  (defun insert-chapter-reference ()
    "Insert a chapter reference for LaTex."
    (interactive)
    (insert "Chapter\\,\\ref{chap:}") (backward-char 1))

  (defun insert-appendix-reference ()
    "Insert an appendix reference for LaTex."
    (interactive)
    (insert "Appendix\\,\\ref{app:}") (backward-char 1))

  (defun insert-left-right-paren ()
    "Insert a left right paren for LaTex math mode."
    (interactive)
    (insert "\\left( \\right)") (backward-char 8))

  (defun insert-left-right-brace ()
    "Insert a left right brace for LaTex math mode."
    (interactive)
    (insert "\\left\\{ \\right\\}") (backward-char 9))

  (defun insert-left-right-bracket ()
    "Insert a left right bracket for LaTex math mode."
    (interactive)
    (insert "\\left[ \\right]") (backward-char 8))

  (setq TeX-auto-save t
        TeX-newline-function 'reindent-then-newline-and-indent
        TeX-parse-self t))

(use-package bibtex
  :ensure t
  :mode ("\\.bib" . bibtex-mode))


;;================================================================================
;;
;; Dictionary stuff
;;
;;================================================================================
(use-package ispell
  :ensure t
  :config
  (cond
   ((executable-find "aspell")
    (setq ispell-program-name "aspell")
    (setq ispell-extra-args   '("--sug-mode=ultra"
                                "--lang=en_US")))
   ((executable-find "hunspell")
    (setq ispell-program-name "hunspell")
    (setq ispell-extra-args   '("-d en_US"))))

  ;; Switch dictionaries
  (defun fd-switch-dictionary()
    "Binding to switch between dictionaries."
    (interactive)
    (let* ((dic ispell-current-dictionary)
           (change (if (string= dic "francais") "en_US" "francais")))
      (ispell-change-dictionary change)
      (message "Dictionary switched from %s to %s" dic change)
      ))

  (use-package flyspell
    :ensure t
    :diminish flyspell-mode
    :config
    (use-package flyspell-correct
      :ensure t
      :bind
      ;;("C-c s" . 'flyspell-correct-previous-word-generic)
      )

    ;; No spell check for embedded snippets in org-mode
    ;; From http://emacs.stackexchange.com/questions/9333/how-does-one-use-flyspell-in-org-buffers-without-flyspell-triggering-on-tangled/9347#9347
    (defadvice org-mode-flyspell-verify (after org-mode-flyspell-verify-hack activate)
      (let ((rlt ad-return-value)
            (begin-regexp "^[ \t]*#\\+begin_\\(src\\|html\\|latex\\)")
            (end-regexp "^[ \t]*#\\+end_\\(src\\|html\\|latex\\)")
            old-flag
            b e)
        (when ad-return-value
          (save-excursion
            (setq old-flag case-fold-search)
            (setq case-fold-search t)
            (setq b (re-search-backward begin-regexp nil t))
            (if b (setq e (re-search-forward end-regexp nil t)))
            (setq case-fold-search old-flag))
          (if (and b e (< (point) e)) (setq rlt nil)))
        (setq ad-return-value rlt)))

    ;; No spell check for code snippets in Markdown
    (defun flyspell-generic-textmode-verify ()
      "Used for `flyspell-generic-check-word-predicate' in text modes."
      ;; (point) is next char after the word. Must check one char before.
      (let ((f (get-text-property (- (point) 1) 'face)))
        (not (memq f '(markdown-pre-face)))))
    (setq flyspell-generic-check-word-predicate 'flyspell-generic-textmode-verify)

    (add-hook 'text-mode-hook #'flyspell-mode)
    (add-hook 'org-mode-hook #'flyspell-mode)
    (add-hook 'latex-mode-hook #'flyspell-mode)
    (add-hook 'tex-mode-hook #'flyspell-mode)
    (add-hook 'prog-mode-hook #'flyspell-prog-mode)))


;;================================================================================
;;
;; Color theme
;;
;;================================================================================
(use-package reverse-theme
  :ensure t
  :init
  (load-theme 'reverse t))


;;================================================================================
;;
;; Shell editing
;;
;;================================================================================
(use-package sh-script
  :mode
  ("\\.zsh" . sh-mode)
  ("\\.pbs" . sh-mode))


;;================================================================================
;;
;; Word counting
;;
;;================================================================================
(use-package wc-mode
  :ensure t
  :bind
  ("\C-cw" . wc-mode))


;;================================================================================
;;
;; Org-mode
;;
;;================================================================================
(use-package org
  :ensure t
  :bind
  ("C-c a" . org-agenda)
  :init
  (setq org-startup-truncated nil)
  (setq org-log-done 'note))


;;================================================================================
;;
;; ESS
;;
;;================================================================================
(use-package ess-site
  :ensure ess
  :mode
  ("\\.R\\'" . R-mode)
  ("\\.Rprofile" . R-mode)
  :commands R
  :config
  ;; inspiration for the following:
  ;; http://stats.blogoverflow.com/2011/08/using-emacs-to-work-with-r/
  ;; save more commands
  (setq comint-input-ring-size 1000)

  ;; "This recalls the R statement from your R statement history, but it
  ;; tries to match it with the one which is already on your line."
  (add-hook 'inferior-ess-mode-hook
            (lambda nil
              (define-key inferior-ess-mode-map [\C-up]
                'comint-previous-matching-input-from-input)
              (define-key inferior-ess-mode-map [\C-down]
                'comint-next-matching-input-from-input)
              (define-key inferior-ess-mode-map [\C-x \t]
                'comint-dynamic-complete-filename)))

  ;; To assign ":" to "<-" and to stop the assignment of underscore
  ;; (underbar) "_" to "<-"
  (setq ess-smart-S-assign-key ":")
  (ess-toggle-S-assign nil)
  (ess-toggle-S-assign nil)
  (ess-toggle-underscore nil))


;;================================================================================
;;
;; Markdown and polymode
;;
;;================================================================================
(use-package markdown-mode
  :ensure t
  :mode
  ("README\\.md\\'" . gfm-mode)
  ("\\.md\\'" . markdown-mode)
  ("\\.markdown\\'" . markdown-mode))

(use-package polymode
  :ensure t
  :mode
  ("\\.Snw" . poly-noweb+r-mode)
  ("\\.Rnw" . poly-noweb+r-mode)
  ("\\.Rmd" . poly-markdown+r-mode))


;;================================================================================
;;
;; reStructuredText
;;
;;================================================================================
(use-package rst
  :ensure t
  :mode
  ("\\.rst$" . rst-mode)
  ("\\.rest$" . rst-mode))


;;================================================================================
;;
;; Python
;;
;;================================================================================
(use-package python)
;; add this to autoformat before saving:
;;  :hook ((python-mode . (lambda () (add-hook 'before-save-hook 'lsp-format-buffer nil 'local)))))

(use-package pyvenv
  :ensure t
  :config
  (pyvenv-workon "dotfiles"))

(use-package jedi
  :ensure t)


;;================================================================================
;;
;; Git
;;
;;================================================================================
(use-package magit
  :ensure t
  :bind
  ("M-m" . magit-status))


;;================================================================================
;;
;; Haskell
;;
;;================================================================================
(use-package haskell-mode
  :ensure t
  :mode
  ("\\.hs\\'" . haskell-mode)
  ("\\.lhs\\'" . haskell-mode)
  :config

  (use-package intero
       :ensure t
       :config
       (add-hook 'haskell-mode-hook 'intero-mode)))


;;================================================================================
;;
;; YAML
;;
;;================================================================================
(use-package yaml-mode
  :ensure t
  :mode
  ("\\.yml$" . yaml-mode)
  ("\\.clang-format$" . yaml-mode))


;;================================================================================
;;
;; Rainbow delimiters
;;
;;================================================================================
(use-package rainbow-delimiters
  :ensure    rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))


;;================================================================================
;;
;; Smart pairs of parenthesis
;;
;;================================================================================
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :bind
  ("C-M-k" . sp-kill-sexp)
  ("C-M-f" . sp-forward-sexp)
  ("C-M-b" . sp-backward-sexp)
  ("C-M-n" . sp-next-sexp)
  ("C-M-p" . sp-previous-sexp)
  ("C-M-u" . sp-up-sexp)
  ("C-M-d" . sp-down-sexp)
  ("C-M-w" . sp-copy-sexp)
  ("C-M-a" . sp-beginning-of-sexp)
  ("C-M-e" . sp-end-of-sexp)
  :init
  (show-smartparens-global-mode t)
  (smartparens-global-mode t)
  :config
  (sp-with-modes '(html-mode sgml-mode nxml-mode web-mode)
    (sp-local-pair "<" ">"))

  (use-package smartparens-config))


;;================================================================================
;;
;; Ediff
;;
;;================================================================================
(use-package ediff
  :ensure t
  :init
  ;; Customize the colors of the non-current changes
  (add-hook 'ediff-load-hook
            (lambda ()
              (setq ediff-split-window-function 'split-window-horizontally)
              (setq ediff-merge-split-window-function 'split-window-horizontally)
              (set-face-background
               ediff-odd-diff-face-A "dim gray")
              (set-face-background
               ediff-even-diff-face-A "dim gray")
              (set-face-background
               ediff-odd-diff-face-B "dim gray")
              (set-face-background
               ediff-even-diff-face-B "dim gray")
              (set-face-background
               ediff-odd-diff-face-C "dim gray")
              (set-face-background
               ediff-even-diff-face-C "dim gray"))))


;;================================================================================
;;
;; Cmake
;;
;;
;;================================================================================
(use-package cmake-mode
  :ensure t
  :mode
  ("CMakeLists\\.txt\\'" . cmake-mode)
  ("\\.cmake\\'" . cmake-mode))


;;================================================================================
;;
;; Automatic music layout
;; Uses EMMS (which requires mp3info and vorbis-tools)
;;
;;================================================================================
(use-package music-setup
  :bind
  ("C-c m" . my-music-layout)
  :init
  (defvar my-music-directory "~/my_music")

  (use-package emms
    :ensure t
    :bind
    ("C-c e b" . emms-smart-browse)
    ("C-c e p" . emms-pause)
    ("C-c e n" . emms-next)
    ("C-c e t" . emms-previous)
    :config
    (emms-all)

    (emms-default-players)
    (define-emms-simple-player flac123 '(file)
      "\\.flac$" "flac123")
    (add-to-list 'emms-player-list emms-player-flac123)

    ;; Use libtag exclusively for tagging
    ;; Requires building emms-print-metadata and it being in your path
    (require 'emms-info-libtag)
    (setq emms-info-functions '(emms-info-libtag))

    (if (eq system-type 'darwin)
        (progn
          (setq emms-player-vlc-command-name
                "/Applications/VLC.app/Contents/MacOS/VLC")))

    (setq emms-source-file-default-directory my-music-directory
          emms-playlist-buffer-name "*Music Playlist*"
          emms-playlist-default-major-mode 'emms-playlist-mode
          emms-show-format "♪ %s"
          emms-browser-default-covers (list (concat (file-name-as-directory my-music-directory) "cover_small.jpg")
                                            (concat (file-name-as-directory my-music-directory) "cover_med.jpg")
                                            nil)
          emms-browser-info-artist-format "%i● %n"
          emms-browser-info-album-format "%i◎%cS%n"
          emms-browser-info-genre-format "%i● %n"
          emms-browser-info-title-format "%i♪ %T. %n"
          emms-browser-playlist-info-artist-format emms-browser-info-artist-format
          emms-browser-playlist-info-album-format emms-browser-info-album-format
          emms-browser-playlist-info-title-format emms-browser-info-title-format))

  (use-package pianobar
    :ensure t
    :bind
    ("C-c b p" . pianobar-play-or-pause)
    ("C-c b n" . pianobar-next-song)
    ("C-c b q" . pianobar-quit)
    ("C-c b s" . pianobar-change-station)
    ("C-c b t" . pianobar-ban-current-song)
    :config
    (setq pianobar-config t))

  (defun my-music-layout ()
    (interactive)
    (delete-other-windows)
    (emms-smart-browse)))


;;================================================================================
;;
;; RSS feeds with elfeed
;;
;;================================================================================
(use-package elfeed
  :ensure t
  :bind
  ("C-x w" . elfeed)
  :config
  (setq elfeed-feeds
        '(("http://rss.rtbf.be/media/rss/audio/c21-class_recent.xml" podcast))))


;;================================================================================
;;
;; Dired
;;
;;================================================================================
(use-package dired
  :config
  (defun dired-ediff-files ()
    """Diff files in dired mode by pressing 'e'. From https://oremacs.com/2017/03/18/dired-ediff."""
    (interactive)
    (let ((files (dired-get-marked-files))
          (wnd (current-window-configuration)))
      (if (<= (length files) 2)
          (let ((file1 (car files))
                (file2 (if (cdr files)
                           (cadr files)
                         (read-file-name
                          "file: "
                          (dired-dwim-target-directory)))))
            (if (file-newer-than-file-p file1 file2)
                (ediff-files file2 file1)
              (ediff-files file1 file2))
            (add-hook 'ediff-after-quit-hook-internal
                      (lambda ()
                        (setq ediff-after-quit-hook-internal nil)
                        (set-window-configuration wnd))))
        (error "No more than 2 files should be marked"))))
  (define-key dired-mode-map "e" 'dired-ediff-files))


;;================================================================================
;;
;; JSON
;;
;;================================================================================
(use-package json-mode
  :ensure t
  :mode ("\\.json?$" . json-mode))


;;================================================================================
;;
;; Hydra
;;
;;================================================================================
(use-package hydra
  :ensure t
  :after (consult avy)
  :bind
  (("C-y" . hydra-yank-pop/yank)
   ("M-y" . hydra-yank-pop/yank-pop)
   ("C-n" . hydra-move/next-line)
   ("C-p" . hydra-move/previous-line)
   ("C-f" . hydra-move/forward-char)
   ("C-b" . hydra-move/backward-char)
   ("C-a" . hydra-move/beginning-of-line)
   ("C-e" . hydra-move/move-end-of-line)
   ("C-v" . hydra-move/scroll-up-command)
   ("M-v" . hydra-move/scroll-down-command)
   ("C-l" . hydra-move/recenter-top-bottom)
   :map minibuffer-local-map
   ("C-n" . next-line)
   ("C-p" . previous-line)
   ("C-f" . forward-char)
   ("C-b" . backward-char)
   ("C-a" . beginning-of-line)
   ("C-a" . beginning-of-line)
   ("C-a" . beginning-of-line)
   ("C-e" . move-end-of-line)
   ("C-v" . scroll-up-command)
   ("M-v" . scroll-down-command)
   ("C-l" . recenter-top-bottom))
  :config

  (defhydra hydra-yank-pop ()
    "yank"
    ("C-y" yank nil)
    ("M-y" yank-pop nil)
    ("y" (consult-yank-pop 1) "next")
    ("Y" (consult-yank-pop -1) "prev")
    ("l" consult-yank-from-kill-ring "list" :color blue))

  (defhydra hydra-move ()
    "move"
    ("n" next-line)
    ("p" previous-line)
    ("f" forward-char)
    ("b" backward-char)
    ("a" beginning-of-line)
    ("e" move-end-of-line)
    ("v" scroll-up-command)
    ("V" scroll-down-command)
    ("l" recenter-top-bottom)
    (";" avy-goto-char-timer :color blue)))


;;================================================================================
;;
;; Miscellaneous functions
;;
;;================================================================================

;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph (M-q)
(defun unfill-paragraph ()
  "Take a multi-line paragraph and make it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

;;================================================================================
;;
;; Programming mode
;;
;;================================================================================
(use-package prog-mode
  :defer t
  :bind
  ("RET" . newline-and-indent))


;;================================================================================
;;
;; Fun startup message
;;
;;================================================================================
(defconst animate-n-steps 0)
(defun emacs-reloaded()
  "Custom startup message."
  (animate-string (concat";;Initialization successful. Greetings, Commander, and welcome to a world of pain: "
                         (substring (emacs-version) 0 15))
                  0 0)
  (newline-and-indent) (newline-and-indent))
(add-hook 'after-init-hook 'emacs-reloaded)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(emms-browser-album-face ((t (:inherit font-lock-variable-name-face))))
 '(emms-browser-artist-face ((t (:inherit font-lock-function-name-face))))
 '(emms-browser-composer-face ((t (:inherit emms-browser-artist-face))))
 '(emms-browser-performer-face ((t (:inherit emms-browser-artist-face))))
 '(emms-browser-track-face ((t (:inherit default))))
 '(emms-playlist-selected-face ((t (:inherit font-lock-string-face))))
 '(emms-playlist-track-face ((t (:inherit default))))
 '(emms-stream-name-face ((t (:inherit emms-browser-artist-face))))
 '(emms-stream-url-face ((t (:inherit default)))))


;;================================================================================
;;
;; Minor mode shortcuts (put at end of file)
;;
;;================================================================================
;; If a global-set-key didn't work because it was overwritten by a major mode,
;; add it here. (from http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs)
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-M-i") 'indent-region)
    (define-key map (kbd "C-c C-z") 'comment-region)
    (define-key map (kbd "M-R") 'kill-rectangle)
    (define-key map (kbd "M-r") 'yank-rectangle)
    (define-key map (kbd "M-k") 'kill-whole-line)
    (define-key map (kbd "C-c C-z") 'comment-region)
    (define-key map (kbd "C-c M-z") 'uncomment-region)
    map)
  "Keymap my-keys-minor-mode.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)

;; Turn off the custom mode in the minibuffer
(defun my-minibuffer-setup-hook ()
  "Turn off my keymap in the minibuffer."
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(provide '.emacs)
;;; .emacs ends here
