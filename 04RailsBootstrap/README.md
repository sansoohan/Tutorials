<a href="https://www.youtube.com/watch?v=ZPh19YUbC3A">RailsView</a>
================
Download Bootstrap Template<br>
<br>
<a href="https://github.com/twbs/bootstrap-rubygem">Install Bootstrap inside rails</a><br>
<br>
uncomment ductape in Gemfile<br>
<br>
rails generate controller Pages index<br>
rails generate controller Pages/About index<br>
rails generate controller Pages/Experience index<br>
rails generate controller Pages/Education index<br>
rails generate controller Pages/Skills index<br>
rails generate controller Pages/Interest index<br>
rails generate controller Pages/Awards index<br>
rails generate controller Pages/Navbar index<br>

<br>
routes.rb<br>
```
Rails.application.routes.draw do
  root 'pages#index'
end
```


Split Bootstrap Template<br>
Make model with view in rails<br>
Insert Splited template into rails view<br>
<br>