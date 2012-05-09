module TasksHelper
  def bz(str, user)
    str = str.gsub /(BZ\s*\#)(\d+)(#?)(c\d+)?/i, '<a href="http://bugzilla.redhat.com/show_bug.cgi?id=\2#\4" target="_blank">\1\2\3\4</a>'
    str.html_safe
  end
end
