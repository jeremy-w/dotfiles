(defun bnr-markup-diff (start end)
  "Converts first-column diff annotation into <new> and <del>
  markup for all lines including START and END."
  (interactive "r")
  (save-excursion
    ;; adjust START/END to START/END of their lines
    (goto-char start)
    (setq start (beginning-of-line))
    (goto-char end)
    (setq end (end-of-line))
    ;; find runs of +/- and insert lines with <new>/<del>
    ;; search-forward-regexp +/-, bookmark, then for the other or none, then wrap
    ))
