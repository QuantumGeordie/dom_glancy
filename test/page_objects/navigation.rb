module PageObjects
  class Navigation < ::AePageObjects::Element

    def home!
      node.find_link('home').click
      PageObjects::DomGlancy::IndexPage.new
    end

    def config!
      node.find_link('config').click
      PageObjects::DomGlancy::ConfigPage.new
    end

    def new_page!
      node.find_link('new').click
      PageObjects::DomGlancy::NewPage.new
    end

    def artifacts!
      node.find_link('artifacts').click
      PageObjects::DomGlancy::ArtifactsPage.new
    end

    def clear_results!
      node.find_link('clear').click
      PageObjects::DomGlancy::IndexPage.new
    end

    def about!
      node.find_link('about').click
      PageObjects::DomGlancy::AboutPage.new
    end
  end
end
