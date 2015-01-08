(defproject org.nccts/nccts-site "0.0.1-SNAPSHOT"
  :description "Site generator for nccts.org"
  :license {:distribution :repo
            :comments "same as Clojure"
            :name "Eclipse Public License - v 1.0"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :url "https://github.com/NCCTS/nccts.org"

  :dependencies [[enlive "1.1.5"]
                 [hiccup "1.0.5"]
                 [org.clojure/clojure "1.6.0"]
                 [org.jsoup/jsoup "1.8.1"]
                 [stasis "2.2.2"]
                 [stencil "0.3.4"]]

  :main org.nccts.nccts-site

  :min-lein-version "2.5.0"

  :plugins [[cider/cider-nrepl "0.9.0-SNAPSHOT"]]

  :resource-paths ["site/source"]

  :source-paths ["site/source/clojure/src"])
