require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GTFS::Agency do
  describe 'Agency.parse_agencies' do
    let(:header_line) {"agency_id,agency_name,agency_url,agency_timezone,agency_lang,agency_phone,agency_extension\n"}
    let(:invalid_header_line) {"agency_id,agency_url,agency_timezone,agency_lang,agency_phone\n"}
    let(:valid_line) {"1,Maryland Transit Administration,http://www.mta.maryland.gov,America/New_York,en,410-539-5000,test\n"}
    let(:invalid_line) {"1,,http://www.mta.maryland.gov,America/New_York,en,410-539-5000\n"}

    subject {GTFS::Agency.parse_agencies(source_text, opts)}

    include_examples 'models'
    
    describe 'Check extension' do
      let(:opts) {{}}
      let(:source_text) {header_line + valid_line}
      
      its(:size) {should == 1}
      
      it "should have an extension-hash" do
      	subject[0].should be_kind_of(GTFS::Agency)
      	subject[0].extension_attrs.should be_kind_of(Hash)
      	subject[0].extension_attrs.should have_key('extension')
      	expect(subject[0].extension_attrs['extension']).to eq('test')
      	expect(subject[0].extension_attrs.size).to eq(1)
      end
      
    end

  end
end
