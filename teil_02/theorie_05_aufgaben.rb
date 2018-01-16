# encoding: utf-8
# theorie_05_aufgaben.rb
require 'pp'

einkauf_als_hash = {
  "tegut" => ["Butter", "Milch", "Honig", "Brot"],
  "obi" =>   ["Schrauben", "Leimholz", "Kabel", "Lampe"],
  "dm"  =>   ["Duschbad für Mama",    "Deo für Papa",
              "Haarspange für Livia", "Zahnbürste für Peter"]
}
pp einkauf_als_hash
pp einkauf_als_hash["obi"]
