module EntriesHelper
   def display_entry(entry)
      text = h entry.content

      # Make links work and truncate the long ones
      text = auto_link(text, :html => { :target => '_blank' })
      text = truncate(text, :length => 30, :separator => '/', :omission => '/...' )

      # Make bnc# and fate# work
      text = text.gsub(/bnc#([0-9]+)/,
               link_to('bnc#\1', 
                       'https://bugzilla.novell.com/show_bug.cgi?id=\1',
                       html_options = { :target => '_blank' }) )
      text = text.gsub(/fate#([0-9]+)/,
               link_to('fate#\1',
                       'https://fate.suse.com/\1',
                       html_options = { :target => '_blank' }) )

      # Make day references work
      text = text.gsub(/#monday/, link_to('#monday', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:tuesday)).days
               ).to_s(:db)))
      text = text.gsub(/#tuesday/, link_to('#tuesday', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:wednesday)).days
               ).to_s(:db)))
      text = text.gsub(/#wednesday/, link_to('#wednesday', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:thursday)).days
               ).to_s(:db)))
      text = text.gsub(/#thursday/, link_to('#thursday', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:friday)).days
               ).to_s(:db)))
      text = text.gsub(/#friday/, link_to('#friday', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:saturday)).days
               ).to_s(:db)))
      text = text.gsub(/#saturday/, link_to('#saturday', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:sunday)).days
               ).to_s(:db)))
      text = text.gsub(/#sunday/, link_to('#sunday', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:monday)).days
               ).to_s(:db)))

      # Render it
      text.html_safe
   end
end
