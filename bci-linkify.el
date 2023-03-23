; -*- lexical-binding: t -*-

;;;###autoload
(defun bci-linkify-header-content (link-destination)
  "Linkify Org header text.

If on a line containing an Org header, make the header text into
a link pointing to LINK-DESTINATION.

Else, do nothing and return NIL."
  (interactive "MDestination: ")
  (save-excursion
    (beginning-of-line)
    (when (looking-at org-heading-regexp)
      ;; nthcdr: skip to the header content's match-data
      ;; See documentation for 'match-data'
      (let ((data (nthcdr 4 (match-data 'integers))))
        (seq-let (content-start content-end) data
          (let ((content (buffer-substring-no-properties content-start content-end)))
            (goto-char content-start)
            (delete-region content-start content-end)
            (org-insert-link nil link-destination content)))))))

(provide 'bci-linkify)
