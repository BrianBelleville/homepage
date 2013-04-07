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
      "Welcome to my home page, this site was " (strong () "generated and served")
      " by a web application layer " (strong () "entirely written by me")
      ". The code for this site and this server was written in " (strong ()
                                                                   "Common Lisp")
      ". The code for this site is available on "
      (strong () (a (:href "https://github.com/BrianBelleville") "GitHub"))
      "I am currently " age " years old and employed at " (strong () "Western Digital") " in Southern California. You can view my " (strong () (a (:href "/resume.pdf") "resume")))
    (p ()
      "Here are links to pages created to test and demonstrate functionality of the server and framework:")
    (ul ()
      (li ()
        (strong () (a (:href "/http-header") "Access to http header fields")))
      (li ()
        (strong () (a (:href "/get-request") "Parsing the query string of a get request"))))))

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
