# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

require "problem-47.rb"

class Object
    def ok()
        self.should == true
    end
    def not_ok()
        self.should == false
    end
end

describe "num_distinct_factors(2)" do
    it "should be 1" do
        num_distinct_factors(2).should == 1
    end
end

describe "num_distinct_factors(3)" do
    it "should be 1" do
        num_distinct_factors(3).should == 1
    end
end

describe "num_distinct_factors(10)" do
    it "should be 2" do
        num_distinct_factors(10).should == 2
    end
end

describe "num_distinct_factors(15,2)" do
    it "should be 2" do
        num_distinct_factors(15).should == 2
    end
end

describe "num_distinct_factors(2*3*5^2,2)" do
    it "should be 3" do
        num_distinct_factors(2*3*5*5).should == 3
    end
end
