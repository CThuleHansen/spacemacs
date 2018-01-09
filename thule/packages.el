;;; packages.el --- thule layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Casper Thule Mathiasen <casperthule@Caspers-MBP>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `thule-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `thule/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `thule/pre-init-PACKAGE' and/or
;;   `thule/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:
;;;; This is to download the packages, NOT to install them.
(defconst thule-packages
  '( auctex )
  "The list of Lisp packages required by the thule layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

;; This init function causes auctex to be installed.
(defun thule/init-auctex ()
  ;;The reason for this weird thing is, that auctex overrides the tex package.
  ;;http://cachestocaches.com/2015/8/getting-started-use-package/
  (use-package tex
    ;;:ensure auctex ;This is not necessary, as auctex will have been downloaded and installed.
    :config

    ;; Indent items by two spaces.
    (setq LaTeX-item-indent 0)
    (setq TeX-PDF-mode t)
    (setq-default TeX-master nil) ; Query for master file.

    ;; Generate sync file and sync with C-v
    (eval-after-load
        "tex" '(add-to-list 'TeX-command-list
                            '("latexmk" "latexmk -pdf %t --synctex=1" TeX-run-TeX)))

    (setq latex-run-command "pdflatex")
    (setq LaTeX-command "latex --synctex=1")

    ;; Use pdf-tools to open PDF files
    (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
          TeX-source-correlate-start-server t
          TeX-source-correlate-method 'synctex)

    (setq TeX-auto-save t
          TeX-parse-self t)

    ;; Needed to sync TeX and PDF
    (add-hook 'LaTeX-mode-hook
              '(lambda ()
                 (TeX-source-correlate-mode 1)))

    (add-hook 'TeX-after-compilation-finished-functions
              #'TeX-revert-document-buffer)

    ;; (add-hook 'pdf-view-mode-hook 'auto-revert-mode)
    ;; (setq auto-revert-interval 0.5)

    (add-hook 'pdf-view-mode-hook
              (lambda ()
                (pdf-view-fit-page-to-window) ))

    ;; LateX keywords that need colouring
    (setq font-latex-match-reference-keywords
          '(
            ("ac" "[{")
            ("todo" "[{")
            ("kw" "[{")
            ("vsl" "[{")
            ("vpp" "[{")
            ("vrt" "[{")
            ("acp" "[{")
            ("contribution" "[{")
            ("acrodef" "[{")
            ("crefName" "[{")
            ("cref" "[{")
            ("Cref" "[{")
            ("cnref" "[{")
            ("vdmkw" "[{")
            ))

    (add-hook 'LaTeX-mode-hook
              '(lambda ()
                 (reftex-mode))))
  )
;;; packages.el ends here
