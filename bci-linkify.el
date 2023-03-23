; -*- lexical-binding: t -*-

;;;###autoload
(defun bci-linkify-header-content (link-destination)
  "Linkify Org header text."
  (interactive "MDestination: ")
  (save-excursion
    (beginning-of-line)
    (when (looking-at org-heading-regexp)
      (let ((data (nthcdr 4 (match-data 'integers))))
        (seq-let (content-start content-end) data
          (let ((content (buffer-substring-no-properties content-start content-end)))
            (goto-char content-start)
            (delete-region content-start content-end)
            (org-insert-link nil link-destination content)))))))

(provide 'bci-linkify)
