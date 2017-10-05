require 'spec_helper'
describe 'pkgcheckupdates' do
  context 'with default values for all parameters' do
    it { should contain_class('pkgcheckupdates') }
  end
end
