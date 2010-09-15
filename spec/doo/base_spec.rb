require 'tempfile'
require 'doo/base'

describe Doo::Base do
  
  before :each do
    @inst = Doo::Base.new
  end
  
  it "can read in other files" do
    @inst.should_receive("spamcan").once
    Tempfile.open(nil) do |tmpfile|
      tmpfile.puts("spamcan")
      tmpfile.rewind
      @inst.load(tmpfile.path)
    end    
  end
  
  it "sets itself up properly" do
    inst = Doo::Base.new(:extra => "cheeps")    
    inst.should respond_to :extra
    inst.extra.should == "cheeps"
  end  

  it "knows how to add context to itself" do
    @inst.using(:extra => "ham")
    @inst.should respond_to :extra
    @inst.extra.should == "ham"
  end
  
  it "knows how to set a variable" do
    @inst.set :extra, "bologna"
    @inst.should respond_to :extra
    @inst.extra.should == "bologna"
  end
  
  it "knows how to set a block" do
    @inst.set :extra do
      its_not_real_meat
    end
    @inst.should respond_to :extra
    @inst.should_receive(:its_not_real_meat).exactly(1).times
    @inst.extra
  end
  
  it "returns a clone of itself" do
    @inst.instance_eval do
      def something_extra
        "bacon"
      end
    end
    @inst.with_clone.something_extra.should == "bacon"
  end
  
  it "runs code in a clone" do
    @inst.instance_eval do
      def something_extra
        "bacon"
      end
    end
    @inst.with_clone do      
      something_extra.should == "bacon"
    end
    @inst.should_receive(:something_extra).exactly(0).times
  end
  
  it "sets variables in the clone but not in itself" do
    @inst.with_clone(:extra => "fries") do
      extra.should == "fries"
    end
    @inst.should_not respond_to :extra
  end
end