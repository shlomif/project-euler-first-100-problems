# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

require "code.rb"

describe "Testing" do
    it "should yield good results" do
        expect(23.continued_fraction).to eq([[4],[1,3,1,8]])
        expect(2.continued_fraction).to eq([[1],[2]])
        expect(3.continued_fraction).to eq([[1],[1,2]])
        expect(5.continued_fraction).to eq([[2],[4]])
        expect(6.continued_fraction).to eq([[2],[2,4]])
    end
end
