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
      text = text.gsub(/(#monday)/i,    link_to('\1', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:tuesday)).days
               ).to_s(:db)))
      text = text.gsub(/(#tuesday)/i,   link_to('\1', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:wednesday)).days
               ).to_s(:db)))
      text = text.gsub(/(#wednesday)/i, link_to('\1', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:thursday)).days
               ).to_s(:db)))
      text = text.gsub(/(#thursday)/i,  link_to('\1', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:friday)).days
               ).to_s(:db)))
      text = text.gsub(/(#friday)/i,    link_to('\1', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:saturday)).days
               ).to_s(:db)))
      text = text.gsub(/(#saturday)/i,  link_to('\1', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:sunday)).days
               ).to_s(:db)))
      text = text.gsub(/(#sunday)/i,    link_to('\1', '#' + (
               entry.created_at.to_date - 
               (1 + entry.created_at.to_date.days_to_week_start(:monday)).days
               ).to_s(:db)))
      text = text.gsub(/(#yesterday)/i, link_to('\1', '#' + (
               entry.created_at.to_date - 1.day).to_s(:db)))

      # Render it
      text.html_safe
   end
end
