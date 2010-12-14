Doo::Base.class_eval do
  SEPARATORS = %w( / @ : | _ - # ^ ? )

  def replace(file, src, replace, options = {})
    sep = SEPARATORS.detect { |x| !src.include?(x) && !replace.include?(x) }
    sudo "sed -i -e 's#{sep}#{src}#{sep}#{replace}#{sep}g' #{file}"
  end
  
  def append(file, text, options = {})
    sudo "grep '#{text}' #{file} || echo '#{text}' >> #{file}"
  end
end
