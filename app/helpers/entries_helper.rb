module EntriesHelper
   class DiaryRender < Redcarpet::Render::HTML
     include Redcarpet::Render::SmartyPants

     # do not wrap into <p>
     def paragraph(text)
       text
     end
     # headers are nogo
     def header(text, header_level)
       text
     end

     # trim long urls to the hostname
     def autolink(link, link_type)
       linktext=link
       if linktext.length > 20
         url = URI.parse(linktext)
         linktext = "#{url.scheme}://#{url.host}/..."
       end
       "<a href='#{link}'>#{linktext}</a>"
     end

     # catch bnc# and co
     def normal_text(text)
       if /#/ =~ text
         # Make bnc# and fate# work
         text.gsub!(/bnc#([0-9]+)/, '<a href="https://bugzilla.novell.com/show_bug.cgi?id=\1" target="_blank">bnc#\1</a>')
         text.gsub!(/fate#([0-9]+)/, '<a href="https://fate.suse.com/\1" target="_blank">fate#\1</a>')
         text.gsub!(/#task/, '<span style="color: red">#task</span>')
       end
       text
     end
   end

   def display_entry(entry)
      @renderer ||= Redcarpet::Markdown.new(DiaryRender, :autolink => true, :escape_html => true, :no_intra_emphasis => true)
      # Render it
      @renderer.render(entry.content).html_safe
   end
end
