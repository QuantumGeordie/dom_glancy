module DomGlancy
  class FileMapper

    def run(test_root)
      filename = ::DomGlancy::FileNameBuilder.new(test_root).current

      result = [true, '']
      begin
        data = map_page.to_yaml
        File.open(filename, 'w') { |file| file.write(data) }
      rescue Exception => e
        result = [false, "map current file error: #{e.message}"]
      end

      result
    end

    private

    def map_page
      page_map_js = mapping_javascript
      resize_browser_for_scrollbar do
        Capybara.current_session.driver.browser.execute_script(page_map_js)
      end
    end

    def mapping_javascript
      <<-JS
        var dom_glancy = {

          treeUp: function() {
            var treeWalker = document.createTreeWalker(
              document.body,
              NodeFilter.SHOW_ELEMENT,
              { acceptNode: function(node) { return NodeFilter.FILTER_ACCEPT; } },
              false
            );

            var nodeList = [];

            while(treeWalker.nextNode()){
              var cn = treeWalker.currentNode;
              var node_details = {
                "height"  : cn.clientHeight,
                "width"   : cn.clientWidth,
                "id"      : cn.id,
                "tag"     : cn.tagName,
                "class"   : cn.className,
                "top"     : cn.offsetTop,
                "left"    : cn.offsetLeft,
                "visible" : dom_glancy.isVisible(cn)
              }
              nodeList.push(node_details);
            }

            return(nodeList);
          },

          isVisible: function(elem) {
              return elem.offsetWidth > 0 || elem.offsetHeight > 0;
          }
        };
        return dom_glancy.treeUp();
      JS
    end

    def resize_browser_for_scrollbar
      original_dimensions = Capybara.current_session.driver.browser.manage.window.size
      width = Capybara.current_session.evaluate_script('window.innerWidth - document.documentElement.clientWidth').to_i

      Capybara.current_session.driver.browser.manage.window.resize_to(original_dimensions.width + width, original_dimensions.height) if width > 0

      result = yield

      Capybara.current_session.driver.browser.manage.window.resize_to(original_dimensions.width, original_dimensions.height) if width > 0

      result
    end

  end
end
