(defpackage :pairs-sum
  (:use cl)
  (:export :min-sum :simple-min-sum :all-pairs))

(in-package :pairs-sum)

(defun all-pairs (xs ys)
  (loop :for x :in xs
	:append (loop :for y :in ys :collect (cons x y))))

(defun find-simple-min-sum (result pairs target)
  (if pairs
      (let* ((pair (car pairs))
	     (x (car pair))
	     (y (cdr pair))
	     (min-sum (car result))
	     (sum (abs (- target (+ x y)))))
	(if (or (null min-sum) (< sum min-sum))
	    (find-simple-min-sum (cons sum (cons x y)) (cdr pairs) target)
	    (find-simple-min-sum result (cdr pairs) target)))
      (cdr result)))

(defun simple-min-sum (xs ys target)
  (find-simple-min-sum nil (all-pairs xs ys) target))

(defun find-min-sum (result xs ys target)
  (if (and xs ys)
      (let* ((x (car xs))
	     (y (car ys))
	     (min-sum (car result))
	     (sum (abs (- target (+ x y))))
	     (sum-gt (minusp (- target (+ x y))))
	     (next-result (if (or (null min-sum) (< sum min-sum))
			      (cons sum (cons x y))
			      result)))
	(cond ((zerop sum) (cons x y))
	      (sum-gt (find-min-sum next-result xs (cdr ys) target))
	      (t (find-min-sum next-result (cdr xs) ys target))))
      (cdr result)))

(defun min-sum (xs ys target)
  (find-min-sum nil (sort (copy-list xs) #'<) (sort (copy-list ys) #'>) target))
