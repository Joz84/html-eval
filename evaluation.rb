# require 'pry-byebug'
require 'nokogiri'
require 'open-uri'
require "css_parser"

github_username = "ana-kos"
# url = "https://#{github_username}.github.io/my-first-web-page.github.io/"
# url = "file:///Users/jonathan/Downloads/my-first-web-page.github.io-master/Code/index.html"

url = "https://nahiauhart.github.io/"

page = Nokogiri::HTML(URI.open(url))

css = CssParser::Parser.new
css.load_uri!("#{url}/style.css")
points = []

flex = false
custom_border = false
css.each_selector do |selector, declarations, specificity|
  # flex
  flex ||= declarations.match?(/display:.*flex/)

  # custom border
  properties = [/border/, /border-radius/, /box\-shadow/]
  custom_border_line = true
  properties.each do |property|
    custom_border_line &= declarations.match?(property)
  end
  custom_border ||= custom_border_line
end

youtube_video = page.css('iframe').find do |iframe|
  iframe&.attributes["src"]&.value&.match(/youtube/)
end

google_map = page.css('iframe').find do |iframe|
  iframe&.attributes["src"]&.value&.match(/www\.google\.com\/maps/)
end

email_link = page.css('a').find do |link|
  link&.attributes["href"]&.value&.match(/mailto/)
end

google_font = page.css('link').find do |link|
  link&.attributes["href"]&.value&.match(/fonts\.googleapis\.com/)
end

fa_icon = page.css('i').find do |icon|
  icon&.attributes["class"]&.value&.match(/fa/)
end

###################################################
##### Début du remplissage du tableau points ######
###################################################


# Un titre, un sous titre et un paragraphe
if page.css('h1', 'h2', 'p').size > 0
  points << 1
else
 p "Un titre, un sous titre et un paragraphe"
end

# Une image
if page.css('img').size > 0
  points << 1
else
  p "Une image"
end

# Une liste
if page.css('ol li', 'ul li').size > 0
  points << 1
else
  p "Une liste"
end

# Une division avec le bord du cadre de couleur et arrondi et avec une ombre
if custom_border
  points << 1
else
  p "#Une division avec le bord du cadre de couleur et arrondi et avec une ombre"
end

# # Un bouton fait par vous identifié par la classe .my-btn
# if page.css('a.my-btn').size > 0
#   points << 1
# else
#   p "Un bouton fait par vous identifié par la classe .my-btn"
# end

# Une modale issue de Bootstrap
if page.css('.modal').size > 0
  points << 1
else
  p "Une modale issue de Bootstrap"
end

# Une navbar faite par vous identifiée par la classe .my-navbar
if page.css('.my-navbar').size > 0
  points << 1
else
  p "Une navbar faite par vous identifiée par la classe .my-navbar"
end

# L’utilisation des Flexboxs
if flex
  points << 1
else
  p "L’utilisation des Flexboxs"
end

# Un lien qui redirige vers la boite mail
if email_link
  points << 1
else
  p "Un lien qui redirige vers la boite mail"
end

# Une police issue de Google fonts
if google_font
  points << 1
else
  p "Une police issue de Google fonts"
end

# Une vidéo issue de YouTube
if youtube_video || page.css('video').size > 0
  points << 1
else
  p "Une vidéo issue de YouTube"
end

# Une carte issue de Google maps
if google_map
  points << 1
else
  p "Une carte issue de Google maps"
end

# # Un icon issu de Font awesome
# if fa_icon
#   points << 1
# else
#   p "Un icon issu de Font awesome"
# end

# # Un footer issu de Le wagon Ui composants
# if page.css('.footer').size > 0
#   points << 1
# else
#   p "Un footer issu de Le wagon Ui composants"
# end

# Un formulaire issue de Type form ou de mailchimp

p "Note de #{github_username} : #{points.sum}/ 14 "















