require File.join(File.dirname(__FILE__), '../../test_helper')

describe HammerCLI::Output::Adapter::Base do

  let(:adapter) { HammerCLI::Output::Adapter::Base.new }

  context "print_collection" do

    let(:field_name) { Fields::DataField.new(:path => [:name], :label => "Name") }
    let(:fields) {
      [field_name]
    }
    let(:data) { HammerCLI::Output::RecordCollection.new [{
      :name => "John Doe"
    }]}

    it "should print field name" do
      proc { adapter.print_collection(fields, data) }.must_output(/.*Name[ ]*:.*/, "")
    end

    it "should print field value" do
      proc { adapter.print_collection(fields, data) }.must_output(/.*John Doe.*/, "")
    end

  end

end
