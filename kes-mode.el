(eval-when-compile (require 'rx))

(defvar kes-mode-hook nil)

(defface kes-operator-face
  '((t :weight bold :inherit font-lock-highlighting-faces))
  "Face for operator"
  :group 'kes-mode)

(defconst kes-keywords
  '("그외" "선택"))

(defconst kes-operators
  '("/" "&" "|" "\\^" "*" "+" "%" "-" "<" ">" "#" "@" "[" "]" "?"))

(defconst kes-font-lock-keywords
  `(
    (,(regexp-opt kes-keywords  'symbols) . font-lock-keyword-face)
    (,(rx (in "ㄱ-ㅎㅏ-ㅣ가-힣_") (* (in "0-9ㄱ-ㅎㅏ-ㅣ가-힣_"))) (0 font-lock-builtin-face))
    (,(regexp-opt kes-operators) . 'kes-operator-face)
    (,(rx "$" (+ (in "0-9ㄱ-ㅎㅏ-ㅣ가-힣_"))) (0 font-lock-variable-name-face))))

(defvar kes-mode-syntax-table
  (let ((st (make-syntax-table)))

    (modify-syntax-entry ?/  "." st)
    (modify-syntax-entry ?&  "." st)
    (modify-syntax-entry ?|  "." st)
    (modify-syntax-entry ?^  "." st)
    (modify-syntax-entry ?*  "." st)
    (modify-syntax-entry ?+  "." st)
    (modify-syntax-entry ?=  "." st)
    (modify-syntax-entry ?%  "." st)
    (modify-syntax-entry ?@  "." st)
    (modify-syntax-entry ?#  "." st)
    (modify-syntax-entry ?<  "." st)
    (modify-syntax-entry ?>  "." st)
    (modify-syntax-entry ?\?  "." st)

    ;; Comment
    (modify-syntax-entry ?/  ". 124b" st)
    (modify-syntax-entry ?\n "> b"    st)

    ;; String quote
    (modify-syntax-entry ?'  "\"'" st)

    ;; Brackets
    (modify-syntax-entry ?{  "(}" st)
    (modify-syntax-entry ?}  "){" st)
    (modify-syntax-entry ?\[  "(]" st)
    (modify-syntax-entry ?\]  ")[" st)

    st))

(define-derived-mode kes-mode prog-mode "KES"
  "Major mode for kes Korean Era Script"

  :group 'kes-mode
  :syntax-table kes-mode-syntax-table

  (setq-local font-lock-defaults '(kes-font-lock-keywords))
  (setq-local comment-start-skip "\\(?://[/!]*\\|/\\*[*!]?\\)[[:space:]]*")
  (setq-local comment-multi-line nil)
  (setq-local electric-indent-mode t)
  (setq-local electric-indent-chars (list ?\n ?}))
  (setq-local tab-width 4)
  (defvaralias 'c-basic-offset 'tab-width)
  (defvaralias 'cperl-indent-level 'tab-width))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.kes\\'" . kes-mode))

(provide 'kes-mode)

