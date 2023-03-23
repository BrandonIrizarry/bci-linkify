; -*- lexical-binding: t -*-

(defun bci/--prelinkify ()
  "Format the relevant text using the Org link format.

Another function inserts the link destination."
  (pcase-let ((`(,r1 . ,r2) (if (use-region-p)
                                (car (region-bounds))
                              (bounds-of-thing-at-point 'word))))
    (let ((text (buffer-substring-no-properties r1 r2)))
      (delete-region r1 r2)        ; Get rid of the original text
      (insert (with-temp-buffer    ; Create and insert the link format
                (insert text)
                (beginning-of-buffer)
                (insert "[[][")
                (end-of-buffer)
                (insert "]]")
                (buffer-string))))))

(defun bci/linkify (link)
  "Linkify the current region.

If no region, use the current word."
  (interactive "MLink: ")
  (save-excursion
    (bci/--prelinkify)

    ;;Note: `bci/--prelinkify' assumes we've ended up at the far-right
    ;;of the formatted text. Now we have to move backward to insert
    ;;the link.
    (re-search-backward "\\[]")

    (forward-char)
    (insert link)))

(bind-key "C-c l" #'bci/linkify org-mode-map)
