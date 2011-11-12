require 'redmine'
require 'open-uri'
require 'json'
require 'rexml/document'
module QuoteitWikimacro
  Redmine::WikiFormatting::Macros.register do
    desc "quoteit(str)"
    macro(:quoteit) do |obj, args|
      if args.nil? or args.size < 1
        return ''
      end
      atag = args[0]
      root = 'http://quoteit.heroku.com'
      url = REXML::Document.new(atag).root.text
      begin
        open("#{root}/clip.html?u=#{CGI.escape url}").read
      rescue
        "<div><a target='_blank' href='#{url}'>#{url}</a></div>"
      end
    end
  end
end
