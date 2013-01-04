(in-package :homepage)

(let ((birthday (encode-universal-time 0 0 0 11 2 1989 8)))
  (defget "/" ()
    (multiple-value-bind
	  (sec min hour day month year day-week daylight-savings time-zone)
	(decode-universal-time
	 (- (get-universal-time) birthday) 8)
      (declare (ignore sec min hour day month day-week daylight-savings time-zone))
      (root (- year 1900)))))