describe Votes do
  describe "validations" do
    describe "value validations" do
      it "only allows -1 or 1 as values" do
        expect ( vote ).to eq( 1 || -1 )
      end
    end
  end
end