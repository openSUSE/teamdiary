module EntriesHelper
   def display_entry(entry)
      text = h entry.content

      # Make links work and truncate the long ones
      text = auto_link(text, :html => { :target => '_blank' }) do |i|
         text = truncate(i, :length => 30, :separator => '/', :omission => '/...' )
      end

      if /#/ =~ text
         # Make bnc# and fate# work
         text = text.gsub(/bnc#([0-9]+)/,
                          '<a href="https://bugzilla.novell.com/show_bug.cgi?id=\1" target="_blank">bnc#\1</a>')
         text = text.gsub(/fate#([0-9]+)/,
                          '<a href="https://fate.suse.com/\1" target="_blank">bnc#\1</a>')
      end

      # Render it
      text.html_safe
   end
end
