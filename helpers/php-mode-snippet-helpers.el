;;; php-mode-snippet-helpers.el --- snippet helpers for PHP-mode -*- lexical-binding: t -*-

;; Contains helper functions that could be of help in `php-mode' snippets.

;;; Commentary:

;;; Code:
(require 's)
(require 'dash)

(defun php-snippets-extract-variable-names-from-signature (signature)
  "Retrieve a list of variable names from a string SIGNATURE.
For instance, given the signature \"Foo $bar, $baz\", return
'(\"bar\", \"baz\")."
  (--> signature
       (split-string it ",")
       (mapcar (lambda (maybe-typehinted-name)
                 (--> maybe-typehinted-name
                      (s-trim it)
                      (split-string it)
                      (-last-item it)
                      (substring it (if (s-starts-with? "$" it) 1))))
               it)))

(defun php-snippets-guess-namespace (&optional namespace-root)
  "Guess the current class namespace."
  (--> (spacemacs--projectile-directory-path)
       (directory-file-name it)
       (string-remove-prefix (concat namespace-root "/") it)
       (subst-char-in-string ?/ ?\\ it)
       (upcase-initials it)))

;;; _
(provide 'php-mode-snippet-helpers)
;;; php-mode-snippet-helpers.el ends here
