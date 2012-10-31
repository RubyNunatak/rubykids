spec = Gem::Specification.new

spec.name         = "wie_spaet"
spec.version      = "0.0.1"
spec.authors      = ["rubykids"]
spec.summary      = "Sagt dir die Zeit."
spec.homepage     = "http://www.rubykids.de/"
spec.description  = "Waehlt zufaellig eine Anrede und sagt dir die Zeit."
spec.files        = [ "README", "LICENSE", "bin/wie_spaet", "lib/zeitansage.rb"]
spec.executables  = ["wie_spaet"]
spec.rdoc_options = ["--charset", "UTF-8", "--line-numbers", "--inline-source", "--main", "README", "--title", "wie_spaet -- Sagt dir die Zeit!", "--all"]
spec.has_rdoc     = true
spec.extra_rdoc_files = ["README", "LICENSE", "bin/wie_spaet"]
