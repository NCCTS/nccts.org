(ns org.nccts.nccts-site
  (:require [hiccup.core            :as hiccup]
            [net.cgrand.enlive-html :as enlive-html]
            [stasis.core            :as stasis]
            [stencil.core           :as stencil]))

(defn slurper
  [prefix]
  (fn [part]
    (slurp (str prefix part))))

(def ct-slurp (slurper "site/source/clojure/templates/"))
(def lo-slurp (slurper "site/source/tex/build/"))

(def fragments {:header
                (ct-slurp "header.html")

                :footer
                (ct-slurp "footer.html")})

(def pages {"/index.html"
            (ct-slurp "index.html")

            "/clcc/index.html"
            (ct-slurp "clcc/index.html")

            "/clcc/manual/index.html"
            (lo-slurp "clcc/manual/index.html")

            "/clcc/companion/index.html"
            (lo-slurp "clcc/companion/index.html")})

(def target-dir "site/source/clojure/build")

(defn export []
  (stasis/empty-directory! target-dir)
  (stasis/export-pages pages target-dir))

(defn -main
  [& args]
  (export))
