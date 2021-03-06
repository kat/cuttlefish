require 'spec_helper'

describe EmailsHelper do
  describe ".bootstrap_status_class" do
    it { helper.bootstrap_status_class("delivered").should == "success"}
    it { helper.bootstrap_status_class("soft_bounce").should == "warning"}
    it { helper.bootstrap_status_class("hard_bounce").should == "error"}
    it { helper.bootstrap_status_class("unknown").should be_nil}
    it { expect {helper.bootstrap_status_class("foo") }.to raise_error }
  end

  describe ".delivered_label" do
    it { helper.delivered_label("delivered").should == '<span class="label label-success">Delivered</span>' }
    it { helper.delivered_label("soft_bounce").should == '<span class="label label-warning">Soft bounce</span>' }
    it { helper.delivered_label("hard_bounce").should == '<span class="label label-important">Hard bounce</span>' }
    it { helper.delivered_label("unknown").should == '<span class="label ">Unknown</span>' }
    it { expect {helper.delivered_label("foo")}.to raise_error }
  end
end
