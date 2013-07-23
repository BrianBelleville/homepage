(in-package :homepage)

(defun home-link ()
  (a (:href "/") "Home"))

(defmacro common (title-phrase &body body-forms)
  "Common start to all views"
  `(progn
     (doctype-html)
     (html ()
	   (head ()
		 (meta (:http-equiv "content-type" :content "text/html; charset=utf-8"))
		 (title () ,title-phrase))
	   (body ()
		 ,@body-forms))))

(defview root (age)
  (declare (type fixnum age))
  (common "Brian Belleville"
	  (h1 () "Welcome to the homepage of Brian Belleville")
	  (p ()
	     "Welcome to my home page. Checkout my profile on "
	     (strong () (a (:href "https://github.com/BrianBelleville") "GitHub")) ". "
	     "I am currently " age " years old and employed at " (strong () "Western Digital") " in Southern California, here is my " (strong () (a (:href "/resume.pdf") "resume.")))))

(defview header-table ()
  (common "Brian Belleville - Http Header"
	  (h2 () "Http Header")
	  (p ()
	     "Here are the header fields and their values of the http request you made:")
	  (table ()
		 (tr ()
		     (th () "Header Field")
		     (th () "Value"))
		 (maphash (lambda (key val)
			    (tr ()
				(td () (symbol-name key))
				(td () val)))
			  *http-header*))
	  (p () (home-link))))

(defview query-string-test ()
  (common "Brian Belleville - Submit Request"
	  (h2 () "Enter data in the input feilds and submit for a personalized greeting.")
	  (form (:action "/get-request/greeting" :method "get")
		(div () "First Name:" (input (:type "text" :name "first-name")))
		(div () "Last Name:" (input (:type "text" :name "last-name")))
		(div () (input (:type "submit"))))))

(defview personalized-greeting (first last)
  (common "Brian Belleville - Personalized Greeting"
	  (h2 () "Hello " first " " last ", welcome to my homepage.")
	  (p () (home-link))))

(defview my-greeting ()
  (common "Brian Belleville - Personalized Greeting"
	  (h2 () "Hello Brian, welcome to your homepage.")
	  (p () (home-link))))

(defview scold-greeting ()
  (common "Brian Belleville - Personalized Greeting"
	  (h2 () "You entered forbidden characters.")
	  (p () "Only the alphabetic characters, SPACE, and \"-\" are allowed. You can " (a (:href "/get-request") "try again") ".")
	  (p () (home-link))))
