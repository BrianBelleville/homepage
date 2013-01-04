(asdf:defsystem "homepage"
  :description "The code for my homepage"
  :author "Brian Belleville"
  :depends-on (:first-gen)
  :components ((:file "package")
		(:file "views" :depends-on ("package"))
		(:file "handlers" :depends-on ("package" "views"))))