(eval-when-compile (require 'rx))

(defvar kes-mode-hook nil)

(defconst kes-keywords
  '("그외" "선택" "종료" "반복" "만약" "혹은"))

(defconst kes-operators
  '("/" "&" "|" "\\^" "*" "+" "%" "-" "~" "<" ">" "=" "~=" "<=" ">=" "#" "@" "[+]" "[-]" "[?]" "[!]"))

(defconst kes-font-lock-keywords
  `(
    (,(regexp-opt kes-keywords  'symbols) . font-lock-keyword-face)
    (,(rx (group (in "a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣_") (* (in "0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣_"))) (* (in " \r\n\t")) "(") (1 font-lock-function-name-face))
    (,(rx (in "a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣_") (* (in "0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣_"))) (0 font-lock-builtin-face))
    (,(regexp-opt kes-operators 'words) . font-lock-warning-face)
    (,(rx (group "[") (group "$" (+ (in "0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣_"))) (group "]")) (1 font-lock-warning-face) (2 font-lock-variable-name-face) (3 font-lock-warning-face))
    (,(rx "$" (+ (in "0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣_"))) (0 font-lock-variable-name-face))))

(defvar kes-mode-syntax-table
  (let ((st (make-syntax-table)))
    ;; Comment
    (modify-syntax-entry ?\; "<" st)
    (modify-syntax-entry ?\n ">" st)

    ;; String quote
    (modify-syntax-entry ?'  "\"'" st)

    ;; Brackets
    (modify-syntax-entry ?{  "(}" st)
    (modify-syntax-entry ?}  "){" st)
    (modify-syntax-entry ?\[ "(]" st)
    (modify-syntax-entry ?\] ")[" st)
    (modify-syntax-entry ?\( "()" st)
    (modify-syntax-entry ?\) ")(" st)

    st))

(defvar kes-indent-offset 4)

(defun kes-indent-line ()
  (interactive)
  (let ((indent 0))
    (save-excursion
      (beginning-of-line)
      (condition-case nil
          (while t
            (backward-up-list)
            (when (looking-at "[{(]")
              (setq indent (+ indent kes-indent-offset))))
        (error nil)))
    (save-excursion
      (back-to-indentation)
      (when (and (looking-at "[})]") (>= indent kes-indent-offset))
        (setq indent (- indent kes-indent-offset))))
    (indent-line-to indent)))

(defvar kes-mode-map nil)
(setq kes-mode-map
      (let ((map (make-sparse-keymap)))
        (define-key map (kbd "RET") 'newline-and-indent)
        map))

(define-derived-mode kes-mode prog-mode "KES"
  "Major mode for kes Korean Era Script"

  :group 'kes-mode
  :syntax-table kes-mode-syntax-table

  (setq-local font-lock-defaults '(kes-font-lock-keywords))
  (setq-local comment-use-syntax t)
  (setq-local comment-start ";")
  (setq-local comment-end "")
  (setq-local comment-multi-line nil)
  (setq-local indent-line-function 'kes-indent-line))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.kes\\'" . kes-mode))

(provide 'kes-mode)

