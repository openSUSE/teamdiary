module EntriesHelper
   def display_entry(entry)
      text = h entry.content
      text = auto_link(text, :html => { :target => '_blank' })
      text = truncate(text, :length => 30, :separator => '/', :omission => '/...' )
      text = text.gsub(/bnc#([0-9]+)/, '<a href="https://bugzilla.novell.com/show_bug.cgi?id=\1" target="_blank">bnc#\1</a>')
      text = text.gsub(/fate#([0-9]+)/, '<a href="https://fate.suse.com/\1" target="_blank">fate#\1</a>')
      text.html_safe
   end
end
