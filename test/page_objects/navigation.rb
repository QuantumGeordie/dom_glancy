module PageObjects
  class Navigation < ::AePageObjects::Element

    def home!
      node.find_link('home').click
      PageObjects::Kracker::IndexPage.new
    end

    def config!
      node.find_link('config').click
      PageObjects::Kracker::ConfigPage.new
    end

    def new_page!
      node.find_link('new').click
      PageObjects::Kracker::NewPage.new
    end

    def artifacts!
      node.find_link('artifacts').click
      PageObjects::Kracker::ArtifactsPage.new
    end

    def clear_results!
      node.find_link('clear').click
      PageObjects::Kracker::IndexPage.new
    end

    def about!
      node.find_link('about').click
      PageObjects::Kracker::AboutPage.new
    end
  end
end