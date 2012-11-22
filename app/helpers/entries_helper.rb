module EntriesHelper
   def display_entry(text)
      newtext = h text
      newtext = auto_link(newtext, :html => { :target => '_blank' })
      newtext = truncate(newtext, :length => 30, :separator => '/', :omission => '/...' )
      newtext = newtext.gsub(/bnc#([0-9]+)/, '<a href="https://bugzilla.novell.com/show_bug.cgi?id=\1" target="_blank">bnc#\1</a>')
      newtext = newtext.gsub(/fate#([0-9]+)/, '<a href="https://fate.suse.com/\1" target="_blank">fate#\1</a>')
      newtext.html_safe
   end
end
