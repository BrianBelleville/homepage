(in-package :homepage)

(let ((birthday (encode-universal-time 0 0 0 11 2 1989 8)))
  (defget "/" ()
    (multiple-value-bind
	  (sec min hour day month year day-week daylight-savings time-zone)
	(decode-universal-time
	 (- (get-universal-time) birthday) 8)
      (declare (ignore sec min hour day month day-week daylight-savings time-zone))
      (root (- year 1900)))))

(defget "/http-header" ()
  (header-table))

(defget "/get-request" ()
  (query-string-test))

(declaim (inline safe-string-p))
(defun safe-string-p (string)
  "returns true if the string is only composed of alphabetic characters or #\space or #\-"
  (declare (type string string))
  (not (find-if (lambda (char)
		  (declare (type character char))
		  (not (or
			(alpha-char-p char)
			(find char (list #\space #\-)))))
		string)))

(let ((my-first-name "brian")
      (my-last-name "belleville"))
  (defget "/get-request/greeting" (first-name last-name)
    (cond ((not (and
		 (safe-string-p first-name)
		 (safe-string-p last-name)))
	   (scold-greeting))
	  ((and (string-equal first-name my-first-name)
		(string-equal last-name my-last-name))
	   (my-greeting))
	  (t (personalized-greeting first-name last-name)))))