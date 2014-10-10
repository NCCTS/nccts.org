(ns org.nccts.nccts-site
  (:import java.io.File
           org.jsoup.Jsoup)
  (:require [hiccup.core            :as hiccup]
            [net.cgrand.enlive-html :as enlive-html]
            [stasis.core            :as stasis]
            [stencil.core           :as stencil]))

;; -----------------------------------------------------------------------------

(defmulti prettify
  (fn [x]
    (cond
     (seq? x) :seq
     (string? x) :str)))

(defmethod prettify
  :seq
  [s]
  (prettify (apply str s)))

(defmethod prettify
  :str
  [s]
  (let [parsed (Jsoup/parse s)]
    (.indentAmount (.outputSettings parsed) 2)
    (.html parsed)))

(def ct "site/source/clojure/templates/")
(def tb "site/source/tex/build/")

(defn html-resource
  [path]
  (enlive-html/get-resource
   (java.io.File. path)
   net.cgrand.tagsoup/parser))

(defn head-foot
  []
  (html-resource (str ct "head-foot.html")))

(defn hf-template-simple
  [path-ct]
  (let [head-foot (head-foot)
        pg-ct (html-resource (str ct path-ct))]
    (prettify
     (enlive-html/emit*
      (enlive-html/at head-foot
                      [:title]
                      (enlive-html/substitute
                       (enlive-html/select pg-ct [:title]))

                      [:head]
                      (enlive-html/append
                       (enlive-html/at
                        (enlive-html/select pg-ct [:head])

                        [:title]
                        (enlive-html/substitute)))

                      [:div#main]
                      (enlive-html/substitute
                       (enlive-html/select pg-ct [:div#main])))))))

(defn hf-template-tex
    (prettify
     (enlive-html/emit*
      (enlive-html/at head-foot
                      [:title]
                      (enlive-html/substitute
                       (enlive-html/select pg [:title]))

                      [:div#main]
                      (enlive-html/append
                       (:content (first (enlive-html/select pg [:body])))))))))

(defn pages
  []
  {"/index.html"
   (t1 "index.html")

   "/clcc/index.html"
   (t1 "clcc/index.html")

   "/clcc/manual/index.html"
   (t2 "clcc/manual/index.html")

   "/clcc/companion/index.html"
   (t2 "clcc/companion/index.html")})

(def target-dir "site/source/clojure/build")

(defn export []
  (stasis/empty-directory! target-dir)
  (stasis/export-pages (#'pages) target-dir))

(defn -main
  [& args]
  (export))
