# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@stimulus-components/rails-nested-form", to: "@stimulus-components--rails-nested-form.js" # @5.0.0
pin "codejar-setup", to: "codejar-setup.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "codejar" # @4.2.0
pin "prismjs" # @1.30.0
pin "highlight.js" # @11.11.1
