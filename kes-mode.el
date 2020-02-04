(defvar kes-mode-hook nil)

(defface kes-operator-face
  '((t :weight bold :inherit font-lock-highlighting-faces))
  "Face for operator"
  :group 'kes-mode)

(defconst kes-keywords
  '("그외" "선택"))

(defconst kes-builtins
  '("랜덤" "이름" "주인이름" "호칭" "주인호칭" "애칭" "주인애칭" "별명" "주인별명" "연모" "음란" "복종" "키스한다" "이전커맨드" "처음" "키스한다" "굴복각인"))

(defconst kes-operators
  '("/" "&" "|" "\\^" "*" "+" "%" "=" "!" "<" ">"))

(defconst kes-font-lock-keywords
  `(
    (,(regexp-opt kes-keywords  'symbols) . font-lock-keyword-face)
    (,(regexp-opt kes-builtins  'symbols) . font-lock-builtin-face)
    (,(regexp-opt kes-operators) . 'kes-operator-face)
    (,(rx (group "$") (group (+ (in "0-9ㄱ-ㅎㅏ-ㅣ가-힣_")))) (0 'kes-operator-face) (1 font-lock-variable-name-face))))

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
    (modify-syntax-entry ?!  "." st)
    (modify-syntax-entry ?<  "." st)
    (modify-syntax-entry ?>  "." st)

    ;; Comment
    (modify-syntax-entry ?/  ". 124b" st)
    (modify-syntax-entry ?\n "> b"    st)

    ;; String quote
    (modify-syntax-entry ?'  "\"'" st)
    (modify-syntax-entry ?{  "(} \\}")

    ;; Brackets
    (modify-syntax-entry ?{  "(}" st)
    (modify-syntax-entry ?}  "){" st)
    (modify-syntax-entry ?\(  "()" st)
    (modify-syntax-entry ?\)  ")(" st)

    st))

(define-derived-mode kes-mode prog-mode "KES"
  "Major mode for kes Korean Era Script"

  :group 'kes-mode
  :syntax-table kes-mode-syntax-table

  (setq-local font-lock-defaults '(kes-font-lock-keywords))
  (setq-local comment-start-skip "\\(?://[/!]*\\|/\\*[*!]?\\)[[:space:]]*")
  (setq-local comment-multi-line nil)
  (setq-local
   electric-indent-chars (cons ?} (and (boundp 'electric-indent-chars)
                                       electric-indent-chars))))

(add-to-list 'auto-mode-alist '("\\.kes\\'" . kes-mode))

(provide 'kes-mode)

