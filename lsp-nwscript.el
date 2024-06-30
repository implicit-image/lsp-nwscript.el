;;; package --- LSP support for nwscript

;;; Commentary:

;;; Code:

(require 'lsp-mode)

(defgroup lsp-nwscript nil
  "LSP support for NWScript."
  :group 'lsp-mode
  :link '(url-link "https://github.com/implicit-image/lsp-nwscript.el")
  :package-version '(lsp-mode . "8.0.1"))

(defcustom lsp-nwscript-server-type "node"
  "What server to use."
  :type '(choice
          (const "node" :doc "Use https://github.com/PhilippeChab/nwscript-ee-language-server")
          (const "py" :doc "CLIENT NOT READY YET!!!\nUse https://github.com/jd28/nwscript-lsp"))
  :group 'lsp-nwscript
  :package-version '(lsp-mode . "8.0.1"))

(defgroup lsp-nwscript-node nil
  "LSP support for NWScript, using nwscript-ee-language-server."
  :group 'lsp-mode
  :link '(url-link "https://github.com/PhilippeChab/nwscript-ee-language-server")
  :package-version '(lsp-mode . "8.0.1"))

(defgroup lsp-nwscript-py nil
  "LSP support for NWScript, using nwscript-lsp."
  :group 'lsp-mode
  :link '(url-link "https://github.com/jd28/nwscript-lsp")
  :package-version '(lsp-mode . "8.0.1"))

(defcustom lsp-nwscript-node-server-path nil
  "Path to server.js."
  :type 'string
  :group 'lsp-nwscript-node)

(defcustom lsp-nwscript-node-server-args '("--stdio")
  "Arguments to pass to the server."
  :type '(repeat string)
  :risky t
  :group 'lsp-nwscript-node)

(lsp-defcustom lsp-nwscript-node-hover-function-comments nil
  "Whether to display function comments (using function comments as docs)."
  :type 'boolean
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.hovering.addCommentsToFunctions")


(lsp-defcustom lsp-nwscript-node-complete-function-params nil
  "Whether to autocpmlete function parameters."
  :type 'boolean
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.completion.addParamsToFunctions")

(lsp-defcustom lsp-nwscript-node-format-enabled nil
  "Whether to enable formatting."
  :type 'boolean
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.formatter.enabled")

(lsp-defcustom lsp-nwscript-node-format-verbose nil
  "Whether or not the formatter is verbose."
  :type 'boolean
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.formatter.verbose")

(lsp-defcustom lsp-nwscript-node-format-executable "clang-format"
  "Clang format executable path."
  :type 'string
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.formatter.executable")

(lsp-defcustom lsp-nwscript-node-format-ignore-globs ()
  "Glob patterns to ignore."
  :type '(repeat string)
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.formatter.ignoreGlobs")

(lsp-defcustom lsp-nwscript-node-compiler-enabled nil
  "Whether or not the compiler is enabled."
  :type 'boolean
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.enabled")


(lsp-defcustom lsp-nwscript-node-compiler-os nil
  "What compiler to use."
  :type '(choice
          (const "Darwin")
          (const "Linux")
          (const "Windows"))
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.os")


(lsp-defcustom lsp-nwscript-node-compiler-verbose nil
  "Whether or not the compiler is verbose."
  :type 'boolean
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.verbose")


(lsp-defcustom lsp-nwscript-node-compiler-report-warnings nil
  "Whether or not the compiler should report warnings."
  :type 'boolean
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.reportWarnings")

(lsp-defcustom lsp-nwscript-node-compiler-nwn-home nil
  "NWN home directory."
  :type 'string
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.nwnHome")

(lsp-defcustom lsp-nwscript-node-compiler-nwn-installation nil
  "NWN installation directory."
  :type 'string
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1")
  :lsp-path "nwscript-ee-lsp.compiler.nwnInstallation")

(defcustom lsp-nwscript-node-extra-server-settings nil
  "Use this to pass extra server configuration options. Same syntax as \
`lsp-register-custom-settings'."
  :type 'alist
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1"))

(defcustom lsp-nwscript-node-local-includes-alist nil
  "FOR USE ONLY WITH lsp-ee-language-server FORK!!!\n
You can find it here: https:\\\\github.com/implicit-image/nwscript-ee-language-server\n
An alist of project paths and lists of corresponding include directories. If an include path
starts with \".\" it will be appended to project path.\n
`(setq lsp-nwscript-node-local-includes-alist
                        '((\"path/to/project\"
                                '(\"/absolute/path/to/include/dir1\" \"./relative/path/to/include/dir2\"))))'"
  :type '(alist)
  :group 'lsp-nwscript-node
  :package-version '(lsp-mode . "8.0.1"))


(defun lsp-nwscript-node--server-command ()
  "Generate LSP startup command for nwscript-ee-language-server."
  (append `("node" ,lsp-nwscript-node-server-path) lsp-nwscript-node-server-args))

(defun lsp-nwscript-node--find-executable ()
  "Find executables needed for nwscript-ee-language-server."
  (and (executable-find "node")
       (or (file-exists-p lsp-nwscript-node-server-path)
           (file-symlink-p lsp-nwscript-node-server-path))))

(defun lsp-nwscript--get-includes-for-workspace (root-dir)
  "Chooses which folder are local includes in based on workspace root ROOT-DIR."
  (cond ((length< root-dir 1) '())
        (t (let ((matching (cl-remove-if
                            (lambda (el) (not (string-equal-ignore-case (car el) root-dir)))
                            lsp-nwscript-node-local-includes-alist)))
             (cond ((length< matching 1) '())
                   (t (car (cdr (car matching)))))))))


(defun lsp-nwscript-node--init-fn (workspace)
  "Initializatio function."
  (let* ((root-dir (lsp--workspace-root workspace))
         (includes (lsp-nwscript--get-includes-for-workspace root-dir))
         (absolute-includes (mapcar (lambda (inc) (f-join root-dir inc)) (eval includes)))
         (settings (append
                    lsp-nwscript-node-extra-server-settings
                    `(("nwscript-ee-lsp.compiler.workspaceIncludes" ,absolute-includes t)))))
    (lsp-register-custom-settings settings)))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection #'lsp-nwscript-node--server-command #'lsp-nwscript-node--find-executable)
                  :activation-fn (lsp-activate-on "nwscript")
                  :initialized-fn #'lsp-nwscript-node--init-fn
                  :priority -1
                  :server-id 'nwscript-ls))

(lsp-consistency-check lsp-nwscript)

(provide 'lsp-nwscript)
;;; lsp-nwscript.el ends here.
