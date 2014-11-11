xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Jump Start Tutorials Blog"
    xml.description "A custom implementation of a rails tutorial. Part of The Odin Project"
    xml.link rss_url

    for article in @articles
      xml.item do
        xml.title article.title
        xml.body article.body
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
        xml.author do
          if article.author
            xml.username = article.author.username
            xml.email = article.author.email
          end
        end
        xml.comments do
          for comment in article.comments
            xml.comment do
              xml.author_name = comment.author_name
              xml.body = comment.body
              xml.created_at = comment.created_at
            end
          end          
        end
        xml.view_count = article.view_count
      end
    end
  end
end