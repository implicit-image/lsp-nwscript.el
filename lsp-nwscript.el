
(require 'lsp-mode)

(defgroup lsp-nwscript nil
  "LSP support for NWScript"
  :group 'lsp-mode
  :link '(url-link "https://github.com/implicit-image/lsp-nwscript.el"))

(defcustom lsp-nwscript-server-path nil
  "Path to server.js"
  :type 'string
  :group 'lsp-nwscript)

(defcustom lsp-nwscript-server-args '("--stdio")
  "Arguments to pass to the server"
  :type '(repeat string)
  :risky t
  :group 'lsp-nwscript)

(lsp-defcustom lsp-nwscript-hover-function-comments nil
  "Whether to display function comments (using function comments as docs)"
  :type 'boolean
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.hovering.addCommentsToFunctions")


(lsp-defcustom lsp-nwscript-complete-function-params nil
  "Whether to autocpmlete function parameters"
  :type 'boolean
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.completion.addParamsToFunctions")

(lsp-defcustom lsp-nwscript-format-enabled nil
  "Whether to enable formatting"
  :type 'boolean
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.formatter.enabled")

(lsp-defcustom lsp-nwscript-format-verbose nil
  "Whether or not the formatter is verbose "
  :type 'boolean
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.formatter.verbose")

(lsp-defcustom lsp-nwscript-format-executable "clang-format"
  "Clang format executable path"
  :type 'string
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.formatter.executable")

(lsp-defcustom lsp-nwscript-format-ignore-globs ()
  "Glob patterns to ignore"
  :type '(repeat string)
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.formatter.ignoreGlobs")

;; (lsp-defcustom lsp-nwscript-format-style
;;   :type 'boolean
;;   :group 'lsp-nwscript
;;   :package-version '(lsp-mode . "8.0.1")
;;   :lsp-path "nwscript-ee-lsp.formatter.style")

(lsp-defcustom lsp-nwscript-compiler-enabled nil
  "Whether or not the compiler is enabled"
  :type 'boolean
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.enabled")


(lsp-defcustom lsp-nwscript-compiler-os nil
  "What compiler to use "
  :type '(choice :tag "Darwin" "Linux" "Windows" "Wine")
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.os")


(lsp-defcustom lsp-nwscript-compiler-verbose nil
  "Whether or not the compiler is verbose"
  :type 'boolean
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.verbose")


(lsp-defcustom lsp-nwscript-compiler-report-warnings nil
  "Whether or not the compiler should report warnings"
  :type 'boolean
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.reportWarnings")

;; (lsp-defcustom lsp-nwscript-game-version-assocs ()
;;   " '(\"/home/user/projects/project1\" . \"\")"
;;   :type 'alist
;;   :group 'lsp-nwscript
;;   :package-version '(lsp-mode . "8.0.1")
;;   :lsp-path "nwscript-ee-lsp.compiler.includes")

;; ;; TODO: check if this can be done at initialization
;; (lsp-defcustom lsp-nwscript-compiler-additional-includes
;;   :type 'plist
;;   :group 'lsp-nwscript
;;   :package-version '(lsp-mode . "8.0.1")
;;   :lsp-path "nwscript-ee-lsp.compiler.includes")

;; TODO: check if this can be done at initialization
(lsp-defcustom lsp-nwscript-compiler-game-includes nil
  "List of include directories"
  :type '(repeat string)
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.gameIincludes")

(lsp-defcustom lsp-nwscript-compiler-nwn-home nil
  "NWN home directory"
  :type 'string
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.nwnHome")

(lsp-defcustom lsp-nwscript-compiler-nwn-installation nil
  "NWN installation directory"
  :type 'string
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.nwnInstallation")


(defun lsp-nwscript--server-command ()
  "Generate LSP startup command for nwscript-ee-language-server"
   '("node" lsp-nwscript-server-path lsp-nwscript-server-args))

(lsp-register-custom-settings
 '(
   ("nwscript-ee-lsp.hovering.addCommentsToFunctions" lsp-nwscript-hover-function-comments t)
   ("nwscript-ee-lsp.completion.addParamsToFunctions" lsp-nwscript-complete-function-params t)
   ("nwscript-ee-lsp.formatter.enabled" lsp-nwscript-format-enabled t)
   ("nwscript-ee-lsp.formatter.executable" lsp-nwscript-format-executable)
   ("nwscript-ee-lsp.formatter.ignoreGlobs"lsp-nwscript-format-ignore-globs t)
   ;; ("nwscript-ee-lsp.formatter.style" lsp-nwscript-format-style)
   ("nwscript-ee-lsp.compiler.nwnHome" lsp-nwscript-compiler-nwn-installation)
   ("nwscript-ee-lsp.compiler.nwnHome" lsp-nwscript-compiler-nwn-home)
   ("nwscript-ee-lsp.compiler.verbose" lsp-nwscript-compiler-verbose t)
   ("nwscript-ee-lsp.compiler.enabled" lsp-nwscript-compiler-enabled t)
   ("nwscript-ee-lsp.compiler.reportWarnings" lsp-nwscript-compiler-report-warnings t)
   ("nwscript-ee-lsp.compiler.os" lsp-nwscript-compiler-os)
   ("nwscript-ee-lsp.compiler.gameIncludes" lsp-nwscript-compiler-game-includes)
   ))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection #'lsp-nwscript--server-command)
                  :major-modes '(nwscript-mode)
                  :priority -1
                  :server-id 'nwscript-ls))

(lsp-consistency-check lsp-nwscript)

(provide 'lsp-nwscript)
