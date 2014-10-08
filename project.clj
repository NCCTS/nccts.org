(defproject org.nccts/nccts-site "0.0.1-SNAPSHOT"
  :description "Site generator for nccts.org"
  :license {:distribution :repo
            :comments "same as Clojure"
            :name "Eclipse Public License - v 1.0"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :url "https://github.com/NCCTS/nccts.org"

  :dependencies [[org.clojure/clojure "1.7.0-alpha2"]
                 [stasis "2.2.2"]]

  :main org.nccts.nccts-site

  :min-lein-version "2.5.0"

  :plugins [[cider/cider-nrepl "0.8.0-SNAPSHOT"]]

  :resource-paths ["site/source"]

  :source-paths ["site/source/clojure/src"])
