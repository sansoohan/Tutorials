<a href="https://www.youtube.com/watch?v=ZPh19YUbC3A">RailsView</a>
================

Download Bootstrap Template
------------------------------
<a href="https://github.com/twbs/bootstrap-rubygem">Install Bootstrap inside rails</a><br>

Gemfile
-------------------------------
```
# gem 'duktape'
gem 'bootstrap', '~> 4.3.1'
gem 'jquery-rails'
gem 'font-awesome-sass', '~> 5.6.1'
```

Split Pages
-----------------------------------------
```
rails generate controller Pages index
rails generate controller Pages/About index
rails generate controller Pages/Experience index
rails generate controller Pages/Education index
rails generate controller Pages/Skills index
rails generate controller Pages/Interest index
rails generate controller Pages/Awards index
rails generate controller Pages/Navbar index
```

routes.rb
----------------------
```
Rails.application.routes.draw do
  root 'pages#index'
end
```


Split Bootstrap Template
-------------------------

Make model with view in rails
-------------------------------

Insert Splited template into rails view
---------------------------------------
<br>
