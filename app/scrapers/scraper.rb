# ENV['RAILS_ENV'] ||= 'development'
# require_relative '../config/environment'
require 'csv'
require 'httparty'
require 'nokogiri'

class Scraper
  PokemonProduct = Struct.new(:url, :image, :name, :price)

  def pokemon
    response = HTTParty.get("https://scrapeme.live/shop/", {
      headers: {
        "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
      },
    })

    document = Nokogiri::HTML(response.body)
    html_products = document.css("li.product")
    pokemon_products = []

    # iterating over the list of HTML products
    html_products.each do |html_product|
      # extracting the data of interest
      # from the current product HTML element
      url = html_product.css("a").first.attribute("href").value
      image = html_product.css("img").first.attribute("src").value
      name = html_product.css("h2").first.text
      price = html_product.css("span").first.text

      # storing the scraped data in a PokemonProduct object
      pokemon_product = PokemonProduct.new(url, image, name, price)

      # adding the PokemonProduct to the list of scraped objects
      pokemon_products.push(pokemon_product)
    end

    csv_headers = ["url", "image", "name", "price"]

    # Use Rails.root to get the project root directory
    # require 'pry'; binding.pry
    file = "../data/pokemon.csv"

    CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |csv|
      # adding each pokemon_product as a new row
      # to the output CSV file
      pokemon_products.each do |pokemon_product|
        # require 'pry'; binding.pry
        csv << pokemon_product
      end
    end
  end

  scrap = Scraper.new
  p scrap.pokemon
end