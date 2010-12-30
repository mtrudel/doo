Doo::Base.class_eval do
  def if_passes(test, &block)
    yield unless run "#{test}", :return_on_failure => true
  end
  
  def if_fails(test, &block)
    yield if run "#{test}", :return_on_failure => true
  end  
end
