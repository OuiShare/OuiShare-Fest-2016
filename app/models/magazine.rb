class Magazine < ActiveRecord::Base
	require 'feedjira'
  attr_accessible :content, :guid, :name, :published_at, :tags, :url, :author

  def self.fetch_last_posts
  	feed_url = 'http://magazine.ouishare.net/tag/ouisharefest/feed'
  	feed = Feedjira::Feed.fetch_and_parse feed_url
  	add_entries(feed.entries)
	end


	# def self.fetch_last_posts_continuously
 #  	feed_url = 'http://magazine.ouishare.net/feed'
 #  	feed = Feedjira::Feed.fetch_and_parse feed_url
 #  	add_entries(feed.entries)
 #  	loop do
 #  		delay_interval = 15.minutes
 #  		sleep delay_interval
 #  		feed = Feedjira::Feed.update feed_url
 #  		add_entries(feed.new_entries) if feed_updated?
 #  	end
 #  end
	# end

	private

	def self.add_entries(entries)
		# feed_ouishare_fest = []
  	entries.each do |entry|
  		# if entry.categories.include? 'Analysis' # 'OuiShareFest'
			unless exists? :guid => entry.entry_id
				create!(
					:name				=> entry.title,
					:author				=> entry.author,
					:content				=> entry.summary,
					:published_at				=> entry.published,
					:url				=> entry.url,
					:guid => entry.entry_id
					)
			# feed_ouishare_fest << entriesOSF
  		end
	  	# end
		end
	end

end
