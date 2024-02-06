;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(beacon-mode 1)

(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks"                          "L" #'list-bookmarks
       :desc "Set bookmark"                            "m" #'bookmark-set
       :desc "Delete bookmark"                         "M" #'bookmark-set
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(evil-define-key 'normal ibuffer-mode-map
  (kbd "f c") 'ibuffer-filter-by-content
  (kbd "f d") 'ibuffer-filter-by-directory
  (kbd "f f") 'ibuffer-filter-by-filename
  (kbd "f m") 'ibuffer-filter-by-mode
  (kbd "f n") 'ibuffer-filter-by-name
  (kbd "f x") 'ibuffer-filter-disable
  (kbd "g h") 'ibuffer-do-kill-lines
  (kbd "g H") 'ibuffer-update)

(use-package! calfw)
(use-package! calfw-org)

(use-package! centaur-tabs
  :if window-system
  :defer t
  :demand
  :init
  ;; Set the style to rounded with icons
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-icons t)

  :config
  ;; Enable centaur-tabs
  ;; (centaur-tabs-mode t)

  (setq centaur-tabs-set-bar 'over
    centaur-tabs-set-icons t
    centaur-tabs-gray-out-icons 'buffer
    centaur-tabs-height 24
    centaur-tabs-set-modified-marker t
    centaur-tabs-style "bar"
    centaur-tabs-modified-marker "•")
  (evil-define-key 'normal centaur-tabs-mode-map (kbd "g <right>") 'centaur-tabs-forward        ; default Doom binding is 'g t'
                                                 (kbd "g <left>")  'centaur-tabs-backward       ; default Doom binding is 'g T'
                                                 (kbd "g <down>")  'centaur-tabs-forward-group
                                                 (kbd "g <up>")    'centaur-tabs-backward-group))

(map! :leader
:desc "Toggle tabs globally" "t c" #'centaur-tabs-mode
:desc "Toggle tabs local display" "t C" #'centaur-tabs-local-mode)

(use-package! treemacs
  :defer t
  :config
  (setq treemacs-width 30)
  (setq-local mode-line-format nil))

(map! :leader
:desc "Init/Togle treemacs" "o l" #'treemacs)

(map! :leader
      (:prefix ("c h" . "Help info from Clippy")
       :desc "Clippy describes function under point" "f" #'clippy-describe-function
       :desc "Clippy describes variable under point" "v" #'clippy-describe-variable))

;; Altenative: doom-dashboard from init.el
(use-package dashboard
  :init      ;; tweak dashboard config before loading it
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "\nKEYBINDINGS:\
\nFind file               (SPC .)     \
Open buffer list    (SPC b i)\
\nFind recent files       (SPC f r)   \
Open the eshell     (SPC e s)\
\nOpen dired file manager (SPC d d)   \
List of keybindings (SPC h b b)")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.config/doom/images/avatar.png")  ;; use custom image as banner
  (setq dashboard-banner-logo-title "I am just a coder for fun")
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 5)
                          (projects . 5)
                          (registers . 5)))
  :config
  (dashboard-setup-startup-hook))

(setq inhibit-startup-screen t)

(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file" "d v" #'dired-view-file)))

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-up-directory
  (kbd "% l") 'dired-downcase
  (kbd "% u") 'dired-upcase
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(use-package emojify
  :hook (after-init . global-emojify-mode))

(map! :leader
      (:prefix ("e". "evaluate/ERC/EWW")
       :desc "Launch ERC with TLS connection" "E" #'erc-tls))

(setq erc-prompt (lambda () (concat "[" (buffer-name) "]"))
      erc-server "irc.libera.chat"
      erc-nick "hadouken"
      erc-track-shorten-start 24
      erc-autojoin-channels-alist '(("irc.libera.chat" "#archlinux" "#linux" "#emacs"))
      erc-kill-buffer-on-part t
      erc-fill-column 100
      erc-fill-function 'erc-fill-static
      erc-fill-static-center 20
      ;; erc-auto-query 'bury
      )

(map! :leader
      (:prefix ("e". "evaluate/ERC/EWW")
       :desc "Evaluate elisp in buffer" "b" #'eval-buffer
       :desc "Evaluate defun" "d" #'eval-defun
       :desc "Evaluate elisp expression" "e" #'eval-expression
       :desc "Evaluate last sexpression" "l" #'eval-last-sexp
       :desc "Evaluate elisp in region" "r" #'eval-region))

(setq browse-url-browser-function 'eww-browse-url)
(map! :leader
      :desc "Search web for text between BEG/END"
      "s w" #'eww-search-words
      (:prefix ("e" . "evaluate/ERC/EWW")
       :desc "Eww web browser" "w" #'eww
       :desc "Eww reload page" "R" #'eww-reload))

(setq minimap-window-location 'right)
(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Toggle minimap-mode" "m" #'minimap-mode))

(set-face-attribute 'mode-line nil :font "Ubuntu Mono-15")
(setq doom-modeline-height 30     ;; sets modeline height
      doom-modeline-bar-width 5   ;; sets right bar width
      doom-modeline-persp-name t  ;; adds perspective name to modeline
      doom-modeline-persp-icon t  ;; adds folder icon next to persp name
      doom-modeline-support-imenu t
      doom-modeline-major-mode-icon t
      doom-modeline-project-detection 'auto
      doom-modeline-percent-position '(-3 "%p")
      ;; doom-modeline-buffer-encoding t
      doom-modeline-buffer-file-name-style 'truncate-upto-root
      doom-modeline-workspace-name t
      doom-modeline-modal-icon nil
      doom-modeline-modal-modern-icon nil)

(xterm-mouse-mode 1)

(map! :leader
      (:prefix ("=" . "open file")
       :desc "Edit agenda file" "a" #'(lambda () (interactive) (find-file "~/Org/agenda.org"))
       :desc "Edit doom config.org" "c" #'(lambda () (interactive) (find-file "~/.config/doom/config.org"))
       :desc "Edit doom init.el" "i" #'(lambda () (interactive) (find-file "~/.config/doom/init.el"))
       :desc "Edit doom packages.el" "p" #'(lambda () (interactive) (find-file "~/.config/doom/packages.el"))))
(map! :leader
      (:prefix ("= e" . "open eshell files")
       :desc "Edit eshell aliases" "a" #'(lambda () (interactive) (find-file "~/.config/doom/eshell/aliases"))
       :desc "Edit eshell profile" "p" #'(lambda () (interactive) (find-file "~/.config/doom/eshell/profile"))))

(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)

(add-to-list 'org-structure-template-alist '("p" . "src python :session :results value"))

(defun org-setup ()
  ;; Keep haedings nice indented
  (org-indent-mode)

  ;; checkboxes
  (push '("[ ]" .  "☐") prettify-symbols-alist)
  (push '("[X]" . "☑" ) prettify-symbols-alist)
  ;; (push '("[X]" . "☒" ) prettify-symbols-alist)
  (push '("[-]" . "❍" ) prettify-symbols-alist)

  ;; org-babel
  (push '("#+BEGIN_SRC" . ?≫) prettify-symbols-alist)
  (push '("#+END_SRC" . ?≫) prettify-symbols-alist)
  (push '("#+begin_src" . ?≫) prettify-symbols-alist)
  (push '("#+end_src" . ?≫) prettify-symbols-alist)

  (push '("#+BEGIN_QUOTE" . ?❝) prettify-symbols-alist)
  (push '("#+END_QUOTE" . ?❞) prettify-symbols-alist)

  ;; (push '("#+BEGIN_SRC python" . ) prettify-symbols-alist) ;; This is the Python symbol. Comes up weird for some reason
  (push '("#+RESULTS:" . ?≚ ) prettify-symbols-alist)

  ;; drawers
  (push '(":PROPERTIES:" . ?) prettify-symbols-alist)

  ;; tags
  ;; (push '(":Misc:" . "" ) prettify-symbols-alist)

  (prettify-symbols-mode))

(use-package! org-mode
  :defer t
  :hook (org-mode . org-setup)
  :config)

(after! org
  (setq org-directory "~/Documents/org/"
        org-agenda-files '("~/Documents/org/agenda.org")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis "⬎" ;; …⤵ ▼ ⬎
        org-superstar-headline-bullets-list '("◉" "○" "●" "◆" "◉" "○" "●" "◆")
        org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-hide-emphasis-markers t
        org-fontify-whole-heading-line t

        ;; Automatically change bullet type when indenting
        ;; Ex: indenting a + makes the bullet a *.
        org-list-demote-modify-bullet '(("+" . "*") ("*" . "-") ("-" . "+"))

        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("google" . "http://www.google.com/search?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
            ("ddg" . "https://duckduckgo.com/?q=")
            ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-table-convert-region-max-lines 20000
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "BLOG(b)"           ; Blog writing assignments
             "GYM(g)"            ; Things to accomplish at the gym
             "PROJ(p)"           ; A project that contains other tasks
             "VIDEO(v)"          ; Video assignments
             "WAIT(w)"           ; Something is holding up this task
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" )))) ; Task has been cancelled

;;TODO: Move all functions implementing colorscheme to separate module "org-colorschemes".
(defun dt/org-colors-doom-one ()
  "Enable Doom One colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.5 "#51afef" ultra-bold)
         (org-level-2 1.4 "#c678dd" extra-bold)
         (org-level-3 1.3 "#98be65" bold)
         (org-level-4 1.2 "#da8548" semi-bold)
         (org-level-5 1.1 "#5699af" normal)
         (org-level-6 1.0 "#a9a1e1" normal)))
         ;; (org-level-7 1.0 "#46d9ff" normal)
         ;; (org-level-8 1.0 "#ff6c6b" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-dracula ()
  "Enable Dracula colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.5 "#8be9fd" ultra-bold)
         (org-level-2 1.4 "#bd93f9" extra-bold)
         (org-level-3 1.3 "#50fa7b" bold)
         (org-level-4 1.2 "#ff79c6" semi-bold)
         (org-level-5 1.1 "#9aedfe" normal)
         (org-level-6 1.0 "#caa9fa" normal)))
         ;; (org-level-7 1.1 "#5af78e" normal)
         ;; (org-level-8 1.0 "#ff92d0" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-gruvbox-dark ()
  "Enable Gruvbox Dark colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.5 "#458588" ultra-bold)
         (org-level-2 1.4 "#b16286" extra-bold)
         (org-level-3 1.3 "#98971a" bold)
         (org-level-4 1.2 "#fb4934" semi-bold)
         (org-level-5 1.1 "#83a598" normal)
         (org-level-6 1.0 "#d3869b" normal)))
         ;; (org-level-7 1.1 "#d79921" normal)
         ;; (org-level-8 1.0 "#8ec07c" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-monokai-pro ()
  "Enable Monokai Pro colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.5 "#78dce8" ultra-bold)
         (org-level-2 1.4 "#ab9df2" extra-bold)
         (org-level-3 1.3 "#a9dc76" bold)
         (org-level-4 1.2 "#fc9867" semi-bold)
         (org-level-5 1.1 "#ff6188" normal)
         (org-level-6 1.0 "#ffd866" normal)))
         ;; (org-level-7 1.1 "#78dce8" normal)
         ;; (org-level-8 1.0 "#ab9df2" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-nord ()
  "Enable Nord colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.5 "#81a1c1" ultra-bold)
         (org-level-2 1.4 "#b48ead" extra-bold)
         (org-level-3 1.3 "#a3be8c" bold)
         (org-level-4 1.2 "#ebcb8b" semi-bold)
         (org-level-5 1.1 "#bf616a" normal)
         (org-level-6 1.0 "#88c0d0" normal)))
         ;; (org-level-7 1.1 "#81a1c1" normal)
         ;; (org-level-8 1.0 "#b48ead" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-oceanic-next ()
  "Enable Oceanic Next colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.5 "#6699cc" ultra-bold)
         (org-level-2 1.4 "#c594c5" extra-bold)
         (org-level-3 1.3 "#99c794" bold)
         (org-level-4 1.2 "#fac863" semi-bold)
         (org-level-5 1.1 "#5fb3b3" normal)
         (org-level-6 1.0 "#ec5f67" normal)))
         ;; (org-level-7 1.1 "#6699cc" normal)
         ;; (org-level-8 1.0 "#c594c5" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-palenight ()
  "Enable Palenight colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.5 "#82aaff" ultra-bold)
         (org-level-2 1.4 "#c792ea" extra-bold)
         (org-level-3 1.3 "#c3e88d" bold)
         (org-level-4 1.2 "#ffcb6b" semi-bold)
         (org-level-5 1.1 "#a3f7ff" normal)
         (org-level-6 1.0 "#e1acff" normal)))
         ;; (org-level-7 1.1 "#f07178" normal)
         ;; (org-level-8 1.0 "#ddffa7" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-solarized-dark ()
  "Enable Solarized Dark colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.5 "#268bd2" ultra-bold)
         (org-level-2 1.4 "#d33682" extra-bold)
         (org-level-3 1.3 "#859900" bold)
         (org-level-4 1.2 "#b58900" semi-bold)
         (org-level-5 1.1 "#cb4b16" normal)
         (org-level-6 1.0 "#6c71c4" normal)))
         ;; (org-level-7 1.1 "#2aa198" normal)
         ;; (org-level-8 1.0 "#657b83" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-solarized-light ()
  "Enable Solarized Light colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.5 "#268bd2" ultra-bold)
         (org-level-2 1.4 "#d33682" extra-bold)
         (org-level-3 1.3 "#859900" bold)
         (org-level-4 1.2 "#b58900" semi-bold)
         (org-level-5 1.1 "#cb4b16" normal)
         (org-level-6 1.0 "#6c71c4" normal)))
         ;; (org-level-7 1.1 "#2aa198" normal)
         ;; (org-level-8 1.0 "#657b83" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(defun dt/org-colors-tomorrow-night ()
  "Enable Tomorrow Night colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.5 "#81a2be" ultra-bold)
         (org-level-2 1.4 "#b294bb" extra-bold)
         (org-level-3 1.3 "#b5bd68" bold)
         (org-level-4 1.2 "#e6c547" semi-bold)
         (org-level-5 1.1 "#cc6666" normal)
         (org-level-6 1.0 "#70c0ba" normal)))
         ;; (org-level-7 1.1 "#b77ee0" normal)
         ;; (org-level-8 1.0 "#9ec400" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

;; Load our desired dt/org-colors-* theme on startup
(add-hook 'org-mode-hook 'dt/org-colors-gruvbox-dark)

(setq org-journal-dir "~/Documents/org/journal/"
      org-journal-date-prefix "* "
      org-journal-time-prefix "** "
      org-journal-date-format "%B %d, %Y (%A) "
      org-journal-file-format "%Y-%m-%d.org")

;; (setq org-publish-use-timestamps-flag nil)
;; (setq org-export-with-broken-links t)
;; (setq org-publish-project-alist
;;       '(("distro.tube without manpages"
;;          :base-directory "~/nc/gitlab-repos/distro.tube/"
;;          :base-extension "org"
;;          :publishing-directory "~/nc/gitlab-repos/distro.tube/html/"
;;          :recursive t
;;          :exclude "org-html-themes/.*\\|man-org/man*"
;;          :publishing-function org-html-publish-to-html
;;          :headline-levels 4             ; Just the default for this project.
;;          :auto-preamble t)
;;       ))

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(map! :leader
      :desc "Switch to perspective NAME" "DEL" #'persp-switch
      :desc "Switch to buffer in perspective" "," #'persp-switch-to-buffer
      :desc "Switch to next perspective" "]" #'persp-next
      :desc "Switch to previous perspective" "[" #'persp-prev
      :desc "Add a buffer current perspective" "+" #'persp-add-buffer
      :desc "Remove perspective by name" "-" #'persp-remove-by-name)

;; (define-globalized-minor-mode global-rainbow-mode rainbow-mode
;;   (lambda () (rainbow-mode 1)))
;; (global-rainbow-mode 1)

(map! :leader
      (:prefix ("r" . "registers")
       :desc "Copy to register" "c" #'copy-to-register
       :desc "Frameset to register" "f" #'frameset-to-register
       :desc "Insert contents of register" "i" #'insert-register
       :desc "Jump to register" "j" #'jump-to-register
       :desc "List registers" "l" #'list-registers
       :desc "Number to register" "n" #'number-to-register
       :desc "Interactively choose a register" "r" #'counsel-register
       :desc "View a register" "v" #'view-register
       :desc "Window configuration to register" "w" #'window-configuration-to-register
       :desc "Increment register" "+" #'increment-register
       :desc "Point to register" "SPC" #'point-to-register))

(setq shell-file-name "/bin/zsh"
      vterm-max-scrollback 5000)
(setq eshell-rc-script "~/.config/doom/eshell/profile"
      eshell-aliases-file "~/.config/doom/eshell/aliases"
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))
(map! :leader
      :desc "Eshell" "e s" #'eshell
      :desc "Eshell popup toggle" "e t" #'+eshell/toggle
      :desc "Counsel eshell history" "e h" #'counsel-esh-history
      :desc "Vterm popup toggle" "v t" #'+vterm/toggle)

(defun prefer-horizontal-split ()
  (set-variable 'split-height-threshold nil t)
  (set-variable 'split-width-threshold 40 t)) ; make this as low as needed
(add-hook 'markdown-mode-hook 'prefer-horizontal-split)
(map! :leader
      :desc "Clone indirect buffer other window" "b c" #'clone-indirect-buffer-other-window)

(map! :leader
      (:prefix ("w" . "window")
       :desc "Winner redo" "<right>" #'winner-redo
       :desc "Winner undo" "<left>" #'winner-undo))

(map! :leader
      :desc "Zap to char" "z" #'zap-to-char
      :desc "Zap up to char" "Z" #'zap-up-to-char)

;; vterm terminal
(setq vterm-shell "zsh")

;; Use TAB to cycle through and insert completions at the same time
(company-tng-mode)

;; Cursor changing with changing mode in tty mode.
(use-package! evil-terminal-cursor-changer
  :hook (tty-setup . evil-terminal-cursor-changer-activate))

;; Disable blinking cursor in tty.
(setq visible-cursor nil)

;; Convenient mapping to toggle artist-mode
;; (map! :leader
;;       :desc "Toggle artist mode" "a t" #'artist-mode)

(setq org-plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")

(org-babel-do-load-languages
    'org-babel-load-languages
    '((python . t)
      (ditta . t)
      (plantuml . t)))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "hadouken"
      user-mail-address "hadouken@tilde.team")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:

(setq doom-font (font-spec :family "JetBrains Mono" :size 16 :weight 'bold)
     doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 16)
     doom-big-font(font-spec :family "JetBrains Mono" :size 18 :weight 'bold)
     doom-symbol-font(font-spec :flamily "JoyPixels" :size 16))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(map! :leader
      :desc "Comment or uncomment lines" "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
       :desc "Toggle line numbers" "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines" "t" #'toggle-truncate-lines))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type "relative")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
