module Roller
  def self.roll(count, type)
    safe_count = count.to_i.to_s # escape any nasty "; sudo halt"s
    safe_type  = type.to_i.to_s
    return `#{bin_path} #{safe_count} #{safe_type}`
  end

  private

  def self.bin_path
    File.join(__dir__, "..", "..", "roller", "bin", "rollpaths")
  end
end

