Doo::Base.class_eval do
  def if_passes(test, &block)
    yield unless run "#{test}", :just_return_failure => true
  end
  
  def if_fails(test, &block)
    yield if run "#{test}", :just_return_failure => true
  end  
end
