
# It is important to require the RSS module.  If you leave this off, the blog will not load.
require 'rss'

class PagesController < ApplicationController
  
  # Called before loading any page on which the latest blog posts will be shown
  def load_blog_feed
     begin
       @latest_blog_posts = RSS::Parser.parse(open('http://blog.rietta.com/feeds/posts/default?alt=rss').read, false).items[0...5]
     rescue 
       # Do nothing, just continue.  The view will skip the blog section if the feed is nil.
       @latest_blog_posts = nil
     end
  end
  
  
  def index
    load_blog_feed
  end

end
