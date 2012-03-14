# -*- encoding: utf-8 -*-
#$KCODE = 'u'
$stdout.sync = true
require 'amazon/ecs'
require 'cgi'
require 'pp'

isbns = %w[]

Amazon::Ecs.options = {
  # Need your configuration
  :associate_tag => '',
  :AWS_access_key_id => '',
  :AWS_secret_key => '',
  
  :country => 'jp',
  :id_type => 'ISBN',
  :search_index => 'Books'
}

isbns.each do |isbn|
  res = Amazon::Ecs.item_lookup(isbn)
  title = res.first_item.get('ItemAttributes/Title')
  title = CGI::unescapeHTML(title)
  
  # Convert to short title
  title.gsub!(/―.*|\(.*?\)|（.*?）|〈.*?〉/, "")
  title = title.split(" ")[1] if title.split(" ").size == 3
  
  puts title
end
