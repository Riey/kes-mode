(eval-when-compile (require 'rx))

(defvar kes-mode-hook nil)

(defface kes-operator-face
  '((t :weight bold :inherit font-lock-highlighting-faces))
  "Face for operator"
  :group 'kes-mode)

(defconst kes-keywords
  '("그외" "선택" "종료" "반복" "만약" "혹은"))

(defconst kes-operators
  '("/" "&" "|" "\\^" "*" "+" "%" "-" "<" ">" "#" "@" "[" "]" "?"))

(defconst kes-font-lock-keywords
  `(
    (,(regexp-opt kes-keywords  'symbols) . font-lock-keyword-face)
    (,(rx (group (in "a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣_") (* (in "0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣_"))) "(") (1 font-lock-function-name-face))
    (,(rx (in "a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣_") (* (in "0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣_"))) (0 font-lock-builtin-face))
    (,(regexp-opt kes-operators 'words) . 'kes-operator-face)
    (,(rx "$" (+ (in "0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣_"))) (0 font-lock-variable-name-face))))

(defvar kes-mode-syntax-table
  (let ((st (make-syntax-table)))

    (modify-syntax-entry ?/  "." st)
    (modify-syntax-entry ?\  "." st)
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
    (modify-syntax-entry ?\"  "." st)

    ;; Comment
    (modify-syntax-entry ?\; "<" st)
    (modify-syntax-entry ?\n ">" st)

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
  (setq-local comment-use-syntax t)
  (setq-local comment-start ";")
  (setq-local comment-multi-line nil)
  (setq-local tab-width 4)
  (defvaralias 'c-basic-offset 'tab-width)
  (defvaralias 'cperl-indent-level 'tab-width))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.kes\\'" . kes-mode))

(provide 'kes-mode)

