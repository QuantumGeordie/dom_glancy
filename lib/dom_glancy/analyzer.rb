module DomGlancy
  class Analyzer
    def analyze(master_data, current_data, test_root = nil)
      output_hash = {}

      master_set  = master_data.to_set
      current_set = current_data.to_set

      set_current_not_master = current_set - master_set
      set_master_not_current = master_set  - current_set
      set_changed_master = Set.new

      changed_element_pairs = []
      if set_master_not_current.count > 0 || set_current_not_master.count > 0

        ok_pairs = pairs_that_are_close_enough(set_current_not_master, set_master_not_current)

        ok_pairs.each do |item1, item2|
          set_current_not_master.delete(item1)
          set_master_not_current.delete(item2)
        end

        changed_element_pairs = get_set_of_same_but_different(set_current_not_master, set_master_not_current)

        changed_element_pairs.each do |item1, item2|
          set_current_not_master.delete(item1)
          set_current_not_master.delete(item2)

          set_master_not_current.delete(item1)
          set_master_not_current.delete(item2)
        end

        changed_element_pairs.select!{ |pair| !DOMElement.new(add_similarity(pair[0])).close_enough?(DOMElement.new(add_similarity(pair[1]))) }
        changed_element_pairs.each do |pair|
          set_changed_master.add(pair.first)
        end
      end

      all_same = set_current_not_master.count == 0 && set_master_not_current.count == 0 && changed_element_pairs.count == 0

      create_diff_file(set_current_not_master, set_master_not_current, set_changed_master, test_root) if test_root && !all_same

      output_hash[:not_in_master]  = set_current_not_master
      output_hash[:not_in_current] = set_master_not_current
      output_hash[:changed_element_pairs] = changed_element_pairs
      output_hash[:same] = all_same
      output_hash[:test_root] = test_root
      output_hash
    end

    private

    def make_svg(set_master_not_current, set_current_not_master, set_changed_master)
      js_id = 0
      set_master_not_current.each do |item|
        item[:js_id] = js_id
        js_id += 1
      end
      set_current_not_master.each do |item|
        item[:js_id] = js_id
        js_id += 1
      end
      set_changed_master.each do |item|
        item[:js_id] = js_id
        js_id += 1
      end

      svg = ::DomGlancy::SVG.new

      rectangles = set_current_not_master.map  { |item| item.merge(svg.format__not_in_master) }
      rectangles << set_master_not_current.map { |item| item.merge(svg.format__not_in_current) }
      rectangles << set_changed_master.map     { |item| item.merge(svg.format__same_but_different) }
      rectangles.flatten!

      svg.generate_svg(rectangles)
    end

    def create_diff_file(set_current_not_master, set_master_not_current, set_changed_master, test_root)
      filename = ::DomGlancy::FileNameBuilder.new(test_root).diff
      svg = make_svg(set_current_not_master, set_master_not_current, set_changed_master)
      File.open(filename, 'w') { |file| file.write(svg) }
      save_set_info(test_root, 'current_not_master', set_current_not_master)
      save_set_info(test_root, 'master_not_current', set_master_not_current)
      save_set_info(test_root, 'changed_master', set_changed_master)
    end

    def save_set_info(test_root, suffix, data_set)
      filename = File.join(::DomGlancy.configuration.diff_file_location, "#{test_root}__#{suffix}__diff.yaml")

      data_array = data_set.to_a

      File.open(filename, 'w') { |file| file.write(data_array.to_yaml) }
    end

    def get_set_of_same_but_different(set1, set2)
      same_but_different_pairs = []
      set1.each do |item1|
        element1 = DOMElement.new(item1)
        set2.each do |item2|
          element2 = DOMElement.new(item2)
          if element1.same_element?(element2)
            same_but_different_pairs << [item1, item2]
          end
        end
      end
      same_but_different_pairs
    end

    def pairs_that_are_close_enough(set1, set2)
      ok_pairs = []
      set1.each do |item1|
        element1 = DOMElement.new(add_similarity(item1))
        set2.each do |item2|
          element2 = DOMElement.new(add_similarity(item2))
          if element1.same_element?(element2) && element1.close_enough?(element2)
            ok_pairs << [item1, item2]
          end
        end
      end
      ok_pairs
    end

    def add_similarity(element)
      element.merge('similarity' => ::DomGlancy.configuration.similarity)
    end
  end
end
