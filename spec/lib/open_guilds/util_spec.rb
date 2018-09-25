RSpec.describe OpenGuilds::Util do
  describe '#object_from' do
    let(:result) { described_class.object_from(example_object_hash) }
    it 'should return the correct object' do
      expect(result).to be_a OpenGuilds::Batch
    end
  end

  describe "#encode_parameters" do
    it " should prepare parameters for an HTTP request" do
      params = {
        a: 3,
        b: "+foo?",
        c: "bar&baz",
        d: { a: "a", b: "b" },
        e: [0, 1],
        f: "",

        # note the empty hash won't even show up in the request
        g: [],
      }

      expect(
        OpenGuilds::Util.encode_parameters(params)
      ).to eq expected_encoded_params
    end
  end

  describe '#url_encode' do
    it "should prepare strings for HTTP" do
      expect(OpenGuilds::Util.url_encode("foo")).to eq "foo"
      expect(OpenGuilds::Util.url_encode(:foo)).to eq "foo"
      expect(OpenGuilds::Util.url_encode("foo+")).to eq "foo%2B"
      expect(OpenGuilds::Util.url_encode("foo&")).to eq "foo%26"
      expect(OpenGuilds::Util.url_encode("foo[bar]")).to eq "foo[bar]"
    end
  end

  describe '#flatten_params' do
    it "should encode parameters according to Rails convention" do
      params = [
        [:a, 3],
        [:b, "foo?"],
        [:c, "bar&baz"],
        [:d, { a: "a", b: "b" }],
        [:e, [0, 1]],
        [:f, [
          { foo: "1", ghi: "2" },
          { foo: "3", bar: "4" },
        ],],
      ]

      expect(
        OpenGuilds::Util.flatten_params(params)
      ).to eq params_array
    end
  end

  def expected_encoded_params
    "a=3&b=%2Bfoo%3F&c=bar%26baz&d[a]=a&d[b]=b&e[0]=0&e[1]=1&f="
  end

  def params_array
    [
      ["a", 3],
      ["b",        "foo?"],
      ["c",        "bar&baz"],
      ["d[a]",     "a"],
      ["d[b]",     "b"],
      ["e[0]",      0],
      ["e[1]",      1],

      # *The key here is the order*. In order to be properly interpreted as
      # an array of hashes on the server, everything from a single hash must
      # come in at once. A duplicate key in an array triggers a new element.
      ["f[0][foo]", "1"],
      ["f[0][ghi]", "2"],
      ["f[1][foo]", "3"],
      ["f[1][bar]", "4"],
    ]
  end

  def example_object_hash
{"id"=>7, "data"=>[{"id"=>209, "object"=>"Datum", "status"=>"completed", "parameters"=>{"data"=>"\"[{\\\"id\\\":0,\\\"text\\\":\\\"asfaslkfnasf\\\",\\\"start\\\":\\\"00:00\\\",\\\"end\\\":\\\"00:00\\\",\\\"subject\\\":\\\"Speaker\\\"}]\"", "audioUrl"=>"https://wetranscribe.s3.amazonaws.com/uploads/chunk/audio/589/converted.wavchunk-45.wav"}, "contracts_count"=>1}, {"id"=>210, "object"=>"Datum", "status"=>"completed", "parameters"=>{"data"=>"\"[{\\\"id\\\":0,\\\"text\\\":\\\"asfaksf\\\",\\\"start\\\":\\\"00:00\\\",\\\"end\\\":\\\"00:00\\\",\\\"subject\\\":\\\"Speaker\\\"}]\"", "audioUrl"=>"https://wetranscribe.s3.amazonaws.com/uploads/chunk/audio/588/converted.wavchunk-30.wav"}, "contracts_count"=>1}, {"id"=>211, "object"=>"Datum", "status"=>"completed", "parameters"=>{"data"=>"\"[{\\\"id\\\":0,\\\"text\\\":\\\"askangspajg\\\",\\\"start\\\":\\\"00:00\\\",\\\"end\\\":\\\"00:00\\\",\\\"subject\\\":\\\"Speaker\\\"}]\"", "audioUrl"=>"https://wetranscribe.s3.amazonaws.com/uploads/chunk/audio/587/converted.wavchunk-15.wav"}, "contracts_count"=>1}, {"id"=>212, "object"=>"Datum", "status"=>"completed", "parameters"=>{"data"=>"\"[{\\\"id\\\":0,\\\"text\\\":\\\"aslkasgkajsg\\\",\\\"start\\\":\\\"00:00\\\",\\\"end\\\":\\\"00:00\\\",\\\"subject\\\":\\\"Speaker\\\"}]\"", "audioUrl"=>"https://wetranscribe.s3.amazonaws.com/uploads/chunk/audio/586/converted.wavchunk-0.wav"}, "contracts_count"=>1}, {"id"=>208, "object"=>"Datum", "status"=>"completed", "parameters"=>{"data"=>"\"[{\\\"id\\\":0,\\\"text\\\":\\\"hlkmhkh\\\",\\\"start\\\":\\\"00:00\\\",\\\"end\\\":\\\"00:00\\\",\\\"subject\\\":\\\"Speaker\\\"}]\"", "audioUrl"=>"https://wetranscribe.s3.amazonaws.com/uploads/chunk/audio/590/converted.wavchunk-4.wav"}, "contracts_count"=>1}], "object"=>"Batch", "status"=>"Completed", "completed"=>true, "fraction_completed"=>"5/5"}
  end
end
