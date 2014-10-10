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
      (enlive-html/at
       head-foot

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
  [path-ct path-tb]
  (let [head-foot (head-foot)
        pg-ct (html-resource (str ct path-ct))
        pg-tb (html-resource (str tb path-tb))]
    (prettify
     (enlive-html/emit*
      (enlive-html/at
       head-foot

       [:title]
       (enlive-html/substitute
        (enlive-html/select pg-ct [:title]))

       [:head]
       (enlive-html/append
        (concat

         ;; from template
         (enlive-html/at
          (enlive-html/select pg-ct [:head])

          [:title]
          (enlive-html/substitute))

         ;; from tex output
         (enlive-html/at
          (enlive-html/select pg-tb [:head])

          [enlive-html/any-node]
          (fn [node] (when-not (= :comment (:type node)) node))

          [#{:title :meta}]
          (enlive-html/substitute))))

       [:div#main]
       (enlive-html/append
        (enlive-html/at
         (enlive-html/select pg-tb [:body])

         [#{:span.ltx_tag_section :span.ltx_tag_subsection}]
         (enlive-html/substitute)

         [:footer.ltx_page_footer]
         (enlive-html/substitute)

         [:body]
         enlive-html/unwrap)))))))

(defn pages
  []
  (merge
   {"/index.html"
    (hf-template-simple
     "index.html")

    "/clcc/index.html"
    (hf-template-simple
     "clcc/index.html")

    "/clcc/manual/index.html"
    (hf-template-tex
     "clcc/manual/index.html"
     "clcc/manual/index.html")

    "/clcc/companion/index.html"
    (hf-template-tex
     "clcc/companion/index.html"
     "clcc/companion/index.html")}

   (stasis/slurp-directory tb #"\.css")))

(def target-dir "site/source/clojure/build")

(defn export []
  (stasis/empty-directory! target-dir)
  (stasis/export-pages (#'pages) target-dir))

(defn -main
  [& args]
  (export))
