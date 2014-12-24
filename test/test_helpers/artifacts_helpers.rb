module TestHelpers
  module Artifacts
    def assert_artifacts_on_difference(test_root)
      fnb = DomGlancy::FileNameBuilder.new(test_root)

      filename = fnb.diff
      assert File.exists?(filename), "Diff file should exist: #{filename}"

      filename = File.join(DomGlancy.configuration.diff_file_location, "#{test_root}__changed_master__diff.yaml")
      assert File.exists?(filename), "Changed master file should exist: #{filename}"

      filename = File.join(DomGlancy.configuration.diff_file_location, "#{test_root}__current_not_master__diff.yaml")
      assert File.exists?(filename), "Current, not master, file should exist: #{filename}"

      filename = File.join(DomGlancy.configuration.diff_file_location, "#{test_root}__master_not_current__diff.yaml")
      assert File.exists?(filename), "Master, not current, file should exist: #{filename}"

      filename = File.join(DomGlancy.configuration.diff_file_location, "#{test_root}__changed_pairs__diff.yaml")
      assert File.exists?(filename), "Changed pairs file should exist: #{filename}"

      filename = fnb.master
      assert File.exists?(filename), "Master file should exist: #{filename}"

      filename = fnb.current
      assert File.exists?(filename), "Current file should exist: #{filename}"
    end

    def assert_artifacts_on_same(test_root)
      fnb = DomGlancy::FileNameBuilder.new(test_root)

      filename = fnb.diff
      refute File.exists?(filename), "No diff file should exist: #{filename}"

      filename = File.join(DomGlancy.configuration.diff_file_location, "#{test_root}__changed_master__diff.yaml")
      refute File.exists?(filename), "No changed master file should exist: #{filename}"

      filename = File.join(DomGlancy.configuration.diff_file_location, "#{test_root}__current_not_master__diff.yaml")
      refute File.exists?(filename), "No current, not master, file should exist: #{filename}"

      filename = File.join(DomGlancy.configuration.diff_file_location, "#{test_root}__master_not_current__diff.yaml")
      refute File.exists?(filename), "No master, not current, file should exist: #{filename}"

      filename = File.join(DomGlancy.configuration.diff_file_location, "#{test_root}__changed_pairs__diff.yaml")
      refute File.exists?(filename), "No master changed pairs file should exist: #{filename}"

      filename = fnb.master
      assert File.exists?(filename), "Master file should exist: #{filename}"

      filename = fnb.current
      refute File.exists?(filename), "No current file should exist: #{filename}"
    end

  end
end
