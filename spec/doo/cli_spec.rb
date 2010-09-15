require 'doo/cli'

describe Doo::CLI::Options do
  it "should message and error on no args" do
    lambda { Doo::CLI::Options.parse!([]) }.should raise_error SystemExit
  end

  it "should message and error on --help" do
    lambda { Doo::CLI::Options.parse!(["--help"]) }.should raise_error SystemExit
  end

  it "should set on --dry-run" do
    Doo::CLI::Options.parse!(["-d", "foo"]).member?(:dry_run).should == true
  end

  it "should set on --verbose" do
    Doo::CLI::Options.parse!(["-v", "foo"]).member?(:verbose).should == true
  end

  it "should set variables" do
    Doo::CLI::Options.parse!(["-swoz=bar", "foo"])["woz"].should == "bar"
  end

  it "should pull off varialbes and leave files" do
    args = ["-d", "foo", "bar"]
    Doo::CLI::Options.parse!(args)
    args.should == ["foo", "bar"]
  end

  it "should run all files" do
    ARGV = ["-d", "foo", "bar"]
    inst = Doo::Base.new
    Doo::Base.should_receive(:new).and_return inst
    inst.should_receive(:load).with("foo")
    inst.should_receive(:load).with("bar")        
    Doo::CLI.start
  end
end