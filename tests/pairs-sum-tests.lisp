(fiasco:define-test-package :pairs-sum-tests
  (:use :pairs-sum :fiasco :check-it))

(in-package :pairs-sum-tests)

(defun test-gen ()
  (generator (tuple (integer 10 20) (list (integer 1) :min-length 1) (list (integer 1) :min-length 1))))

(defun result-correct? (pair xs ys target)
  (let* ((x (car pair))
	 (y (cdr pair))
	 (d (abs (- target (+ x y))))
	 (pairs (all-pairs xs ys)))
    (every (lambda (p) (<= d (abs (- target (+ (car p) (cdr p)))))) pairs)))

(deftest simple-pair-sum-test ()
  (let ((*num-trials* 1000)
	(*size* 20))
    (is (check-it (test-gen)
                  (lambda (x) (let ((target (car x))
				    (xs (cadr x))
				    (ys (caddr x)))
                                (is (result-correct? (simple-min-sum xs ys target) xs ys target))))))))

(deftest pair-sum-test ()
  (let ((*num-trials* 1000)
	(*size* 20))
    (is (check-it (test-gen)
                  (lambda (x) (let ((target (car x))
				    (xs (cadr x))
				    (ys (caddr x)))
                                (is (result-correct? (min-sum xs ys target) xs ys target))))))))

(deftest compare-sums-test ()
  (let ((*num-trials* 1000)
	(*size* 20))
    (is (check-it (test-gen)
                  (lambda (x) (let* ((target (car x))
				     (xs (cadr x))
				     (ys (caddr x))
				     (result-1 (min-sum xs ys target))
				     (result-2 (simple-min-sum xs ys target))
				     (d1 (abs (- target (+ (car result-1) (cdr result-1)))))
				     (d2 (abs (- target (+ (car result-2) (cdr result-2))))))
                                (is (= d1 d2))
				(is (member (car result-1) xs))
				(is (member (car result-2) xs))
				(is (member (cdr result-1) ys))
				(is (member (cdr result-2) ys))))))))