require "rspec"
require "05_my_hash_set"

describe MyHashSet do
  let(:set1) { MyHashSet.new }
  let(:set2) { MyHashSet.new }
  #Added to test bonus features
  let(:object)  {String}
  let(:set3) { MyHashSet.new }

  describe "#include?" do
    context "when the element has been inserted" do
      it "returns true" do
        set1.insert("foo")

        expect(set1.include?("foo")).to be_truthy
      end
    end

    context "when the element has not been inserted" do
      it "returns false" do
        expect(set1.include?("foo")).to be_falsey
      end
    end
  end

  describe "#delete" do
    it "removes an element from the set" do
      set1.insert("bar")
      expect(set1.include?("bar")).to be_truthy

      set1.delete("bar")

      expect(set1.include?("bar")).to be_falsey
    end
  end

  describe "#to_a" do
    it "returns an array" do
      expect(set1.to_a).to be_an(Array)
    end

    it "returns an array containing each element of the set" do
      elements = %w(Hydrogen Helium Lithium Beryllium)
      elements.each { |el| set1.insert(el) }

      expect(set1.to_a).to contain_exactly(*elements)
    end
  end

  describe "set interaction methods" do
    before(:each) do
      set1.insert("Mark Hamill")
      set1.insert("Harrison Ford")
      set1.insert("Anthony Daniels")

      set2.insert("Ewan McGregor")
      set2.insert("Natalie Portman")
      set2.insert("Anthony Daniels")

      #Added to test bonus features
      set3.insert("Ewan McGregor")
      set3.insert("Natalie Portman")
    end

    describe "#union" do
      it "returns a new set" do
        expect(set1.union(set2)).to be_a(MyHashSet)
      end

      it "returns a set containing elements in EITHER set" do
        els = set1.union(set2).to_a

        expect(els).to contain_exactly(
          "Mark Hamill",
          "Harrison Ford",
          "Anthony Daniels",
          "Ewan McGregor",
          "Natalie Portman"
        )
      end
    end

    describe "#intersect" do
      it "returns a new set" do
        expect(set1.intersect(set2)).to be_a(MyHashSet)
      end

      it "returns a set containing elements in BOTH sets" do
        els = set1.intersect(set2).to_a

        expect(els).to contain_exactly("Anthony Daniels")
      end
    end

    describe "#minus" do
      it "returns a new set" do
        expect(set1.minus(set2)).to be_a(MyHashSet)
      end

      it "returns a set containing elements ONLY in the first set" do
        els = set1.minus(set2).to_a

        expect(els).to contain_exactly(
          "Mark Hamill",
          "Harrison Ford"
        )
      end
    end

    #Added to test bonus features
    describe "#symetric_difference" do
      it "returns a new set" do
        expect(set1.symetric_difference(set2)).to be_a(MyHashSet)
      end

      it "returns a set containing elements not present in both sets" do
        els = set1.symetric_difference(set2).to_a

        expect(els).to contain_exactly(
          "Mark Hamill",
          "Harrison Ford",
          "Ewan McGregor",
          "Natalie Portman"
        )
      end
    end

    describe "#==" do
      it "object is a MyHashSet" do
        expect(set1==object).to be_falsey
      end

      it "checks both sets have equal lengths" do
        expect(set1==set3).to be_falsey
      end

      it "checks that every element of set2 is in set2" do
        expect(set2==set2).to be_truthy
      end
    end

  end
end