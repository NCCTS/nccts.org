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

(defn emit-html
  [resource]
  (prettify
   (enlive-html/emit* resource)))

(defn head-foot
  []
  (html-resource (str ct "head-foot.html")))

(defn hf-template-simple
  [path-ct]
  (let [head-foot (head-foot)
        pg-ct (html-resource (str ct path-ct))]
    (enlive-html/at
     head-foot

     [enlive-html/any-node]
     (fn [node] (when-not (= :comment (:type node)) node))

     [:title]
     (enlive-html/substitute
      (enlive-html/select pg-ct [:title]))

     [:head]
     (enlive-html/append
      (enlive-html/at
       (enlive-html/select pg-ct [:head])

       [enlive-html/any-node]
       (fn [node] (when-not (= :comment (:type node)) node))

       [:title]
       (enlive-html/substitute)))

     [:main]
     (enlive-html/substitute
      (enlive-html/select
       (enlive-html/at
        pg-ct

        [enlive-html/any-node]
        (fn [node] (when-not (= :comment (:type node)) node)))

       [:main]))

     [:div#template-scripts]
     (enlive-html/append
      (enlive-html/at
       (enlive-html/select pg-ct [:div#template-scripts])

       [:div#template-scripts]
       enlive-html/unwrap)))))

(defn hf-template-tex
  [path-ct path-tb]
  (let [head-foot (head-foot)
        pg-ct (html-resource (str ct path-ct))
        pg-tb (html-resource (str tb path-tb))]
    (enlive-html/at
     head-foot

     [enlive-html/any-node]
     (fn [node] (when-not (= :comment (:type node)) node))

     [:title]
     (enlive-html/substitute
      (enlive-html/select pg-ct [:title]))

     [:head]
     (enlive-html/append
      (concat
       ;; from tex output
       (enlive-html/at
        (enlive-html/select pg-tb [:head])

        [enlive-html/any-node]
        (fn [node] (when-not (= :comment (:type node)) node))

        [#{:link :meta :title}]
        (enlive-html/substitute))

       ;; from template
       (enlive-html/at
        (enlive-html/select pg-ct [:head])

        [enlive-html/any-node]
        (fn [node] (when-not (= :comment (:type node)) node))

        [:title]
        (enlive-html/substitute))))

     [:main]
     (enlive-html/append
      (concat
       (enlive-html/at
        (enlive-html/select pg-ct [:main])

        [:main]
        enlive-html/unwrap)

       (enlive-html/at
        (enlive-html/select pg-tb [:body])

        [enlive-html/any-node]
        (fn [node] (when-not (= :comment (:type node)) node))

        [:footer.ltx_page_footer]
        (enlive-html/substitute)

        [:body]
        enlive-html/unwrap)))


     [:div#template-scripts]
     (enlive-html/append
      (enlive-html/at
       (enlive-html/select pg-ct [:div#template-scripts])

       [:div#template-scripts]
       enlive-html/unwrap)))))

(defn xform-companion|abs-title
  [resource]
  (enlive-html/at
   resource

   [:h6.ltx_title_abstract]
   (enlive-html/content
    (enlive-html/html-snippet "<em>Veni, Sancte Spiritus!</em>"))))

(defn pages
  []
  (merge
   {"/index.html"
    (emit-html
     (hf-template-simple
      "index.html"))

    "/clcc/index.html"
    (emit-html
     (hf-template-simple
      "clcc/index.html"))

    "/questions/index.html"
    (emit-html
     (let [pg-tb (html-resource (str tb "clcc/manual/index.html"))]
       (enlive-html/at
        (hf-template-simple
         "questions/index.html")

        [:head]
        (enlive-html/prepend
         (enlive-html/at
          (enlive-html/select pg-tb [:head])

          [enlive-html/any-node]
          (fn [node] (when-not (= :comment (:type node)) node))

          [#{:link :meta :title}]
          (enlive-html/substitute)))

        [:main]
        (enlive-html/content
         (enlive-html/at
          (enlive-html/select pg-tb [:body])

          [:section.ltx_document]
          (enlive-html/content
           (enlive-html/select
            pg-tb

            [:#A1]))

          [:footer.ltx_page_footer]
          (enlive-html/substitute))))))

    "/francis-novak/index.html"
    (emit-html

     (let [pg-tb (html-resource (str tb "clcc/manual/index.html"))]
       (enlive-html/at
        (hf-template-simple
         "francis-novak/index.html")

        [:head]
        (enlive-html/prepend
         (enlive-html/at
          (enlive-html/select pg-tb [:head])

          [enlive-html/any-node]
          (fn [node] (when-not (= :comment (:type node)) node))

          [#{:link :meta :title}]
          (enlive-html/substitute)))

        [:main]
        (enlive-html/content
         (enlive-html/at
          (enlive-html/select pg-tb [:body])

          [:section.ltx_document]
          (enlive-html/content
           (enlive-html/at
            (enlive-html/select
             pg-tb

             [:#A7])

            [:img]
            (enlive-html/set-attr
             :src "/static/images/fr-novak.jpg")))

          [:footer.ltx_page_footer]
          (enlive-html/substitute))))))

    "/clcc/manual/index.html"
    (emit-html
     (hf-template-tex
      "clcc/manual/index.html"
      "clcc/manual/index.html"))

    "/clcc/companion/index.html"
    (emit-html
     (xform-companion|abs-title
      (hf-template-tex
       "clcc/companion/index.html"
       "clcc/companion/index.html")))}))

(def target-dir "site/source/clojure/build")

(defn export []
  (stasis/empty-directory! target-dir)
  (stasis/export-pages (#'pages) target-dir))

(defn -main
  [& args]
  (export))
