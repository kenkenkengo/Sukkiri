RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title(page_title)" do
    subject { full_title(page_title) }

    context "page_titleがnilの時" do
      let(:page_title) { nil }

      it { is_expected.to eq("Sukkiri") }
    end

    context "page_titleがemptyの時" do
      let(:page_title) { "" }

      it { is_expected.to eq("Sukkiri") }
    end

    context "page_titleが存在する時" do
      let(:page_title) { "hogehoge" }

      it { is_expected.to eq("hogehoge | Sukkiri") }
    end
  end
end
