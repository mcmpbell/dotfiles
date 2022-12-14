(require 'package)

;; remove annoying cl deprecation warning (not like i'm gonna fix it)
(setq byte-compile-warnings '(cl-functions))

;; terminal vs gui themeing
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

;; add MELPA
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; define load path/load stuff
(add-to-list 'load-path "~/.emacs.d/files")
(load "dired+.el")
(load "fill-column-indicator.el")

;; fill column stuff
(add-hook 'prog-mode-hook 'fci-mode)
(setq-default fill-column 80)
(setq fci-rule-color "white")

;; change emacs backup directory
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "emacs-backup"))))

;; stuff from sensible-defaults
(setq gc-cons-threshold 20000000)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'prog-mode-hook 'subword-mode)
(setq sentence-end-double-space nil)
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)
(setq vc-follow-symlinks t)
  (add-hook 'before-save-hook
            (lambda ()
              (when buffer-file-name
                (let ((dir (file-name-directory buffer-file-name)))
                  (when (and (not (file-exists-p dir))
                             (y-or-n-p
			      (format "Directory %s does not exist. Create it?"
				      dir)))
                    (make-directory dir t))))))
(delete-selection-mode t)
(setq require-final-newline t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq-default dired-listing-switches "-alh")
(global-font-lock-mode t)

;; stuff from first .emacs file, settings
(defalias 'yes-or-no-p 'y-or-n-p)
(show-paren-mode 1)
(setq show-paren-delay 0)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode 1)
(tab-bar-mode -1)
(set-face-attribute 'default nil :font "Hack-11")
(setq visible-bell 1)
(global-set-key (kbd "C-x t") 'term)
(cua-mode t)
(transient-mark-mode 1)
(auto-save-visited-mode 1)
(setq make-backup-files nil)
(windmove-default-keybindings)
(setq windmove-wrap-around t)
(set-face-bold-p 'bold nil)
(add-hook 'after-init-hook 'global-flycheck-mode)
(add-hook 'after-init-hook 'global-company-mode)

;; company stuff
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)
(setq company-selection-wrap-around t)
(company-tng-configure-default)

;; jedi company backend
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

(global-unset-key [mouse-2])
(setq frame-resize-pixelwise t)
(toggle-diredp-find-file-reuse-dir 1)
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; org mode
(setq org-hide-emphasis-markers t)
(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


;; (find-file "~/.commands.org")

;; custom set variables section
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#272822" "#F92672" "#A6E22E" "#E6DB74" "#66D9EF" "#FD5FF0" "#A1EFE4" "#F8F8F2"])
 '(compilation-message-face 'default)
 '(custom-enabled-themes '(zenburn))
 '(custom-safe-themes
   '("2dc03dfb67fbcb7d9c487522c29b7582da20766c9998aaad5e5b63b5c27eec3f" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "735561d82728e28f275802fc875c3a2caf14d06f434604a7516c59d49120b163" "91964f59704afb8941929ff19894e3ae5b614c2a29ccb72c8b2bbf0502c8054d" "e8882a809fb14f2307410a659846a06bfa58a2279ffb1f5aca0c3aecbcb6aaee" "f028e1985041fd072fa9063221ee9c9368a570d26bd6660edbd00052d112e8bb" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" default))
 '(fci-rule-color "#3C3D37")
 '(highlight-changes-colors '("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   '(("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100)))
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(magit-diff-use-overlays nil)
 '(org-fontify-done-headline nil)
 '(org-fontify-todo-headline nil)
 '(package-selected-packages
   '(company-jedi flycheck company zenburn-theme spacemacs-theme treemacs org-bullets monokai-theme magit gruvbox-theme))
 '(pdf-view-midnight-colors '("#fdf4c1" . "#1d2021"))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
