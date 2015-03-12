require "spec_helper"

describe Array do
	context "#all_empty?" do
		it "returns true if all elements of the Array are empty" do
			expect(["","",""].all_empty?).to be_truthy
		end

		it "returns false if all elements of the Array are not empty" do
			expect(["", 1, "", Object.new, :a].all_empty?).to be_falsey
    	end

    	it "returns true for an empty array" do
    		expect([].all_empty?).to be_truthy
    	end
    end

    context "#any_empty?" do
    	it "returns true if all elements of the array are empty" do
    		expect(["","",""].any_empty?).to be_truthy
    	end

    	it "returns true if any elements of the array are empty" do
    		expect(["dfa","","faf"].any_empty?).to be_truthy
    	end

    	it "returns false if none elements of the array are empty" do
    		expect(["hi","hello","hey"].any_empty?).to be_falsey
    	end
    end

    context "#none_empty?" do
    	it "returns true if none of the array elements are empty" do
    		expect(["dfa","HI!","faf"].none_empty?).to be_truthy
    	end

    	it "returns false if one of the array elements is empty" do
    		expect(["dfa","HI!",""].none_empty?).to be_falsey
    	end
    end

end