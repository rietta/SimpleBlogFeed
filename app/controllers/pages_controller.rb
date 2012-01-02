
# It is important to require the RSS module.  If you leave this off, the blog feed will not load.
require 'rss'

class PagesController < ApplicationController
  
    # Load an RSS feed from the supplied URL.  If the feed is not loaded, return nil.
    def load_blog_feed_for_url(rss_feed_url_to_load)
      to_return = nil
      if nil != rss_feed_url_to_load   
       begin
         to_return = RSS::Parser.parse(open(rss_feed_url_to_load).read, false).items[0...5]
       rescue
         to_return = nil
       end
     end
     to_return
   end
  
  
   #
   # Load the sample Blogger RSS feeds. Blogger supports full site, comments-only, and label-specific
   # feeds in Atom and RSS format as per http://support.google.com/blogger/bin/answer.py?hl=en&answer=97933.
   #
   def index
     # Load the latest full blog feed for Frank's blog as per 
     @latest_blog_posts = load_blog_feed_for_url('http://blog.rietta.com/feeds/posts/default?alt=rss')
     
     # Load the latest posts for the Marketing label feed. Labels are case sensitive - Marketing != marketing
     # Please note that the example of the Google website has an error on its label example.  The alt=rss comes after
     # the label in the feed URL
     @latest_marketing_posts = load_blog_feed_for_url('http://blog.rietta.com/feeds/posts/default/-/Marketing?alt=rss')
     
     # Load the latest posts for the SQL Converter label feed (space in the tag)
     @latest_sql_converter_posts = load_blog_feed_for_url('http://blog.rietta.com/feeds/posts/default/-/SQL%20Converter?alt=rss')
   end

end
