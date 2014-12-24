module DomGlancy
  class Analyzer
    attr_reader :set_current_not_master
    attr_reader :set_master_not_current
    attr_reader :set_changed_master
    attr_reader :changed_element_pairs

    @master_data
    @current_data
    @test_root

    def initialize(master_data, current_data, test_root = nil)
      @master_data  = master_data
      @current_data = current_data
      @test_root    = test_root
    end

    def analyze
      clear_results

      if missing_elements? || extra_elements?
        remove_similar_elements
        extract_changed_elements
      end

      # create_diff_file if @test_root && !all_same?
      compile_results
    end

    private

    def clear_results
      master_set = @master_data.to_set
      current_set = @current_data.to_set

      @set_current_not_master = current_set - master_set
      @set_master_not_current = master_set - current_set
      @set_changed_master = Set.new

      @changed_element_pairs = []
    end

    def compile_results
      {
        not_in_master:         @set_current_not_master,
        not_in_current:        @set_master_not_current,
        changed_element_pairs: @changed_element_pairs,
        changed_master:        @set_changed_master,
        test_root:             @test_root,
        same:                  all_same?
      }
    end

    def all_same?
      @set_current_not_master.count == 0 && @set_master_not_current.count == 0 && @changed_element_pairs.count == 0
    end

    def missing_elements?
      @set_master_not_current.count > 0
    end

    def extra_elements?
      @set_current_not_master.count > 0
    end

    def remove_similar_elements
      ok_pairs = similar_pairs(@set_current_not_master, @set_master_not_current)

      ok_pairs.each do |item1, item2|
        @set_current_not_master.delete(item1)
        @set_master_not_current.delete(item2)
      end
    end

    def extract_changed_elements
      @changed_element_pairs = []

      @set_current_not_master.each do |item1|           # in current
        element1 = DOMElement.new(item1)
        @set_master_not_current.each do |item2|         # in master
          element2 = DOMElement.new(item2)
          if element1.same_element?(element2)
            @changed_element_pairs << [item1, item2]    # [current version, master version]
          end
        end
      end

      remove_elements_from_data_sets @changed_element_pairs

      @changed_element_pairs.select!{ |pair| !DOMElement.new(add_similarity(pair[0])).close_enough?(DOMElement.new(add_similarity(pair[1]))) }

      @changed_element_pairs.each do |pair|
        current_element = pair[0].dup
        master_element  = pair[1].dup
        current_element['was'] = master_element
        @set_changed_master.add(current_element)
      end
    end

    def remove_elements_from_data_sets(element_pairs)
      element_pairs.each do |element_1, element_2|
        remove_element_from_data_sets element_1
        remove_element_from_data_sets element_2
      end
    end

    def remove_element_from_data_sets(element)
      @set_current_not_master.delete element
      @set_master_not_current.delete element
    end

    def similar_pairs(set1, set2)
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
