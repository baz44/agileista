require 'spec_helper'

describe SprintsController, :type => :controller do
  it "should be an abstract_security_controller" do
    controller.is_a?(AbstractSecurityController).should be_true
  end
end