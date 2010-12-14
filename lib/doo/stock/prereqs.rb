Doo::Base.class_eval do
  def if_passes(test, &block)
    yield if run "#{test}"
  end
  
  def if_fails(test, &block)
    yield unless run "#{test}"
  end
end
