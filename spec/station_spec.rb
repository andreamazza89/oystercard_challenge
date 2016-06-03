
require 'station'


describe Station do

	subject(:station) {described_class.new(:zone, :name)}

	it "Has an assigned zone" do
		expect(station.zone).to eq (:zone)
	end

	it "Has a name" do 
		expect(station.name).to eq (:name)
	end

end
	
# 	it 'Holds an empty array called zone' do
# 		expect(subject.zone).to respond_to (:empty?)
# 	end

# 	it " name" do
# end

