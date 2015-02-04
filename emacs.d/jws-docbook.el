;;; jws-docbook.el
;;; by Jeremy W. Sherman <jeremyw.sherman@gmail.com>
;;;
;;; Tools to help when editing DocBook.
(define-skeleton jws-fig-skel
  "Insert a <figure> element skeleton."
  nil
      \n
      >"<figure xml:id=\"" - (or
			      (read-string "xml:id: " nil nil "fig-")
			      "fig-XXX") "\" pgwide=\"0\">" \n
      >"<title>" - (or
		    (read-string "title: ")
		    "XXX") "</title>" \n \n
      >"<mediaobject>" \n
      >"<imageobject>" \n
      >"<imagedata fileref=\"" - (or (read-string "path: " nil nil "fig/")
				     "XXX") "\" scale=\"40\" format=\""
      - (or (read-string "format" nil nil "PNG") "XXX") "\" />" \n
      >"</imageobject>" \n
      >"<textobject>" \n
      >"<phrase>" \n
      > - (or (read-string "brief description: ") "A brief description") \n
      >"</phrase>" \n
      >"</textobject>" \n
      >"<textobject>" \n
      >"<para>" \n
      > - (or (read-string "alt text: ") "A longer description.") \n
      >"</para>" \n
      >"</textobject>" \n
      >"</mediaobject>" \n
      >"</figure>"
)
(define-skeleton jws-citerefentry-skel
  "Insert a <citerefentry> element skeleton."
  nil
  \n
  "<citerefentry>" \n
	>"<refentrytitle>" - (or (read-string "func: ") "read")
	 "</refentrytitle>" \n
	 "<manvolnum>" - (or (read-string "manvolnum: " nil nil "2") "2")
	 "</manvolnum>" \n
  "</citerefentry>"\n)
(define-skeleton jws-skel-bullet-list
  "Builds a bulleted <itemizedlist>."
  nil
  \n
  "<itemizedlist>" \n
  ("paragraph body: " "<listitem><para>" \n str \n "</para></listitem>") \n
  "</itemizedlist>" \n)
