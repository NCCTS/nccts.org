(ns org.nccts.nccts-site
  (:require [hiccup.core            :as hiccup]
            [net.cgrand.enlive-html :as enlive-html]
            [stasis.core            :as stasis]
            [stencil.core           :as stencil]))

(defn t-slurp [part]
  (slurp (str "site/source/clojure/templates/" part)))

(def fragments {:header
                (t-slurp "header.html")

                :footer
                (t-slurp "footer.html")})

(def pages {"/index.html"
            (t-slurp "index.html")

            "/clcc/index.html"
            (t-slurp "clcc/index.html")})

(def target-dir "site/source/clojure/build")

(defn export []
  (stasis/empty-directory! target-dir)
  (stasis/export-pages pages target-dir))

(defn -main
  [& args]
  (export))
