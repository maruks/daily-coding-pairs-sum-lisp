(defsystem "pairs-sum"
  :description "daily coding exercise pairs-sum"
  :author "Maris Orbidans"
  :licence "Public Domain"
  :version "0.0.1"
  :serial t
  :components ((:module "src"
		:serial t
		:components ((:file "pairs-sum"))))
  :in-order-to ((test-op (test-op "pairs-sum/tests"))))

(defsystem "pairs-sum/tests"
  :licence "Public Domain"
  :depends-on (:pairs-sum
	       :check-it
	       :fiasco)
  :serial t
  :components ((:module "tests"
		:components ((:file "pairs-sum-tests"))))
  :perform (test-op (o c) (symbol-call 'fiasco 'all-tests)))
