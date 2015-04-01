module LittlebitsNav::NavController
  def self.included(base)
    base.before_filter :fetch_nav
  end

  def fetch_nav
    @nav = "<h1>OLIVER</h1>".html_safe
  end
end