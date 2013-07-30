;;; ert-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ert-run-tests-interactively deftest) "ert" "ert.el"
;;;;;;  (20015 29173))
;;; Generated autoloads from ert.el

(autoload (quote deftest) "ert" "\
Define NAME (a symbol) as a test.

\(fn NAME () [:documentation DOCSTRING] [:expected-result TYPE] BODY...)" nil (quote macro))

(autoload (quote ert-run-tests-interactively) "ert" "\
Run the tests specified by SELECTOR and display the results in a buffer.

\(fn SELECTOR &optional OUTPUT-BUFFER-NAME MESSAGE-FN)" t nil)

;;;***

;;;### (autoloads nil nil ("ert-pkg.el") (20015 29173 589368))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ert-autoloads.el ends here
