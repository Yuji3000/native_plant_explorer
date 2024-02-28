require 'csv'
# require 'httparty'
require 'open-uri'
require 'nokogiri'
require 'selenium-webdriver'

class Scraper
  all_plants = Struct.new(:common_name, :scientific_name, :family, :mature_height)
  def natives
    plant_url = 'http://coloradoplants.jeffco.us/plant/details/874'

    driver = Selenium::WebDriver.for :chrome
    driver.get(plant_url)

    # driver.find_element(class: 'ng-binding').text
    # # this will return
    # "BLUE ELDERBERRY - Sambucus caerulea"

    # a = driver.find_elements(:tag_name, "a").map {|link| link.href}
    require 'pry'; binding.pry






    # csv_headers = ["common_name", "scientific_name", "family", "mature_height"]
    # file = "../data/pokemon.csv"

    # CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |csv|
    #   csv << all_natives
    # end
  end
  scraper = Scraper.new
  p scraper.natives
end

