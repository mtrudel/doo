Doo::Base.class_eval do
  def prereq(cmd)
    raise PrerequisiteFailure unless run cmd == true
  end
  
  def check_prereqs
    begin
      yield
    rescue PrerequisiteFailure
      puts "Pre-requisite test failed: ##{$!}"
    end
  end
end
