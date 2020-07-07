;;;; Taken from http://clojure.roboloco.net/?p=703 and modified slightly.
(def board [:GO   :A1 :CC1 :A2  :T1 :R1 :B1  :CH1 :B2 :B3
            :JAIL :C1 :U1  :C2  :C3 :R2 :D1  :CC2 :D2 :D3
            :FP   :E1 :CH2 :E2  :E3 :R3 :F1  :F2  :U2 :F3
            :G2J  :G1 :G2  :CC3 :G3 :R4 :CH3 :H1  :T2 :H2])

(def b2i (zipmap board (range))) ;; Board symbols to integers

(def i2b (zipmap (range) board)) ;; Integers to board symbols

(defn card-CC
  "Community Chest. Returns the number of the square to move to."
  [n]
  (let [options (concat [(b2i :GO) (b2i :JAIL)] (repeat 14 n))]
    (rand-nth options)))

(defn card-CH
  "Chance card. Returns the number of the square to move to."
  [n]
  (let [options [:X :X :X :X :X :X
                 :GO :JAIL :C1 :E3 :H2 :R1 :NextR :NextR :NextU :Back3]
        event (rand-nth options)]
    (condp = event
        :X n                                    ;; Do nothing
        :NextR (nth (map b2i [:R1 :R2 :R3 :R4]) ;; Next railroad
                    (rem (quot (+ 5 n) 10) 4))
        :NextU (if (and (> n (b2i :U1)) ;; Next Utility
                        (< n (b2i :U2)))
                 (b2i :U2)
                 (b2i :U1))
        :Back3 (if (= (- n 3) (b2i :CC3))
                 (card-CC (- n 3)) ;; Sometimes you land on another CC
                 (- n 3))          ;; But mostly you don't
        (b2i event))))

(defn dice-4 [] (inc (rand-int 4)))

(defn move [[n doubles]]
  (let [d1 (dice-4)
        d2 (dice-4)
        m (if (and (= d1 d2) (= 2 doubles))
            (b2i :JAIL)
            (rem (+ n d1 d2) 40))]
    [(condp = m
         (b2i :G2J) (b2i :JAIL)
         (b2i :CC1) (card-CC m)
         (b2i :CC2) (card-CC m)
         (b2i :CC2) (card-CC m)
         (b2i :CH1) (card-CH m)
         (b2i :CH2) (card-CH m)
         (b2i :CH3) (card-CH m)
         m)
     (if (= d1 d2)
       (if (not (= 2 doubles)) ;; reset if 3rd double in a row
         (inc doubles)
         0)
       0)]))

(defn compute-monopoly-freqs []
  (let [trials 1000000
        games 10
        sim (fn [trials]
              (frequencies (take trials (map first (iterate move [0 0])))))
        freqs (apply merge-with + (pmap sim (repeat games trials)))
        ps (map (fn [[c v]]
                  [(i2b c) (double (* 100 (/ v trials games)))])
                (sort freqs))]
    (print (map #(b2i (first %)) (take 3 (reverse (sort-by second ps)))))))

(time (compute-monopoly-freqs)) ;; "Elapsed time: 10217.921373 msecs"

(shutdown-agents)
